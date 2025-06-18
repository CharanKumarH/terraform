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

# create a VPC
resource "aws_vpc" "demo_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "demo_vpc"
  }
}

# create a private subnet
resource "aws_subnet" "private_subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "private_subnet"
  }
}

# create a public subnet
resource "aws_subnet" "public_subnet" {
  cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.demo_vpc.id
    tags ={
        Name = "public_subnet"
    }
  
}


# create an internet gateway
resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "demo_igw"
  }
  
}


# create a route table for the public subnet
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.demo_vpc.id
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.demo_igw.id
    }

  tags = {
    Name = "my_route_table"
  }
}

# associate route table to public subnet
resource "aws_route_table_association" "my_route_table_association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}

# create a Ec2 instance in the public subnet
resource "aws_instance" "ec2_instance" {
    ami = "ami-0f535a71b34f2d44a"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.private_subnet.id

    tags = {
        Name = "MyEC2Instance"
    }
}