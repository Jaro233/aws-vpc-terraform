# Tag Public Subnets
resource "aws_ec2_tag" "public_subnet_tag" {
  for_each    = var.public_subnets
  resource_id = data.aws_subnet.public[each.key].id
  key         = "Name"
  value       = each.value
  depends_on  = [module.vpc]  # Depends on the VPC module which creates the subnets
}

# Tag Private Subnets
resource "aws_ec2_tag" "private_subnet_tag" {
  for_each    = var.private_subnets
  resource_id = data.aws_subnet.private[each.key].id
  key         = "Name"
  value       = each.value
  depends_on  = [module.vpc]  # Depends on the VPC module which creates the subnets
}
