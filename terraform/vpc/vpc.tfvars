region = "us-east-1"

vpc_name = "prod_vpc"
vpc_cidr = "10.0.0.0/16"

azs = ["us-east-1a", "us-east-1b", "us-east-1c"]

public_subnets = {
  "10.0.1.0/24" = "Prod-Web-Public-1a",
  "10.0.2.0/24" = "Prod-Web-Public-1b",
  "10.0.3.0/24" = "Prod-Web-Public-1c"
}

private_subnets = {
  "10.0.4.0/24"  = "Prod-App-Private-1a",
  "10.0.5.0/24"  = "Prod-App-Private-1b",
  "10.0.6.0/24"  = "Prod-App-Private-1c",
  "10.0.7.0/24"  = "Prod-DB-Private-1a",
  "10.0.8.0/24"  = "Prod-DB-Private-1b",
  "10.0.9.0/24"  = "Prod-DB-Private-1c",
  "10.0.10.0/24" = "Prod-Mgmt-Private-1a",
  "10.0.11.0/24" = "Prod-Mgmt-Private-1b",
  "10.0.12.0/24" = "Prod-Mgmt-Private-1c",
  "10.0.13.0/24" = "Prod-Platform-Private-1a",
  "10.0.14.0/24" = "Prod-Platform-Private-1b",
  "10.0.15.0/24" = "Prod-Platform-Private-1c"
}

inverted_private_subnets = zipmap(values(var.private_subnets), keys(var.private_subnets))

inverted_public_subnets = zipmap(values(var.public_subnets), keys(var.public_subnets))

private_subnet_names_to_cidr = { for cidr, name in var.private_subnets : name => cidr }