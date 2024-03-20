variable "name" {
    type = string
    description = "EKS Cluster name"

}

variable "cluster_version" {
    type = string
    description = "EKS Cluster version"
}

variable "subnet_ids" {
    type = list(string)
    description = "EKS Cluster subnet id's"
}

variable "role_arn" {
    type = string
    description = "EKS Cluster role arn"
}