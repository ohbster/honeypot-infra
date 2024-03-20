data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_template" "launch_template" {
  name = var.name
#   asg_subnets = 
    #asg
#   block_device_mappings {
#     device_name = "/dev/sdf"

#     ebs {
#       volume_size = 20
#     }
#   }

#   capacity_reservation_specification {
#     capacity_reservation_preference = "open"
#   }

#   cpu_options {
#     core_count       = 4
#     threads_per_core = 2
#   }

#   credit_specification {
#     cpu_credits = "standard"
#   }

#   disable_api_stop        = true
#   disable_api_termination = true

#   ebs_optimized = true

#   elastic_gpu_specifications {
#     type = "test"
#   }

#   elastic_inference_accelerator {
#     type = "eia1.medium"
#   }

#   iam_instance_profile {
#     name = "test"
#   }

#   image_id = "ami-test"
    image_id = data.aws_ami.ubuntu.id
    

#   instance_initiated_shutdown_behavior = "terminate"

#   instance_market_options {
#     market_type = "spot"
#   }

  instance_type = "t3.micro"

#   kernel_id = "test"

  key_name = var.key_name

#   license_specification {
#     license_configuration_arn = "arn:aws:license-manager:eu-west-1:123456789012:license-configuration:lic-0123456789abcdef0123456789abcdef"
#   }

#   metadata_options {
#     http_endpoint               = "enabled"
#     http_tokens                 = "required"
#     http_put_response_hop_limit = 1
#     instance_metadata_tags      = "enabled"
#   }

#   monitoring {
#     enabled = true
#   }

  network_interfaces {
    #associate_public_ip_address = true
  }

#   placement {
#     availability_zone = "us-east-1a"
#   }

#   ram_disk_id = "test"

  #vpc_security_group_ids = ["sg-12345678"]
  vpc_security_group_ids = var.vpc_security_group_ids

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.name}-instance"
    }
  }

  #user_data = filebase64("${path.module}/example.sh")
  #user_data = "./userdata/userdata_debian.sh"
  user_data = filebase64(var.user_data)
}