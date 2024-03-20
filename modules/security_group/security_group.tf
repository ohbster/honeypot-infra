#Security group
resource "aws_security_group" "sg" {
    name = var.name
    description = "Allow port 80"
    vpc_id = var.vpc_id
    tags = merge(var.tags,{Name = var.name})
}
resource "aws_vpc_security_group_ingress_rule" "ingress" {
    count = length(var.port_list)
    security_group_id = aws_security_group.sg.id
    description = "port-${var.port_list[count.index]}"
    from_port = var.port_list[count.index]
    to_port = var.port_list[count.index]
    #protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "tcp"
}
resource "aws_vpc_security_group_egress_rule" "egress" {
    security_group_id = aws_security_group.sg.id
    description = "default egress"
    ip_protocol = "-1"
    cidr_ipv4 = "0.0.0.0/0"
}

