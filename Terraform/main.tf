# network module
module "network" {
    source = "./modules/network"    
}

module "ec2" {
  source = "./modules/ec2"

  BastionSG_id = module.sg.BastionSG_id
  InstanceSG_id = module.sg.InstanceSG_id

  public_subnet_1_id = module.network.public_subnet_1_id
  private_app_subnet_1_id = module.network.private_app_subnet_1_id
  private_app_subnet_2_id = module.network.private_app_subnet_2_id
}

# sercurity group module
module "sg" {
  source = "./modules/sg"

  vpc_id = module.network.vpc_id
  vpc_cidr = module.network.vpc_cidr
}

module "rds" {
  source = "./modules/rds"

  RDSSG_id = module.sg.RDSSG_id
  
  private_db_subnet_1_id = module.network.private_db_subnet_1_id
  private_db_subnet_2_id = module.network.private_db_subnet_2_id
}

# load balancer module
module "lb" {
  source = "./modules/lb"

  ALBSG_id = module.sg.ALBSG_id

  vpc_id = module.network.vpc_id
  public_subnet_1_id = module.network.public_subnet_1_id
  public_subnet_2_id = module.network.public_subnet_2_id

  application_instance_1_id = module.ec2.application_instance_1_id
  application_instance_2_id = module.ec2.application_instance_2_id
}