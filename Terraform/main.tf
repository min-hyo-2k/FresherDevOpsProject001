# network module
module "network" {
    source = "./modules/network"    
}

module "ec2" {
  source = "./modules/ec2"
}

# sercurity group module
module "sg" {
  source = "./modules/sg"
}

module "rds" {
  source = "./modules/rds"
}

# load balancer module
module "lb" {
  source = "./modules/lb"
}