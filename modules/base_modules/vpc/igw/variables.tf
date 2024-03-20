variable "name" {
    type = string
    description = "Internet Gateway name"
    default = "igw"
}
variable "vpc_id" {
    type = string
    description = "Internet Gateway VPC ID"
}
variable "tags" {
  type = map(string)
  description = "Internet Gateway Tags"
}