#Network
module "vpc-network" {
  #count = var.vpc_toggle ? 1 : 0
  #count = var.toggle_map.vpc_toggle ? 1 : 0
  source               = "./modules/network"
  region               = var.region
  name                 = var.name
  cidr                 = var.cidr
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  #port_list = var.port_list
  tags               = var.tags
 
}

module "ec2_instance_sg" {
  source    = "./modules/security_group"
  name      = var.name
  port_list = var.port_list
  vpc_id    = module.vpc-network.vpc_id
  tags      = var.tags
}

module "alb" {
  #count = var.toggle_map.alb_toggle ? 1 : 0
  source = "./modules/load_balancer"
  name = "${var.name}-alb"
  subnets = module.vpc-network.public_subnet_ids
  vpc_id = module.vpc-network.vpc_id
  region = var.region
  certificate_arn = module.public_certificate.certificate_arn
  domain_name = var.domain_name
  tags = var.tags

  #depends_on = [ module.public_certificate ]
}

module "asg" {
  #count = var.toggle_map.asg_toggle ? 1 : 0
  source = "./modules/autoscaling_group"
  name = "${var.name}-asg"
  availability_zones = module.vpc-network.availability_zones
  target_group = [module.alb.target_groups]
  user_data = var.user_data
  subnet_ids = module.vpc-network.private_subnet_ids
  vpc_id = module.vpc-network.vpc_id
  #key_name = module.key_pair.key_name
  pub_key_file = var.pub_key_file
  tags = var.tags

  depends_on = [ module.alb[0] ]
}

module "route53" {
  #count = var.toggle_map.alb_toggle ? 1 : 0
  source = "./modules/route53"
  public_ip = module.alb.dns_name
  zone_name = var.zone_name
}

# module "dynamodb" {
#   count = var.toggle_map.dynamodb_toggle ? 1 : 0
#   source = "./modules/dynamodb"
#   name = "Testdb"
#   hash_key = "testhashkey"

# }

# module "key_pair" {
#   source = "./modules/base_modules/key_pair"
#   name = var.name
#   public_key = file(var.pub_key_file)
# }

module "waf" {
  source = "./modules/waf"
  name = var.name
  target = module.alb.arn
}

module "public_certificate" {
  source = "./modules/acm"
  domain_name = var.domain_name
  zone_name = var.zone_name
}