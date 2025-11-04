resource "aws_instance" "name" {
    instance_type = "t3.micro"
    ami = "ami-0bdd88bd06d16ba03"
    tags = {
        Name = "server-1"
    }
  
}

resource "aws_s3_bucket" "name" {
  bucket = "bucket-rehanl"
}
