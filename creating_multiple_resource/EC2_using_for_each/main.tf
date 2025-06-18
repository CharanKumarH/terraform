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
  vpc_number      = 1 # Change this to create more VPCs
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
  for_each      = var.ec2_map
  ami           = each.value.ami
  instance_type = each.value.instance_type

  subnet_id = element(
  aws_subnet.mysubnet[*].id,
  index(keys(var.ec2_map), each.key) % length(aws_subnet.mysubnet)
)


  tags = {
    Name = "my_instance-${each.key}"
  }
}

output "names" {
  value = {
    for_each      = var.ec2_map
    index = index(keys(var.ec2_map), "amazon-linux")
  }
  
}