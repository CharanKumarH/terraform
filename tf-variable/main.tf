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

resource "aws_instance" "My_server" {
    ami = "ami-0b09627181c8d5778"   
    instance_type = var.aws_instance_type

    root_block_device {
      delete_on_termination = true
      volume_size = var.aws_root_block_device.v_size
      volume_type = var.aws_root_block_device.v_type
    }

    tags = merge( {
        Name = "My_Server"
    }
    , var.additional_tags )
    
}