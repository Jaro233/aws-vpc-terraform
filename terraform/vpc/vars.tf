variable "region" {
  description = "The AWS region to create resources in"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "List of availability zones in which to create subnets"
  type        = list(string)
}

variable "public_subnets" {
  description = "Map of public subnet CIDR blocks with their names"
  type        = map(string)
}

variable "private_subnets" {
  description = "Map of private subnet CIDR blocks with their names"
  type        = map(string)
}