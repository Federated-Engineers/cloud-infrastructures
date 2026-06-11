resource "aws_vpc" "federated-engineers-vpc" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.common_tags, { Name = "secure-production" })
}

resource "aws_subnet" "public-a" {
  vpc_id            = aws_vpc.federated-engineers-vpc.id
  cidr_block        = "172.16.0.0/21"
  availability_zone = "eu-central-1a"

  map_public_ip_on_launch = true

  tags = merge(local.common_tags, { Name = "secure-production-public-a" })
}

resource "aws_subnet" "private-a" {
  vpc_id            = aws_vpc.federated-engineers-vpc.id
  cidr_block        = "172.16.8.0/21"
  availability_zone = "eu-central-1a"

  tags = merge(local.common_tags, { Name = "secure-production-private-a" })
}

resource "aws_subnet" "public-b" {
  vpc_id            = aws_vpc.federated-engineers-vpc.id
  cidr_block        = "172.16.16.0/21"
  availability_zone = "eu-central-1b"

  map_public_ip_on_launch = true

  tags = merge(local.common_tags, { Name = "secure-production-public-b" })
}

resource "aws_subnet" "private-b" {
  vpc_id            = aws_vpc.federated-engineers-vpc.id
  cidr_block        = "172.16.24.0/21"
  availability_zone = "eu-central-1b"

  tags = merge(local.common_tags, { Name = "secure-production-private-b" })
}

resource "aws_subnet" "public-c" {
  vpc_id                  = aws_vpc.federated-engineers-vpc.id
  cidr_block              = "172.16.32.0/21"
  availability_zone       = "eu-central-1c"
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, { Name = "secure-production-public-c" })
}

resource "aws_subnet" "private-c" {
  vpc_id            = aws_vpc.federated-engineers-vpc.id
  cidr_block        = "172.16.40.0/21"
  availability_zone = "eu-central-1c"

  tags = merge(local.common_tags, { Name = "secure-production-private-c" })
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.federated-engineers-vpc.id

  tags = merge(local.common_tags, { Name = "secure-production-internet-gateway" })
}

resource "aws_route_table" "public-subnet-rtb" {
  vpc_id = aws_vpc.federated-engineers-vpc.id
  tags   = merge(local.common_tags, { Name = "secure-production-public-subnet-rtb" })

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }
}

resource "aws_route_table_association" "public-rtb-a" {
  subnet_id      = aws_subnet.public-a.id
  route_table_id = aws_route_table.public-subnet-rtb.id
}

resource "aws_route_table_association" "public-rtb-b" {
  subnet_id      = aws_subnet.public-b.id
  route_table_id = aws_route_table.public-subnet-rtb.id
}

resource "aws_route_table_association" "public-rtb-c" {
  subnet_id      = aws_subnet.public-c.id
  route_table_id = aws_route_table.public-subnet-rtb.id
}

resource "aws_route_table" "private-subnet-rtb" {
  vpc_id = aws_vpc.federated-engineers-vpc.id
  tags   = merge(local.common_tags, { Name = "secure-production-private-subnet-rtb" })
}

resource "aws_route_table_association" "private-rtb-a" {
  subnet_id      = aws_subnet.private-a.id
  route_table_id = aws_route_table.private-subnet-rtb.id
}

resource "aws_route_table_association" "private-rtb-b" {
  subnet_id      = aws_subnet.private-b.id
  route_table_id = aws_route_table.private-subnet-rtb.id
}

resource "aws_route_table_association" "private-rtb-c" {
  subnet_id      = aws_subnet.private-c.id
  route_table_id = aws_route_table.private-subnet-rtb.id
}

resource "aws_security_group" "sg" {
  name        = "secure-sg"
  description = "Security Group for the VPC"
  vpc_id      = aws_vpc.federated-engineers-vpc.id

  tags = merge(local.common_tags, { Name = "secure-production-sg" })
}

resource "aws_vpc_security_group_egress_rule" "sg-egress" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "sg-ingress" {
  security_group_id            = aws_security_group.sg.id
  referenced_security_group_id = aws_security_group.sg.id
  from_port                    = 443
  to_port                      = 443
  ip_protocol                  = "tcp"
}
