output "instance_public_ip"{
    description = "the public ip address of the ec2 instance"
    value = aws_ec2_instance.NginxServer.public_ip
}

output "instance_url" {
    description = "the url to access the nginx server"
    value  = "https://${aws_instance.nginxserver.public_ip}"
  
}
