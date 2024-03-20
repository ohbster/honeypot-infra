variable "name" {
    type = string
    description = "ASG name"
    default = null
}
variable "tags" {
  type = map(string)
  description = "ASG Tags"
 
}

variable "availability_zones" {
    type = list(string)
    description = "ASG availability zones"
    default = ["us-east-1a"]
}
variable "launch_template_id" {
    type = string
    description = "ASG Launch template ID"
    default = "lt-0cf2e002df22b5553"
}
variable "target_group" {
    #type = list(string)
    type = list(string)
    description = "ASG LB target groups"
    default = null
}
# variable "vpc_security_group_ids" {
#     type = list(string)
#     description = "VPC Security Group IDS"
#     default = null
# }
variable "user_data" {
    type = string
    description = "ASG user data"
    
}
variable "subnet_ids" {
    type = list(string)
    description = "ASG subnet ids"
}
variable "vpc_id" {
    type = string
    description = "ASG vpc_id"
}
# variable "key_name" {
#     type = string
#     description = "ASG Key name"
# }
variable "pub_key_file" {
  type = string
  description = "AWS Public Key file path"
}