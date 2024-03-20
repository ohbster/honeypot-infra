variable "zone_name" {
    type = string
    description = "Route53 hosted zone name"
    default = "goldwatch.link."
}
variable "public_ip" {
    type = string 
    description = "public ip"
}