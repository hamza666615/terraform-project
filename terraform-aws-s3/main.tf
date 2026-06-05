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

resource "aws_s3_object" "bucket_data" {
    bucket = aws_s3_bucket.s3_bucket.id
    key   = "mydata.txt"
    source = "./file.txt"
  
}