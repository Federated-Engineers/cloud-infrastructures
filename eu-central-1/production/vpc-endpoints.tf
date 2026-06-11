resource "aws_vpc_endpoint" "s3_gateway" {
  vpc_id            = aws_vpc.federated-engineers-vpc.id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.private-subnet-rtb.id]

  tags = merge(local.common_tags, { Name : "secure-production-s3-vpc-endpoint" })
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = aws_vpc.federated-engineers-vpc.id
  service_name      = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.private-a.id,
    aws_subnet.private-b.id,
    aws_subnet.private-c.id
  ]

  security_group_ids = [
    aws_security_group.sg.id
  ]

  private_dns_enabled = true

  tags = merge(
    local.common_tags,
    {
      Name = "secure-production-ssm-endpoint"
    }
  )
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id            = aws_vpc.federated-engineers-vpc.id
  service_name      = "com.amazonaws.${var.region}.ecr.api"
  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.private-a.id,
    aws_subnet.private-b.id,
    aws_subnet.private-c.id
  ]

  security_group_ids = [
    aws_security_group.sg.id
  ]

  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id            = aws_vpc.federated-engineers-vpc.id
  service_name      = "com.amazonaws.${var.region}.ecr.dkr"
  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.private-a.id,
    aws_subnet.private-b.id,
    aws_subnet.private-c.id
  ]

  security_group_ids = [
    aws_security_group.sg.id
  ]

  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "logs" {
  vpc_id            = aws_vpc.federated-engineers-vpc.id
  service_name      = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.private-a.id,
    aws_subnet.private-b.id,
    aws_subnet.private-c.id
  ]

  security_group_ids = [
    aws_security_group.sg.id
  ]

  private_dns_enabled = true
}
