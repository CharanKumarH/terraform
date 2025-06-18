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
    
    region = "ap-south-1"
  
}

resource "aws_s3_bucket" "my_project_bucket" {
    bucket = "my-project-${random_id.random_suffix.hex}"
    force_destroy = true
}


resource "aws_s3_bucket_public_access_block" "publicaccess" {

bucket = aws_s3_bucket.my_project_bucket.id
    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
  
}

resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.my_project_bucket.id

  index_document {
    suffix = "index.html"
  }

}

resource "aws_s3_bucket_policy" "my_project_bucket_policy" {
  bucket = aws_s3_bucket.my_project_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.my_project_bucket.arn}/*"

      }
    ]
  })
}


resource "random_id" "random_suffix" {
    byte_length = 8
}

resource "aws_s3_object" "index" {
    bucket = aws_s3_bucket.my_project_bucket.bucket
    key    = "index.html"
    source = "./index.html"
    content_type = "text/html"

}

resource "aws_s3_object" "styles" {
    bucket = aws_s3_bucket.my_project_bucket.bucket
    key    = "styles.css"
    source = "./styles.css"
    content_type = "text/css"
  
}

output "websitelink" {
    value = aws_s3_bucket_website_configuration.website_configuration.website_endpoint
  
}