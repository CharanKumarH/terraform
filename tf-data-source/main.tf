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

resource "aws_instance" "demo_instance" {
    ami           = "ami-0f535a71b34f2d44a" # Example AMI ID, replace with a valid one
    instance_type = "t2.nano"
    
    tags = {
        Name = "DemoInstance"
    }
  
}
data "aws_ami" "ami" {
    most_recent = true
    owners      = ["amazon"]

   filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
  
}
output "name" {
    value = data.aws_ami.ami.id
  
}

# attach to exesting security group 
data "aws_security_group" "name" {
  tags = {
    Name = "my_security_group"
  }
}

output "my_security_group" {
    value = data.aws_security_group.name
  
}

# attach to exesting vpc 
data "aws_vpc" "name" {
  tags = {
    Name = "default VPC"
  }
}

output "vpc" {
  value = data.aws_vpc.name
}

# available zones
data "aws_availability_zones" "available_zones" {
  state = "available"
}

output "available_zones" {
  value = data.aws_availability_zones.available_zones.names
  
}

# to get a caller information
data "aws_caller_identity" "current" {}
output "caller_identity" {
  value = data.aws_caller_identity.current
}

# to get a region information
data "aws_region" "current" {}
output "current_region" {
  value = data.aws_region.current
}