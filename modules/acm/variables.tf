variable "domain_name" {
    type = string
    description = "ACM domain name"
}

variable "private_key" {
    type = string
    description = "ACM private key"
    default = null
}

#For private only
# variable "certificate_body" {
#     type = string
#     description = "ACM"
#     default = null
# }