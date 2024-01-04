resource "aws_network_acl" "db_nacl" {
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "db_nacl"
  }
}

resource "aws_network_acl_rule" "db_inbound_app1" {
  network_acl_id = aws_network_acl.db_nacl.id
  rule_number    = 10
  rule_action    = "allow"
  egress         = false
  protocol       = "tcp"  # -1 means all protocols
  cidr_block     = lookup(local.inverted_private_subnets, "Prod-App-Private-1a") # Replace with your App subnet CIDR
  from_port      = 3306
  to_port        = 3306
}
resource "aws_network_acl_rule" "db_inbound_app2" {
  network_acl_id = aws_network_acl.db_nacl.id
  rule_number    = 20
  rule_action    = "allow"
  egress         = false
  protocol       = "tcp"  # -1 means all protocols
  cidr_block     = lookup(local.inverted_private_subnets, "Prod-App-Private-1b")  # Replace with your App subnet CIDR
  from_port      = 3306
  to_port        = 3306
}
resource "aws_network_acl_rule" "db_inbound_app3" {
  network_acl_id = aws_network_acl.db_nacl.id
  rule_number    = 30
  rule_action    = "allow"
  egress         = false
  protocol       = "tcp"  # -1 means all protocols
  cidr_block     = lookup(local.inverted_private_subnets, "Prod-App-Private-1c")  # Replace with your App subnet CIDR
  from_port      = 3306
  to_port        = 3306
}

resource "aws_network_acl_rule" "db_inbound_mgmt1" {
  network_acl_id = aws_network_acl.db_nacl.id
  rule_number    = 40
  rule_action    = "allow"
  egress         = false
  protocol       = "tcp"
  cidr_block     = lookup(local.inverted_private_subnets, "Prod-Mgmt-Private-1a") # Replace with your Management subnet CIDR
  from_port      = 0
  to_port        = 65535
}
resource "aws_network_acl_rule" "db_inbound_mgmt2" {
  network_acl_id = aws_network_acl.db_nacl.id
  rule_number    = 50
  rule_action    = "allow"
  egress         = false
  protocol       = "tcp"
  cidr_block     =lookup(local.inverted_private_subnets, "Prod-Mgmt-Private-1b")  # Replace with your Management subnet CIDR
  from_port      = 0
  to_port        = 65535
}
resource "aws_network_acl_rule" "db_inbound_mgmt3" {
  network_acl_id = aws_network_acl.db_nacl.id
  rule_number    = 60
  rule_action    = "allow"
  egress         = false
  protocol       = "tcp"
  cidr_block     = lookup(local.inverted_private_subnets, "Prod-Mgmt-Private-1c") # Replace with your Management subnet CIDR
  from_port      = 0
  to_port        = 65535
}

# Outbound Rule - Allow TCP 3306 to 10.0.7.0/24
resource "aws_network_acl_rule" "db_outbound_rule1" {
  network_acl_id = aws_network_acl.db_nacl.id
  rule_number    = 100
  rule_action    = "allow"
  egress         = true
  protocol       = "tcp"
  cidr_block     = lookup(local.inverted_private_subnets, "Prod-DB-Private-1a")
  from_port      = 3306
  to_port        = 3306
}

# Outbound Rule - Allow TCP 3306 to 10.0.8.0/24
resource "aws_network_acl_rule" "db_outbound_rule2" {
  network_acl_id = aws_network_acl.db_nacl.id
  rule_number    = 110
  rule_action    = "allow"
  egress         = true
  protocol       = "tcp"
  cidr_block     = lookup(local.inverted_private_subnets, "Prod-DB-Private-1b")
  from_port      = 3306
  to_port        = 3306
}

# Outbound Rule - Allow TCP 3306 to 10.0.9.0/24
resource "aws_network_acl_rule" "db_outbound_rule3" {
  network_acl_id = aws_network_acl.db_nacl.id
  rule_number    = 120
  rule_action    = "allow"
  egress         = true
  protocol       = "tcp"
  cidr_block     = lookup(local.inverted_private_subnets, "Prod-DB-Private-1c")
  from_port      = 3306
  to_port        = 3306
}

resource "aws_network_acl_association" "db_nacl_association1" {
  network_acl_id = aws_network_acl.db_nacl.id
  # subnet_id      = module.vpc.private_subnets[3]  # Replace with your DB subnet ID
  subnet_id      = data.aws_subnet.private_subnets["Prod-DB-Private-1a"].id
}

resource "aws_network_acl_association" "db_nacl_association2" {
  network_acl_id = aws_network_acl.db_nacl.id
  # subnet_id      = module.vpc.private_subnets[4]   # Replace with your DB subnet ID
  subnet_id      = data.aws_subnet.private_subnets["Prod-DB-Private-1b"].id
}

resource "aws_network_acl_association" "db_nacl_association3" {
  network_acl_id = aws_network_acl.db_nacl.id
  # subnet_id      = module.vpc.private_subnets[5]  # Replace with your DB subnet ID
  subnet_id      = data.aws_subnet.private_subnets["Prod-DB-Private-1c"].id
}
