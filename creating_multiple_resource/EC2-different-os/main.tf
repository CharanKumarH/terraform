# This Terraform fro creating multiple os in multiple 
# vpc [ subnet_1 = [ec2 of amazon], subnet_2 = [ec2 of ubuntu] ] same in multiple VPCs

terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta3"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

locals {
  vpc_number      = 2 # Change this to create more VPCs
  subnets_per_vpc = 2
}

resource "aws_vpc" "my_vpc" {

  count      = local.vpc_number
  cidr_block = "10.${count.index}.0.0/16"
  tags = {
    Name = "my_vpc-${count.index}"
  }


}

resource "aws_subnet" "mysubnet" {
  count      = local.vpc_number * local.subnets_per_vpc
  vpc_id     = aws_vpc.my_vpc[floor(count.index / local.subnets_per_vpc)].id
  cidr_block = "10.${floor(count.index / local.subnets_per_vpc)}.${count.index}.0/24"
  tags = {
    Name = "my_demo_subnet-${count.index}"
  }
}

resource "aws_instance" "main_instance" {
  count         = local.vpc_number * local.subnets_per_vpc
  ami           = var.ec2_config[count.index % length(var.ec2_config)].ami
  instance_type = var.ec2_config[count.index % length(var.ec2_config)].instance_type
  subnet_id     = element(aws_subnet.mysubnet[*].id, count.index % length(aws_subnet.mysubnet))

  tags = {
    Name = "my_instance-${count.index}"
  }
}


output "output" {
  value = {
      vpc_subnet_instance_id = [aws_vpc.my_vpc[*].id, aws_instance.main_instance[*].subnet_id, aws_instance.main_instance[*].id]
    
  }
}
