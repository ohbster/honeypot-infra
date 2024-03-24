variable "domain_name" {
    type = string
    description = "ACM domain name"
}

variable "private_key" {
    type = string
    description = "ACM private key"
    default = null
}
variable "zone_name" {
    type = string
    description = "ACM Zone name"
}

#For private only
# variable "certificate_body" {
#     type = string
#     description = "ACM"
#     default = null
# }