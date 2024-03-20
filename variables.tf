###Provider###

variable "tags" {
  type        = map(string)
  description = "Common Tags"
  default = {
    Environment = "dev"
    Version     = ".1"
    Owner       = "ohbster@protonmail.com"
  }
}

###Networking###
variable "region" {
  type        = string
  description = "Location of vpc"
  default = "us-west-1"
}
variable "name" {
  type        = string
  description = "Name of project"
  default = "default-project-name"
}
variable "cidr" {
  type        = string
  description = "Main network IPv4 CIDR block"
  default = "10.10.0.0/16"
}
variable "public_subnet_count" {
  type        = number
  description = "Number of public subnets to create"
  default = 2
}
variable "private_subnet_count" {
  type        = number
  description = "Number of private subnets to create"
  default = 2
}
variable "port_list" {
  type = list(number)
  description = "List of open ports"
  default = [22,80]
}

# ###Kubernetes###
# variable "cluster_version" {
#   default     = "1.26"
#   type = string
#   description = "Version of kubernetes cluster"
# }
# variable "desired_size" {
#   type        = number
#   description = "Desired number of nodes"
#   default = 2
# }
# variable "max_size" {
#   type        = number
#   description = "Maximum number of nodes"
#   default = 4
# }
# variable "min_size" {
#   type        = number
#   description = "Minimum number of nodes"
#   default = 2
# }

#Instances
variable "instance_count" {
  type = number
  description = "Instance count"
  default = 0
}
variable "user_data" {
  type = string
  description = "AWS user data script"
}
variable "instance_type" {
  type = string
  description = "AWS EC2 instance type"
  
}
variable "key_name"{
  type = string
  description = "AWS EC2 key name"
}

# #Lambda
# variable "lambda_function_name" {
#   type = string
#   description = "AWS lambda function name"
# }
# variable "source_dir" {
#   type = string
#   description = "AWS lambda source directory"
# }

# #Secrets
# variable "secret_name" {
#   type = string
#   description = "AWS Secret"
# }

#Api Gateway
# variable "uri" {
#   type = string
#   description = "AWS URI for apigateway"
# }

variable "toggle_map" {
  type = map(bool)
  description = "AWS Toggle Map"
}

variable "pub_key_file" {
  type = string
  description = "AWS Public Key file path"
}

variable "domain_name" {
  type = string
  description = "AWS ACM domain name"
  #default = "www.goldwatch.link"
}

