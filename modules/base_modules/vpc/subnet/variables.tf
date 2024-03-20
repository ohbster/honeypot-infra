variable "name" {
    type = string
    description = "Subnet name"
}
variable "vpc_id"{
    type = string
    description = "VPC ID"
}
variable "az" {
    type = string
    description = "Availability zone"
}
variable "cidr" {
    type = string
    description = "Subnet CIDR block"
}
variable "tags" {
  type = map(string)
  description = "Network Tags"
}