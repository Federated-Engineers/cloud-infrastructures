locals {
  common_tags = {
    project     = var.project_name
    environment = var.environment
    team        = var.team
    service     = var.service
  }
}


# VPC
resource "aws_vpc" "federated-engineers-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.common_tags, {
    Name    = "${var.project_name}-vpc"
  })
}

# Public subnets using for_each
resource "aws_subnet" "public-subnet" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.federated-engineers-vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name    = "${var.project_name}-public-subnet-${each.key}"
  })
}

# Private subnets using for_each
resource "aws_subnet" "private-subnet" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.federated-engineers-vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = merge(local.common_tags, {
    Name    = "${var.project_name}-private-subnet-${each.key}"
  })
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.federated-engineers-vpc.id

    tags = merge(local.common_tags, {
    Name    = "${var.project_name}-igw"
    })
}

# # Elastic IP for NAT
# resource "aws_eip" "nat_eip" {
#   domain = "vpc"
#       tags = merge(local.common_tags, {
    # Name    = "${var.project_name}-eip"
    # })
# }

# NAT Gateway in public1
# resource "aws_nat_gateway" "nat_public1" {
#   allocation_id = aws_eip.nat_eip.id
#   subnet_id     = aws_subnet.public1.id
    # tags = merge(local.common_tags, {
    # Name    = "${var.project_name}-nat-gateway-public1"
    # })
#   depends_on = [aws_internet_gateway.igw]
# }

# Route tables
resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.federated-engineers-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
    tags = merge(local.common_tags, {
    Name    = "${var.project_name}-public-rtb"
    })
}

# Private route tables using for_each private subnets
resource "aws_route_table" "private-rtb" {
  for_each = var.private_route_tables

  vpc_id = aws_vpc.federated-engineers-vpc.id

  # route {
  #   cidr_block = "0.0.0.0/0"
  #   nat_gateway_id = aws_nat_gateway.nat_public1.id
  # }
    
    tags = merge(local.common_tags, {
    Name    = "${var.project_name}-private-rtb-${each.key}"
    })
  }

# Associations
# Public subnet associations
resource "aws_route_table_association" "public_subnet_associations" {
  for_each = aws_subnet.public-subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public-rtb.id
}

# Private subnet associations
resource "aws_route_table_association" "private_subnet_associations" {
  for_each = aws_subnet.private-subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private-rtb[each.key].id
}

# Security Group for VPC 
resource "aws_security_group" "federated-engineers-vpc_sg" {
  name        = "federated-engineers-vpc-sg"
  description = "Security group for federated-engineers-vpc VPC"
  vpc_id      = aws_vpc.federated-engineers-vpc.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ingress {
  #   description = "All traffic from anywhere"
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-sg"
  })
}


# VPC Gateway Endpoint for S3 (attached to private route tables)
resource "aws_vpc_endpoint" "s3_gateway" {
  vpc_id            = aws_vpc.federated-engineers-vpc.id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [for rtb_key, rtb in aws_route_table.private-rtb : rtb.id]

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-s3-endpoint"
  })
}