resource "aws_vpc" "main" {
    cidr_block = var.cidr
    tags = merge(var.tags,{Name = var.name})

}