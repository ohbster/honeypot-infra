variable "name" {
    type = string
    description = "Launch Template name"
    default = null
}
variable "user_data" {
    type = string
    description = "Launch Template user data"
    default = null
}
variable "vpc_security_group_ids" {
    type = list(string)
    description = "Launch Template security groups"
}

variable "key_name" {
    type = string
    description = "Launch Template key name"
}