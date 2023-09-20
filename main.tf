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
