resource "aws_eip" "nat" {
    vpc = var.vpc
    tags = merge(var.tags,{Name = var.name})
}