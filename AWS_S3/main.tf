terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "6.0.0-beta3"
        }
        random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
    }
}

provider "aws" {
    # Configuration options
    region = "ap-south-1"
}

resource "random_id" "unique_id" {
  byte_length = 8
  
}
resource "aws_s3_bucket" "my_bemo_bucket" {
  bucket = "bemo-bucket-${random_id.unique_id.hex}"
}

resource "aws_s3_object" "bucket_object" {
  bucket = aws_s3_bucket.my_bemo_bucket.bucket
  key    = "example.txt"
  source = "./myfile.txt"
  
}

output "random_id_value" {
  value = random_id.unique_id.hex
  
}