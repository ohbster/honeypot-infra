#Subnet ids
output "private_subnet_ids"{
    value = [
        for sn in module.private-subnets : sn.id
    ]
}
output "public_subnet_ids"{
    value = [
        for sn in module.public-subnets : sn.id
    ]
}
output "vpc_id"{
    value = module.vpc.vpc_id
}

output "public_subnet_count" {
    value = var.public_subnet_count
}
output "availability_zones" {
    value = [
        for az in local.availability_zones : az
    ]
}