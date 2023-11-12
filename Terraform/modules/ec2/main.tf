# ssh key using ssh-keygen-command 
resource "aws_key_pair" "ssh_key_variable" {
  key_name = "ssh_key_aws"
  public_key = var.public_key
}

# Bastion host instance
resource "aws_instance" "bastion_instance_1" {
  ami = var.ami
  instance_type = var.ec2_instance_type
  availability_zone = "${var.region}a"
  vpc_security_group_ids = [var.BastionSG_id]
  key_name = aws_key_pair.ssh_key_variable.key_name
  subnet_id = var.public_subnet_1_id
  associate_public_ip_address = true

  tags = {
    Name = "Bastion Host"
  }
}

resource "aws_instance" "application_instance_1" {
  ami = var.ami
  instance_type = var.ec2_instance_type
  availability_zone = "${var.region}a"
  vpc_security_group_ids = [var.InstanceSG_id]
  key_name = aws_key_pair.ssh_key_variable.key_name
  subnet_id = var.private_app_subnet_1_id

  tags = {
    Name = "application_instance_1"
  }
}

resource "aws_instance" "application_instance_2" {
  ami = var.ami
  instance_type = var.ec2_instance_type
  availability_zone = "${var.region}b"
  vpc_security_group_ids = [var.InstanceSG_id]
  key_name = aws_key_pair.ssh_key_variable.key_name
  subnet_id = var.private_app_subnet_2_id

  tags = {
    Name = "application_instance_2"
  }

  #  user_data = <<-EOF
  #   #!/bin/bash
  #   # Use this for your user data (script from top to bottom)
  #   # install httpd (Linux 2 version)
  #   yum update -y
  #   yum install -y httpd
  #   systemctl start httpd
  #   systemctl enable httpd
  #   echo "<h1>Hello World from $(hostname -f)<br> This is The 2nd EC2 Instance</h1>" > /var/www/html/index.html
  #   EOF
}