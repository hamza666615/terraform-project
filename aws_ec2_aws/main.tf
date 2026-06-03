resource "aws_ec2_instance" "my_instance" {
    ami = "ami-091138d0f0d41ff90"
    instance_type = "t2.micro"
tags{
    Name = "my_ec2_instance"
}
  
}



