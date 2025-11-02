resource "aws_instance" "name" {
    ami = "ami-0bdd88bd06d16ba03"
    instance_type = var.instance_type
    tags = {
      Name = "Terraform-instance"
    }
}
