# sg for bastion host instance
resource "aws_security_group" "BastionSG" {
  name = "bastion_security_group"

  vpc_id = var.vpc_id
  ingress {
    description = "allow ssh from ALL"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

# sg for ALB
resource "aws_security_group" "ALBSG" {
  name = "alb_security_group"

  vpc_id = var.vpc_id

  ingress {
    description = "allow http from ALL"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

# sg for ec2 instance
resource "aws_security_group" "InstanceSG" {
  name = "ec2_security_group"
  depends_on = [aws_security_group.ALBSG, aws_security_group.BastionSG]

  vpc_id = var.vpc_id

  ingress {
    description     = "allow http from ALB only"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.ALBSG.id]
  }

  ingress {
    description     = "allow ssh from Bastion host only"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.BastionSG.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

#sg for rds
resource "aws_security_group" "RDSSG" {
  name = "allow_MYSQL_VPC"

  vpc_id = var.vpc_id

  ingress {
    description = "allow MYSQL from VPC only"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    # allowed only from IP addresses within the CIDR block of the VPC
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}