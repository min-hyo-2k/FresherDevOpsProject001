output "BastionSG_id" {
  value = aws_security_group.BastionSG.id
}

output "InstanceSG_id" {
  value = aws_security_group.InstanceSG.id
}

output "ALBSG_id" {
  value = aws_security_group.ALBSG.id
}

output "RDSSG_id" {
  value = aws_security_group.RDSSG.id
}
