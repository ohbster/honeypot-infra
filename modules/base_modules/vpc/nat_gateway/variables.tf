variable "name" {
    type = string
    description = "NAT Gateway name"
}
variable "allocation_id" {
    type = string
    description = "NAT Gateway allocation id"
}
variable "subnet_id" {
    type = string
    description = "NAT Gateway subnet id"
}
variable "tags" {
  type = map(string)
  description = "NAT Gateway Tags"
}