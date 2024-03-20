variable "name" {
    type = string
    description = "IAM Role name"
}
variable "service" {
    type = string
    description = "IAM Role service"
    default = "ec2"
}

variable "effect" {
    type = string
    description = "IAM Role effect"
    default = "allow"

    validation {
        condition = var.effect == "allow" || var.effect == "deny"
        error_message = "Invalid value for variable 'effect': enter 'true' or 'false'"
    }
}
