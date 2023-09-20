provider "aws" {
    region = "ap-south-1"  
}

resource "aws_instance" "foo" {
  ami           = "ami-0ff30663ed13c2290"
  instance_type = "t2.small"
  tags = {
      Name = "TF-Instance"
  }
}
resource "aws_vpc" "myvpc"{
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "MyVPC"
    }
}
resource "aws_subnet" "PublicSubnet"{
    vpc_id = aws_vpc.myvpc.id
    availability_zone = "ap-south-1a"
    cidr_block = "10.0.1.0/24"
    tags = {
        Name = "PubSubnet"
    }
}
resource "aws_subnet" "PrivSubnet"{
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = true
    tags = {
        Name = "PrivtSubnet"
    }

}
resource "aws_internet_gateway" "myIgw"{
    vpc_id = aws_vpc.myvpc.id
    tags = {
        Name = "MyIGW"
    }
}
# route Tables for public subnet
resource "aws_route_table" "PublicRT"{
    vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myIgw.id
    }
    tags = {
        Name = "MyRT"
    }
}
resource "aws_route_table_association" "PublicRTAssociation"{
    subnet_id = aws_subnet.PublicSubnet.id
    route_table_id = aws_route_table.PublicRT.id
}
