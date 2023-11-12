variable "db_name" {
  type = string
  default = "dev_rds"
}

variable "username_db" {
  type = string
  default = "devops"
}

variable "password_db" {
  type = string
  default = "devopstest"
}

variable "engine_version" {
  type = string
  default = "8.0.33"
}

variable "instance_class" {
  type = string
  default = "db.t3.micro"
}

variable "region" {
  type = string
  default = "ap-southeast-1"
}

variable "RDSSG_id" {
  type = string
}

variable "private_db_subnet_1_id" {
  type = string
}

variable "private_db_subnet_2_id" {
  type = string
}