
variable "region" {
    type = string
    description = "Region of vpc"
}
variable "name" {
  type = string
  description = "Name of project"
}
variable "cidr" {
    type = string
    description = "IPv4 CIDR for network"
}
variable "public_subnet_count" {
  type = number
  description = "Number of public subnets to create"
}
variable "private_subnet_count" {
  type = number
  description = "Number of private subnets to create"
}
variable "tags" {
  type = map(string)
  description = "Network Tags"
}
