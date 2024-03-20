resource "aws_autoscaling_group" "asg" {
    name = var.name

    #One of these two is broken
    # availability_zones = var.availability_zones
    vpc_zone_identifier = var.subnet_ids

    desired_capacity = 3
    max_size = 4
    min_size = 2
    #load_balancers = var.target_group
    target_group_arns = [var.target_group[0]]

    launch_template {
      #id = var.launch_template_id
      id = module.launch_template.launch_template_id
      version = "$Latest"
      
    }
 
  depends_on = [ module.launch_template ]
}
module "instance_sg" {
  source = "../security_group"
  port_list = [80, 22]
  name = "${var.name}-instance_sg"
  vpc_id = var.vpc_id
  tags = var.tags
}

module "key_pair" {
  source = "../base_modules/key_pair"
  name = var.name
  public_key = file(var.pub_key_file)
}

module "launch_template" {
  source = "../launch_template"
  user_data = "./userdata/userdata_debian.sh"
  vpc_security_group_ids = [module.instance_sg.security_group_id]
  key_name = module.key_pair.key_name
  name = var.name
} 