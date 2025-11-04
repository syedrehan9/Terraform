provider "aws" {
}

resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc-replica"
  }
}

resource "aws_subnet" "subnet-1" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "rep-Subnet-1"
    }
}

resource "aws_subnet" "subnet-2" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name = "rep-Subnet-2"
    }
}

resource "aws_db_subnet_group" "subnet-group" {
    subnet_ids = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]
    name = "dbsubnet"
    tags = {
      Name = "rep Subnet"
    }
}

resource "aws_db_instance" "name" {
    engine = "mysql"
    engine_version = "8.0.42"
    identifier = "masterdb"
    #manage_master_user_password = true
    instance_class = "db.t3.micro"
    allocated_storage = 20
    db_subnet_group_name = aws_db_subnet_group.subnet-group.id
    availability_zone = "us-east-1a"
    username = "dbadmin"
    password = "database123"
    parameter_group_name = "default.mysql8.0"
    skip_final_snapshot = true
  #backup & maintenance window
    backup_retention_period = 7
    backup_window = "03:00-04:00"
    maintenance_window = "sun:04:00-sun:05:00"
    apply_immediately = true

}

resource "aws_db_instance" "replica" {
    identifier = "master-db-replica"
    replicate_source_db = aws_db_instance.name.arn # replica
    instance_class = "db.t3.micro"
    db_subnet_group_name = aws_db_subnet_group.subnet-group.id
    availability_zone = "us-east-1b" 
    skip_final_snapshot = true
    apply_immediately = true

    depends_on = [ aws_db_instance.name ]
}