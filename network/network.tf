resource "aws_vpc" "vpc_udm" {
  cidr_block = var.cidr_vpc

  tags = {
    Name = "vpc-${var.enviroment}"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc_udm.id
  cidr_block = var.cidr_subnet
  availability_zone = "sa-east-1a" 
  tags = {
    Name = "subnet-${var.enviroment}"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc_udm.id

  tags = {
    Name = "internet-gateway-${var.enviroment}"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc_udm.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "route-table-${var.enviroment}"
  }
}

resource "aws_route_table_association" "rta" {
  route_table_id = aws_route_table.route_table.id
  subnet_id      = aws_subnet.subnet.id
}

resource "aws_security_group" "security_group" {
  name   = "sg_terraform_udm"
  vpc_id = aws_vpc.vpc_udm.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
