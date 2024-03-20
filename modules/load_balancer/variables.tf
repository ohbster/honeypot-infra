variable "name" {
  type        = string
  description = "Load Balancer Name"
  default     = "mff_lb"
}

variable "tags" {
  type        = map(string)
  description = "Load Balancer Tags"

}

variable "internal" {
  type        = bool
  description = "Load Balancer Internal / External"
  default     = false
}
# variable "security_groups" {
#     type = list(string)
#     description = "Load Balancer security groups"

# }
# variable "s3_log_bucket_id" {
#     type = string
#     description = "LoadBalancer S3 bucket ID"
# }
# variable "s3_log_bucket_name" {
#     type = string
#     description = "ALB Log Bucket Name"
# }
variable "subnets" {
  type        = list(string)
  description = "Load Balancer subnets"
}
variable "vpc_id" {
  type        = string
  description = "LoadBalancer VPC ID"
}
variable "region" {
  type        = string
  description = "LoadBalancer region"
}
variable "domain_name" {
  type        = string
  description = "Loadbalancer domain name"
}

variable "certificate_arn" {
    type = string
    description = "ALB listener certificate ARN"
    #default = "arn:aws:acm:us-east-1:378576100664:certificate/70b47e31-1660-4fc1-97b0-67de6bce693e"
}