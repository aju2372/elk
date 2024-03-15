data "aws_vpc" "vpc" {
  state = "available"

  tags = {
    "Name" = var.vpc_name
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

#zone id for record creation
data "aws_route53_zone" "private" {
  name         = "internal-infra360.io"
  private_zone = true
}

#Common SG id
data "aws_security_group" "common_sg_id" {
  name = "infra360io-common-prod-sg"
}
