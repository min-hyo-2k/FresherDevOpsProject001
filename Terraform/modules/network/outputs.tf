output "vpc_id" {
  value = aws_vpc.dev_vpc.id
}

output "vpc_cidr" {
  value = var.vpc_cidr
}

output "eip_public_ip" {
  value = aws_eip.main.public_ip
}

output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public_subnet_2.id
}

output "private_app_subnet_1_id" {
  value = aws_subnet.private_app_subnet_1.id
}

output "private_app_subnet_2_id" {
  value = aws_subnet.private_app_subnet_2.id
}

output "private_db_subnet_1_id" {
  value = aws_subnet.private_db_subnet_1.id
}

output "private_db_subnet_2_id" {
  value = aws_subnet.private_db_subnet_2.id
}