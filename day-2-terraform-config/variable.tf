variable "ami_id" {
    description = "Passing AMI values"
  default = "ami-07860a2d7eb515d9a"
  type = string
}
variable "type" {
  description = "Passing values to instance type"
  default = "t3.micro"
  type = string
}