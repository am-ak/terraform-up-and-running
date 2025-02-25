provider "aws" {
  region = "eu-north-1"
}
resource "aws_instance" "example" {
  ami           = "ami-0989fb15ce71ba39e" #Ubuntu 22.04 Jammy x64
  instance_type = "t3.micro"
  tags = {
    Name = "terraform-example"
  }
}