provider "aws" {
}

resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc-2-creds"
  }
}

resource "aws_subnet" "subnet-1" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "creds-Subnet-1"
    }
}

resource "aws_subnet" "subnet-2" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name = "cred-Subnet-2"
    }
}

resource "aws_db_subnet_group" "subnet-group" {
    subnet_ids = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]
    name = "dbsubnet"
    tags = {
      Name = "DB Subnet"
    }
}

resource "aws_db_instance" "name" {
    engine = "mysql"
    engine_version = "8.0.42"
    identifier = "masterdb"
    manage_master_user_password = true
    instance_class = "db.t3.micro"
    allocated_storage = 20
    db_subnet_group_name = aws_db_subnet_group.subnet-group.id
    availability_zone = "us-east-1a"
    username = "admin"
    parameter_group_name = "default.mysql8.0"
    skip_final_snapshot = true
  
}