terraform {

  backend "s3" {
    bucket = "terraform-state-sharooshan"
    key    = "windows-vm/terraform.tfstate"
    region = "eu-north-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

locals {
  common_tags = {
    Environment = var.environment
    Owner       = var.owner
    Project     = var.project
  }
}

# data "aws_secretsmanager_secret" "windows_secret" {
#   name = "windows-admin-creds"
# }

resource "aws_security_group" "windows_sg" {

  name   = "github-actions-windows-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "RDP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}

resource "aws_instance" "windows_vm" {

  ami           = "ami-07483e30c9d08daa8"
  instance_type = var.instance_type

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.windows_sg.id]

  tags = merge(
    local.common_tags,
    {
      Name = "GitHubActions-WindowsVM"
    }
  )
}