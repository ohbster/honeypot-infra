#vpc
variable "name" {
    type = string
    description = "Name of vpc"
}

variable "cidr" {
    type = string
    description = "CIDR address block"
}

variable "tags" {
  type = map(string)
  description = "VPC Tags"
}