resource "aws_security_group" "free_tier" {
    name        = "free_tier"
    description = "Default sg for free tier ec2"
    vpc_id      = data.aws_vpc.default.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_all" {
    security_group_id = aws_security_group.free_tier.id
    cidr_ipv4         = "0.0.0.0/0"
    from_port         = 443
    ip_protocol       = "tcp"
    to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4_all" {
    security_group_id = aws_security_group.free_tier.id
    cidr_ipv4         = "0.0.0.0/0"
    from_port         = 80
    ip_protocol       = "tcp"
    to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
    security_group_id = aws_security_group.free_tier.id
    cidr_ipv4         = "0.0.0.0/0"
    ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_security_group_rule" "ssh_ingress" {
    for_each = toset(local.config.ssh_cidrs)
  
    type              = "ingress"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = [each.value]
    security_group_id = aws_security_group.free_tier.id
}