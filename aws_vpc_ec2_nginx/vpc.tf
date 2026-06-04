resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        name = "my_vpc"
    }
  
}

resource "aws_subnet" "my_private_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.1.0/24"
    tags = {
      Name = "my_private_subnet"
    }
  
}

resource "aws_subnet" "my_public_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.1.0/24"
    tags = {
      Name = "my_public_subnet"
    }
  
}



resource "aws_internet_gateway" "gateway" {
    vpc_id = aws_vpc.my_vpc.id
  
}

resource "aws_route_table" "my_rt" {
    vpc_id = aws_vpc.my_vpc.id

route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
}
  
}

resource "aws_route_table_association" "my_rt_ass" {
     route_table_id = aws_route_table.my_rt.id
     subnet_id = aws_subnet.my_public_subnet.id     
  
}