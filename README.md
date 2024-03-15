# terraform-elk

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.31.0 |
| <a name="requirement_cloudinit"></a> [cloudinit](#requirement\_cloudinit) | 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.31.0 |
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_elasticsearch"></a> [elasticsearch](#module\_elasticsearch) | ../terraform-modules/ec2_tg | n/a |
| <a name="module_kibana"></a> [kibana](#module\_kibana) | ../terraform-modules/ec2_tg | n/a |
| <a name="module_logstash"></a> [logstash](#module\_logstash) | ../terraform-modules/ec2_tg | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.es](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.kibana](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.logstash](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group_rule.logstash-server_port](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.server_apm-server_port](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.server_elasticsearch_port](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_route53_zone.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_security_group.common_sg_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [cloudinit_config.cloud_init_elk](https://registry.terraform.io/providers/hashicorp/cloudinit/2.2.0/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | Whether to associate public ip with the server or not | `bool` | n/a | yes |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | Region id for S3 Bucket to be used as backend | `string` | `"default"` | no |
| <a name="input_az"></a> [az](#input\_az) | Availability zone id | `string` | n/a | yes |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | n/a | `map(string)` | n/a | yes |
| <a name="input_create_iam_role"></a> [create\_iam\_role](#input\_create\_iam\_role) | Boolean for adding IAM role or not | `bool` | n/a | yes |
| <a name="input_custom_string"></a> [custom\_string](#input\_custom\_string) | Initials for any service | `string` | `"custom"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | n/a | yes |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | Health check path | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 Instance type | `string` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | EC2 SSH Key Pair name | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region to create things in. | `string` | n/a | yes |
| <a name="input_subnet_tag"></a> [subnet\_tag](#input\_subnet\_tag) | Tag used on subnets to define Tier | `string` | n/a | yes |
| <a name="input_subnet_tag_value"></a> [subnet\_tag\_value](#input\_subnet\_tag\_value) | Subnet tag on private subnets | `string` | n/a | yes |
| <a name="input_target_group_port"></a> [target\_group\_port](#input\_target\_group\_port) | Target Group Port | `number` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC Name for the AWS account and region specified | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ami_id"></a> [ami\_id](#output\_ami\_id) | n/a |
| <a name="output_elasticsearch_private_ip"></a> [elasticsearch\_private\_ip](#output\_elasticsearch\_private\_ip) | n/a |
| <a name="output_elasticsearch_sg_id"></a> [elasticsearch\_sg\_id](#output\_elasticsearch\_sg\_id) | n/a |
| <a name="output_kibana_private_ip"></a> [kibana\_private\_ip](#output\_kibana\_private\_ip) | dns record creation for es,logstash & kibana |
| <a name="output_kibana_sg_id"></a> [kibana\_sg\_id](#output\_kibana\_sg\_id) | To create security group rule for 9200(on ES server), 8200(For apm on ES server) & 5601(kibana) |
| <a name="output_logstash_private_ip"></a> [logstash\_private\_ip](#output\_logstash\_private\_ip) | n/a |
| <a name="output_logstash_sg_id"></a> [logstash\_sg\_id](#output\_logstash\_sg\_id) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
