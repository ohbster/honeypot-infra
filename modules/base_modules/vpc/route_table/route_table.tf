resource "aws_route_table" "route_table" {
    vpc_id = var.vpc_id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = var.nat_gateway_id
        gateway_id = var.gateway_id
    }
    tags = merge(var.tags,{Name = var.name})
}