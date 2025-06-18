terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta3"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}

resource "aws_instance" "my_server" {
  ami = "ami-0f535a71b34f2d44a" # Example AMI ID, replace with a valid one
  instance_type = "t2.nano"
    
    tags = {
        Name = "MyServer"
    }   
  
}