variable "name" {
    type = string
    description = "S3 name"
    default = null
}
variable "tags" {
    type = object({})
    description = "S3 Tags"
    default = {}
}
variable "versioning" {
    type = bool
    description = "S3 versioning toggle"
    default = false
}