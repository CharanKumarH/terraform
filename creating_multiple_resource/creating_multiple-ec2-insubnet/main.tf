terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta3"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}


provider "aws" {
  # Configuration options
  region = "ap-south-1"

}

resource "aws_vpc" "main_vpc" {
  count      = 1
  cidr_block = "10.0.${count.index}.0/16"
  tags = {
    Name = "main-vpc-${count.index+1}"
  }
  
}

resource "aws_subnet" "subnets" {
  count      = 2
  vpc_id     = aws_vpc.main_vpc[0].id
  cidr_block = "10.0.${count.index}.0/24"
  tags = {
    Name = "subnet-${count.index+1}"
  }
}

resource "aws_instance" "instance" {
    count         = 4
    ami           = "ami-0b09627181c8d5778" # Replace with a valid AMI ID for your region
    instance_type = "t2.micro"
    associate_public_ip_address = true
    # subnet_id     = aws_subnet.subnets[(count.index+1) % length(aws_subnet.subnets)].id
    subnet_id = element(aws_subnet.subnets[*].id, count.index % length(aws_subnet.subnets))

  tags = {
    Name = "instance-EC2-${count.index+1}"
  }
}
