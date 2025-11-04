resource "aws_instance" "name" {
  ami = var.ami
  instance_type = var.type
  tags = {
    Name = "Instance-tf"
  }
}