toggle_map = {
    aws_toggle = true
    vpc_toggle = true
    alb_toggle = true
    asg_toggle = true
}
###Project###
#Enter a name for your infrastructure
name = "TheoClass"
#version = 0.1
#environment = dev

#############
#VPC
#############
#Enter a region for vpc and resources
#example: region = "us-east-1"
#aws_region = "us-east-1"
# region = "us-east-1"
region = "us-west-2"

#Enter an IPv4 CIDR range for your vpc
#Example "10.10.0.0/16"
cidr = "10.51.0.0/16"

#Enter the number of public and private subnets
#example: public_subnet_count = 2
public_subnet_count  = 3
private_subnet_count = 3

###########
# Domain
###########
domain_name = "www.goldwatch.tv"
zone_name = "goldwatch.tv."

###########
#EC2
###########

#######
#Instance settings
#######
instance_type   = "t3.micro"
#User data script
user_data = "./userdata/userdata_debian.sh"
#How many instances you want to create
instance_count = 5
#If you want to ssh into instances, you must provide a valid key name
#Remember the key pairs are regional
#key_name = "<CHANGE ME TO A VALID KEYNAME IN THE REGION>"
key_name = null
#Below is the list of ports you are opening in your instance security groups
port_list = [80, 22, 443]

#key pair file
pub_key_file = "~/.ssh/id_rsa.pub"

###########
#EKS
###########
#Kubernetes
# eks_toggle   = false #enter 'false' to disable or 'true' to enable building eks cluster
# desired_size = 2
# max_size     = 6
# min_size     = 2

#port_list = [22, 80, 6443, 2379, 2380, 17123]

