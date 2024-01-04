provider "aws" {
  region = var.region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.4.0"  # Use the appropriate version

  name = var.vpc_name
  cidr = var.vpc_cidr
  azs  = var.azs

  public_subnets  = keys(var.public_subnets)
  private_subnets = keys(var.private_subnets)

  # public_subnet_tags = var.public_subnets
  # private_subnet_tags = var.private_subnets

  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false

  tags = {
    Terraform = "true"
    Environment = "prod"
  }

  private_route_table_tags = {
    Name = "Prod-private-rt"
  }

  public_route_table_tags = {
    Name = "Prod-public-rt"
  }

  igw_tags = {
    Name = "Prod-igw"
  }

  nat_gateway_tags = {
    Name = "Prod-nat"
  }

  # map_public_ip_on_launch = true
}