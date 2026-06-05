terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.44.0"
    }
     random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "random_id" "rand_id" {
  byte_length = 8
}


resource "aws_s3_bucket" "s3_bucket" {
    bucket = "s3_bucket-${random_id.rand_id.hex}"

}

resource "aws_s3_object" "index" {
    bucket = aws_s3_bucket.s3_bucket.id
    key = "index.html"
    source = "index.html"
    content_type = "text/html"
}

resource "aws_s3_object" "css" {
    bucket = aws_s3_bucket.s3_bucket.id
    key = "css.style"
    source = "css.style"
    content_type = "text/html"
}

resource "aws_s3_bucket_public_access_block" "mywebbapp" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "mywebapp" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = jsonencode(
    {
     Version= "2012-10-17",
     Statement= [
        {
             Sid= "PublicReadGetObject",
             Effect= "Allow",
             Principal= "*",
             Action= "s3:GetObject",
             Resource= [
                "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}/*"
            ]
        }
    ]
}
  )
}


resource "aws_s3_bucket_website_configuration" "mywebapp-bucket" {
  bucket = aws_s3_bucket.s3_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  
}


output "aws_random_id" {
  value = random_id.rand_id.hex
}

output "aws_configuration" {
  value = aws_s3_bucket_website_configuration.mywebapp-bucket.website_endpoint
}