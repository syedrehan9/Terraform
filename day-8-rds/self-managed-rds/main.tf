provider "aws" {
}

resource "aws_db_instance" "name1" {
    engine = "mysql"
    engine_version = "8.0.42"
    db_name = "masterdb"
    username = "admin"
    password = "database123"
    instance_class = "db.t3.micro"
    allocated_storage = 20
    db_subnet_group_name = aws_db_subnet_group.db_subnet.id
    availability_zone = "us-east-1a"
    parameter_group_name = "default.mysql8.0"
    tags = {
      Name = "master-db"
    }
    identifier = "master-db"
    skip_final_snapshot = true
}

resource "aws_vpc" "db_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "vpc-1"
    }
}

resource "aws_subnet" "subnet-1" {
  vpc_id = aws_vpc.db_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "DB-Subnet-1"
  }
}

resource "aws_subnet" "subnet-2" {
  vpc_id = aws_vpc.db_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "DB-Subnet-2"
  }
}

resource "aws_db_subnet_group" "db_subnet" {
    name = "db_subnet"
    subnet_ids = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]

    tags = {
      Name = "DB-Subnet-Group"
    }
  
}