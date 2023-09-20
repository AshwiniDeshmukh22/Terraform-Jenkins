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
    availability_zone = "ap-south-1"
    cidr_block = "10.0.1.0/24"
}
