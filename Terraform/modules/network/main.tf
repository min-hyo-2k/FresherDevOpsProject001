# create vpc
resource "aws_vpc" "dev_vpc" {
  cidr_block =  var.vpc_cidr

  enable_dns_hostnames = true # need to be enabled in order for publicly accessible RDS instance finding to work
  enable_dns_support = true # need to be enabled in order for publicly accessible RDS instance finding to work

  tags = {
    Name = "${var.name}_vpc"
  }
}

# create subnet

## public subnet
resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.dev_vpc.id
  cidr_block = var.public_subnet_1_cidr
  availability_zone = "${var.region}a"
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id = aws_vpc.dev_vpc.id
  cidr_block = var.public_subnet_2_cidr
  availability_zone = "${var.region}b"
}

## private subnet for app
resource "aws_subnet" "private_app_subnet_1" {
  vpc_id = aws_vpc.dev_vpc.id
  cidr_block        = var.private_app_subnet_1_cidr
  availability_zone = "${var.region}a"
}

resource "aws_subnet" "private_app_subnet_2" {
  vpc_id = aws_vpc.dev_vpc.id
  cidr_block        = var.private_app_subnet_2_cidr
  availability_zone = "${var.region}b"
}

## privatte subnet for db
resource "aws_subnet" "private_db_subnet_1" {
  vpc_id = aws_vpc.dev_vpc.id
  cidr_block        = var.private_db_subnet_1_cidr
  availability_zone = "${var.region}a"
}

resource "aws_subnet" "private_db_subnet_2" {
  vpc_id = aws_vpc.dev_vpc.id
  cidr_block        = var.private_db_subnet_2_cidr
  availability_zone = "${var.region}b"
}

# create igw
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.dev_vpc.id
}

# create elastic ip (for NAT GW)
resource "aws_eip" "main" {
  domain = "vpc"
}

# create nat gw
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id = aws_subnet.public_subnet_1.id

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]

  tags = {
    Name = "${var.name}_NAT_GW"
  }
}

# create route table

## public
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

## private app rtb
resource "aws_route_table" "private_app_route_table" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }
}

## private db rtb
resource "aws_route_table" "private_db_route_table" {
  vpc_id = aws_vpc.dev_vpc.id

  route = {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }
}

# associate route table with subnet

## public
resource "aws_route_table_association" "public1" {
  subnet_id = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table
}

resource "aws_route_table_association" "public2" {
  subnet_id = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table
}

## private app
resource "aws_route_table_association" "private_app_1" {
  subnet_id = aws_subnet.private_app_subnet_1.id
  route_table_id = aws_route_table.private_app_route_table.id
}

resource "aws_route_table_association" "private_app_2" {
  subnet_id = aws_subnet.private_app_subnet_2.id
  route_table_id = aws_route_table.private_app_route_table.id
}

## private db
resource "aws_route_table_association" "private_db_1" {
  subnet_id      = aws_subnet.private_db_subnet_1.id
  route_table_id = aws_route_table.private_db_route_table.id
}

resource "aws_route_table_association" "private_db_2" {
  subnet_id      = aws_subnet.private_db_subnet_2.id
  route_table_id = aws_route_table.private_db_route_table.id
}