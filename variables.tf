variable "region" {
  description = "AWS Region"
  default     = "eu-north-1"
}

variable "vpc_id" {
  description = "Existing VPC ID"
}

variable "subnet_id" {
  description = "Existing Subnet ID"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  default     = "t3.micro"
}

variable "environment" {
  description = "Environment"
  default     = "DEV"
}

variable "owner" {
  description = "VM Owner"
  default     = "Sharooshan"
}

variable "project" {
  description = "Project Name"
  default     = "GitHubActions-Terraform"
}