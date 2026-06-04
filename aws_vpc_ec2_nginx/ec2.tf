resource "aws_ec2_instance" "my_ec2" {
    ami = "ami-091138d0f0d41ff90"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.my_public_subnet.id
    vpc_security_group_ids = [aws_security_group.nginx-sg]
    associate_public_ip_address = true
  

user_data = <<-EOF
          #!/bin/bash
          sudo yum install nginx -y
          sudo systemctl start nginx
          EOF

tags = {
    Name = "NginxServer"
} 

}



   