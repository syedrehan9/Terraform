terraform {
  backend "s3" {
    bucket = "state-file-rehan"
    key = "day-4/terraform.tfstate"
    use_lockfile = true # to use s3 native locking 1.19 version above
    region = "us-east-1"
    dynamodb_table = "rehan"
    encrypt = true
  }
}