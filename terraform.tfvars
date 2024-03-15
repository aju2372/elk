#common
aws_profile = "infra360io"
region      = "ap-south-1"

#module "jenkins"
vpc_name                    = "infra360io-prod"
app_name                    = "elk"
custom_string               = "infra360io"
subnet_tag                  = "subnet_type"
environment                 = "prod"
subnet_tag_value            = "public"
instance_type               = "t3.medium"
key_name                    = "infra360io"
host_header                 = "kibana.infra360.io"
health_check_path           = "/status"
create_iam_role             = "true"
associate_public_ip_address = true
az                          = "ap-south-1b"
target_group_port           = "80"
common_tags = {
  "owner"     = "deepak010789@gmail.com"
  "env"       = "prod"
  "terraform" = "true"
  "project"   = "elk"
  "purpose"   = "logging"
}
