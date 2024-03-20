variable "name" {
    type = string
    description = "Security Group Name"
    default = null
}
variable "port_list" {
  type = list(number)
  description = "List of open ingress ports"
  default = null
}
variable "vpc_id" {
    type = string
    description = "Security Group Vpc Id"
}
variable "tags" {
  type = map(string)
  description = "Security Group Tags"
}