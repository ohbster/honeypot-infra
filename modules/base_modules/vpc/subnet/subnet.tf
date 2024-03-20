resource "aws_subnet" "main" {
    vpc_id = var.vpc_id
    availability_zone = var.az
    cidr_block = var.cidr
    tags = merge(var.tags,{Name = var.name})
}