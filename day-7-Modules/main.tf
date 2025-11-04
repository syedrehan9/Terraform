provider "aws" {
  
}

module "server" {
    source = "./main-module/module-call"
    ami = var.ami
    type =  var.type
  
}

module "server2" {
  source = "./main-module/module-call"
  ami = var.ami
  type = var.type

}