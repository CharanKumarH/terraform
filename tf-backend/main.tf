terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "6.0.0-beta3"
        }
       
    }

    backend "s3" {
        bucket         = "bemo-bucket-e4f677e5dfd0f8f0"
        key            = "terraform/state"
        region         = "ap-south-1"
        
      
    }
}

provider "aws" {

    region = "ap-south-1"
}

resource "aws_instance" "demo_instance" {
    ami           = "ami-0f535a71b34f2d44a"
    instance_type = "t2.micro"

    tags = {
        Name = "DemoInstance"
    }
  
}