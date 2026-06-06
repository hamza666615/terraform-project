terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

backend "s3" {
    bucket = "mywebapp-34ff4bf4d46221fe"
    key   =  "backed.tfstate"
    region = "eu-north-1"
}



}

# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "my_instance"{
    ami =  "ami-0b2ab3a97a77bd35e"
    instance_type = "t2.micro"

tags = {
    Name = "ec2_instance"
}

}

