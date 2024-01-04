data "aws_subnet" "private_subnets" {
  for_each = local.private_subnet_names_to_cidr

  filter {
    name   = "vpc-id"
    values = [module.vpc.vpc_id]
  }

  filter {
    name   = "cidr-block"
    values = [each.value]
  }
  depends_on  = [module.vpc]  # Depends on the VPC module which creates the subnets
}

# Fetch Public Subnets
data "aws_subnet" "public" {
  for_each = var.public_subnets

  filter {
    name   = "cidr-block"
    values = [each.key]
  }

  filter {
    name   = "vpc-id"
    values = [module.vpc.vpc_id]  # Ensure this is the correct VPC ID
  }
  depends_on  = [module.vpc]  # Depends on the VPC module which creates the subnets
}

# Fetch Private Subnets
data "aws_subnet" "private" {
  for_each = var.private_subnets

  filter {
    name   = "cidr-block"
    values = [each.key]
  }

  filter {
    name   = "vpc-id"
    values = [module.vpc.vpc_id]
  }
  depends_on  = [module.vpc]  # Depends on the VPC module which creates the subnets
}