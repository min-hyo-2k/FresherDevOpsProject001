variable "region" {
  type = string
  default = "ap-southeast-1"
}

variable "name" {
  type = string
  default = "dev"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  type = string
  default = "10.0.4.0/24"
}

variable "public_subnet_2_cidr" {
  type = string
  default = "10.0.5.0/24"
}

variable "private_app_subnet_1_cidr" {
  type = string
  default = "10.0.6.0/24"
}

variable "private_app_subnet_2_cidr" {
  type = string
  default = "10.0.7.0/24"
}

variable "private_db_subnet_1_cidr" {
  type = string
  default = "10.0.8.0/24"
}

variable "private_db_subnet_2_cidr" {
  type = string
  default = "10.0.9.0/24"
}