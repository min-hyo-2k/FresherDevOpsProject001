# main db
resource "aws_db_instance" "mysql_instance" {
  allocated_storage = 10
  db_name = var.db_name
  engine = "mysql"
  engine_version = var.engine_version
  instance_class = var.instance_class
  identifier = "dev-database-mysql"
  username = var.username_db
  password = var.password_db
  skip_final_snapshot = true
  allow_major_version_upgrade = true
  port = "3306"

  availability_zone = "${var.region}a"
  vpc_security_group_ids = [var.RDSSG_id]
  db_subnet_group_name = aws_db_subnet_group.rds-subnet-group.name
}

resource "aws_db_subnet_group" "rds-subnet-group" {
  name       = "main"
  subnet_ids = [var.private_db_subnet_1_id, var.private_db_subnet_2_id]

  tags = {
    Name = "My DB subnet group"
  }
}

# replica db
resource "aws_db_instance" "mysql_instance_replica" {
  replicate_source_db = aws_db_instance.mysql_instance.identifier
  identifier = "dev-database-replica"
  backup_retention_period = 7
  instance_class = var.instance_class
  availability_zone = "${var.region}b"
  skip_final_snapshot = true
}