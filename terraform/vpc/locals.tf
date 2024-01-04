locals {
  inverted_private_subnets = zipmap(values(var.private_subnets), keys(var.private_subnets))
  inverted_public_subnets = zipmap(values(var.public_subnets), keys(var.public_subnets))
  private_subnet_names_to_cidr = { for cidr, name in var.private_subnets : name => cidr }
}