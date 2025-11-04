resource "aws_instance" "name" {
    ami = "ami-0bdd88bd06d16ba03"
    associate_public_ip_address = true
    instance_type = "t3.micro"
    tags = {
      Name = "server"
    }
    # lifecycle {
    #   create_before_destroy = true
    # }
    # lifecycle {
    #   ignore_changes = [ tags ]
    # }
    # lifecycle {
    #   prevent_destroy = true
    # }
}


