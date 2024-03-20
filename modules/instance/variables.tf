variable "vpc_id" {
    type = string
    description = "Instance VPC ID"
}
variable "subnet_id" {
    type = string
    description = "Instance subnet ID"
}
variable "name" {
    type = string
    description = "Instance name"
}

variable "user_data" {
    type = string
    description = "Instance user data script"
}
variable "instance_type" {
    type = string
    description = "Instance type"  
}
variable "key_name" {
    type = string
    description = "Instance key name"    
}

variable "port_list" {
    type = list(number)
    description = "List of ports to open in security group"
}

variable "tags" {
  type = map(string)
  description = "Instance Tags"
 
}
variable "security_group_ids" {
    type = list(string)
    description = "Instance Security Groups"
}