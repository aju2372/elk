variable "aws_profile" {
  type        = string
  default     = "default"
  description = "Region id for S3 Bucket to be used as backend"
}

variable "region" {
  description = "The AWS region to create things in."
  type        = string
}

variable "custom_string" {
  description = "Initials for any service"
  type        = string
  default     = "custom"
}

variable "common_tags" {
  type = map(string)
}

variable "instance_type" {
  type        = string
  description = "EC2 Instance type"
}

variable "vpc_name" {
  description = "VPC Name for the AWS account and region specified"
  type        = string
}

variable "subnet_tag" {
  description = "Tag used on subnets to define Tier"
  type        = string
}

variable "subnet_tag_value" {
  description = "Subnet tag on private subnets"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "key_name" {
  description = "EC2 SSH Key Pair name"
  type        = string
}
variable "create_iam_role" {
  type        = bool
  description = "Boolean for adding IAM role or not"
}
variable "target_group_port" {
  type        = number
  description = "Target Group Port"
}
variable "health_check_path" {
  type        = string
  description = "Health check path"
}
variable "az" {
  type        = string
  description = "Availability zone id"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Whether to associate public ip with the server or not"
}
