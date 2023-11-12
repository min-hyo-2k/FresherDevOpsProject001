# network module
module "network" {
    source = "Terraform/modules/network"    
}

module "ec2" {
  source = "Terraform/modules/ec2"
}

# sercurity group module
module "sg" {
  source = "Terraform/modules/sg"
}

module "rds" {
  source = "Terraform/modules/rds"
}

# load balancer module
module "lb" {
  source = "Terraform/modules/lb"
}