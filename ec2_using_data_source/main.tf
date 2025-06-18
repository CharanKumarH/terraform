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


resource "aws_instance" "ec_2_instance" {
    ami           = "ami-0b09627181c8d5778"
    instance_type = "t2.micro"
    vpc_security_group_ids = [data.aws_security_group.name.id]
    subnet_id = data.aws_subnet.subnet_name.id
   
    

    tags = {
        Name = "DemoInstance"
    }
  
}

data "aws_security_group" "name" {
    tags = {
        Name = "my_security_group"
    }
  
}

data "aws_subnet" "subnet_name" {
    filter {
      name = "vpc-id"
      values = [data.aws_vpc.name.id]
    }
    tags = {
        Name = "project-subnet-public1-ap-south-1a"
    }
  
}

data "aws_vpc" "name" {
    tags = {
        Name = "project-vpc"
        id = "vpc_new"
    }
  
}

output "instance_id" {
  value = aws_instance.ec_2_instance.id
}

output "subnet" {
  value = data.aws_subnet.subnet_name.id
}

output "security_group" {
  value = data.aws_security_group.name.id
}
output "vpc" {
  value = data.aws_vpc.name.id
}