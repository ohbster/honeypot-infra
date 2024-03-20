#****************
#Locals
#****************
data "aws_availability_zones" "available" {
    state = "available"
}
#Available AZ's in region
locals {
    availability_zones = data.aws_availability_zones.available.names
}

#****************
#VPC
#****************
module "vpc" {

    source = "../base_modules/vpc/vpc"
    name = "${var.name}-vpc"
    cidr = var.cidr
    tags = var.tags
}
module "private-subnets" {
    count = var.private_subnet_count
    source = "../base_modules/vpc/subnet"
    vpc_id = module.vpc.vpc_id
    name = "${var.name}-private-${count.index + 1}"
    #private cidr will be of format xxx.xxx.1a.xxx/24
    cidr = cidrsubnet(module.vpc.cidr, 8, count.index + 11) 
    #using modulus in case there are more subnets than available AZ's 
    az = element(local.availability_zones, (count.index) % length(local.availability_zones)) 
    tags = var.tags
}
#Should only need 1 public subnet.
module "public-subnets" {
    count = var.public_subnet_count
    source = "../base_modules/vpc/subnet"
    vpc_id = module.vpc.vpc_id
    name = "${var.name}-public-${count.index + 1}"
    #public cidr will be of the format xxx.xxx.a.xxx/24
    cidr = cidrsubnet(module.vpc.cidr,8, count.index + 1)
    #using modulus in case there are more subnets than available AZ's 
    az = element(local.availability_zones, (count.index) % length(local.availability_zones)) 
    tags = var.tags
}
###
#IGW and NAT
###
module "igw" {
    source = "../base_modules/vpc/igw"
    vpc_id = module.vpc.vpc_id
    name = "${var.name}-igw"
    tags = var.tags
}
module "eip_nat" {
    source = "../base_modules/vpc/elastic_ip"
    name = "${var.name}-nat_eip"
    tags = var.tags
}
module "nat_gateway" {
    source = "../base_modules/vpc/nat_gateway"
    subnet_id = element(module.public-subnets,0).id
    name = "${var.name}-nat"
    allocation_id = module.eip_nat.id
    depends_on = [ module.igw ]
    tags = var.tags
}
###
#Routes
###
module "private_route_table" {
    source = "../base_modules/vpc/route_table"
    name = "${var.name}-private"
    vpc_id = module.vpc.vpc_id
    nat_gateway_id = module.nat_gateway.id
    tags = var.tags
}
module "public_route_table" {
    source = "../base_modules/vpc/route_table"
    name = "${var.name}-public"
    vpc_id = module.vpc.vpc_id
    gateway_id = module.igw.id
    tags = var.tags
}
resource "aws_route_table_association" "private-subnets" {
    count = length(module.private-subnets)
    subnet_id = element(module.private-subnets,count.index).id
    route_table_id = module.private_route_table.id
}
resource "aws_route_table_association" "public-subnets" {
    count = length(module.public-subnets)
    subnet_id = element(module.public-subnets,count.index).id 
    route_table_id = module.public_route_table.id
}
