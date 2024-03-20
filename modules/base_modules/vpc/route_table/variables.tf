variable "name" {
    type = string
    description = "Route table name"
}
variable "vpc_id" {
    type = string
    description = "Route Table vpc id"
}
variable "nat_gateway_id" {
    type = string
    description = "Route table nat gateway"
    default = null
}
variable "gateway_id" {
    type = string
    description = "Route table internet gateway id"
    default = null
}
variable "tags" {
  type = map(string)
  description = "Route Table Tags"
}