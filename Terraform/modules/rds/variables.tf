variable "db_name" {
  type = string
  default = "dev_rds"
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