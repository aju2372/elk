data "cloudinit_config" "cloud_init_elk" {
  gzip          = false
  base64_encode = true

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = templatefile("${path.module}/init/cloud-init.cfg", {})
  }
}

module "elasticsearch" {
  source                      = "../../terraform-modules/ec2_tg"
  vpc_name                    = var.vpc_name
  app_name                    = "elasticsearch"
  custom_string               = var.custom_string
  subnet_tag                  = var.subnet_tag
  subnet_tag_value            = var.subnet_tag_value
  environment                 = var.environment
  instance_type               = var.instance_type
  health_check_path           = var.health_check_path
  target_group_port           = var.target_group_port
  image_id                    = data.aws_ami.ubuntu.id
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  az                          = var.az
  list_of_extra_sg_ids        = [data.aws_security_group.common_sg_id.id]
  create_iam_role             = var.create_iam_role
  host_header                 = "elasticsearch.infra360.io"
  user_data                   = data.cloudinit_config.cloud_init_elk.rendered
  managed_policy_arns_server  = ["arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"]
}

module "logstash" {
  source                      = "../../terraform-modules/ec2_tg"
  vpc_name                    = var.vpc_name
  app_name                    = "logstash"
  custom_string               = var.custom_string
  subnet_tag                  = var.subnet_tag
  subnet_tag_value            = var.subnet_tag_value
  environment                 = var.environment
  instance_type               = var.instance_type
  health_check_path           = var.health_check_path
  target_group_port           = var.target_group_port
  image_id                    = data.aws_ami.ubuntu.id
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  az                          = var.az
  list_of_extra_sg_ids        = [data.aws_security_group.common_sg_id.id]
  create_iam_role             = var.create_iam_role
  host_header                 = "logstash.infra360.io"
  user_data                   = data.cloudinit_config.cloud_init_elk.rendered
  managed_policy_arns_server  = ["arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"]
}

module "kibana" {
  source                      = "../../terraform-modules/ec2_tg"
  vpc_name                    = var.vpc_name
  app_name                    = "kibana"
  custom_string               = var.custom_string
  subnet_tag                  = var.subnet_tag
  subnet_tag_value            = var.subnet_tag_value
  environment                 = var.environment
  instance_type               = var.instance_type
  health_check_path           = var.health_check_path
  health_check_port           = 5601
  target_group_port           = 5601 #var.target_group_port
  image_id                    = data.aws_ami.ubuntu.id
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  az                          = var.az
  list_of_extra_sg_ids        = [data.aws_security_group.common_sg_id.id]
  create_iam_role             = var.create_iam_role
  host_header                 = "kibana.infra360.io"
  user_data                   = data.cloudinit_config.cloud_init_elk.rendered
  managed_policy_arns_server  = ["arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"]
}

#dns record creation for es,logstash & kibana
resource "aws_route53_record" "es" {
  zone_id = data.aws_route53_zone.private.zone_id
  name    = "es.internal-infra360.io"
  type    = "A"
  ttl     = 60
  records = [module.elasticsearch.server_private_ip]
}

resource "aws_route53_record" "kibana" {
  zone_id = data.aws_route53_zone.private.zone_id
  name    = "kibana.internal-infra360.io"
  type    = "A"
  ttl     = 60
  records = [module.kibana.server_private_ip]
}

resource "aws_route53_record" "logstash" {
  zone_id = data.aws_route53_zone.private.zone_id
  name    = "logstash.internal-infra360.io"
  type    = "A"
  ttl     = 60
  records = [module.logstash.server_private_ip]
}

#for create security group rule for 9200(on ES server), 8200(For apm on ES server) & 5601(kibana)
resource "aws_security_group_rule" "server_elasticsearch_port" {
  security_group_id = module.elasticsearch.server_sg_id
  type              = "ingress"
  from_port         = 9200
  to_port           = 9200
  protocol          = "tcp"
  description       = "Traffic for my vpc network for elasticsearch"
  cidr_blocks       = [data.aws_vpc.vpc.cidr_block]
}

resource "aws_security_group_rule" "server_apm-server_port" {
  security_group_id = module.elasticsearch.server_sg_id
  type              = "ingress"
  from_port         = 8200
  to_port           = 8200
  protocol          = "tcp"
  description       = "Traffic for my vpc network for apm-server"
  cidr_blocks       = [data.aws_vpc.vpc.cidr_block]
}

resource "aws_security_group_rule" "logstash-server_port" {
  security_group_id = module.logstash.server_sg_id
  type              = "ingress"
  from_port         = 5044
  to_port           = 5044
  protocol          = "tcp"
  description       = "Traffic for my vpc network for logstash-server"
  cidr_blocks       = [data.aws_vpc.vpc.cidr_block]
}
