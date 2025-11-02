terraform {
    backend "s3" {
        bucket = "rehan-terraform-statefile"
        key = "Day3/terraform.tfstate"
        region = "us-east-1"
    }
}