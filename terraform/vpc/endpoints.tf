# VPC Endpoints
resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = module.vpc.public_route_table_ids
  tags = {
    Name = "Prod-s3-endpoint"
  }
}

resource "aws_vpc_endpoint" "secretsmanager_endpoint" {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.${var.region}.secretsmanager"
  vpc_endpoint_type = "Interface"

  # Assign subnets from different availability zones
  subnet_ids = [
    data.aws_subnet.private_subnets["Prod-DB-Private-1a"].id,  # Assuming this is in us-east-1a
    data.aws_subnet.private_subnets["Prod-DB-Private-1b"].id   # Assuming this is in us-east-1b
    # Add more if needed, ensuring they're in different AZs
  ]
  private_dns_enabled = true
  tags = {
    Name = "Prod-secretsmanager-endpoint"
  }
}

resource "aws_vpc_endpoint" "logs_endpoint" {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type = "Interface"

  # Assign subnets from different availability zones
  subnet_ids = [
    data.aws_subnet.private_subnets["Prod-DB-Private-1c"].id,  # Assuming this is in us-east-1c
    # Add more if needed, ensuring they're in different AZs
  ]
  private_dns_enabled = true
  tags = {
    Name = "Prod-logs-endpoint"
  }
}