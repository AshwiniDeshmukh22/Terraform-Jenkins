provider "aws" {
    region = "ap-south-1"  
}

resource "aws_instance" "foo" {
  ami           = "ami-0899663faf239dd8a"
  instance_type = "t2.micro"
  tags = {
      Name = "TF-Instance"
  }
}
