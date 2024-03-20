resource "aws_eks_cluster" "cluster" {
    name = var.name
    version = var.cluster_version
    role_arn = var.role_arn

    vpc_config {
        subnet_ids = var.subnet_ids    
    }
    #depends_on = [ aws_iam_role_policy_attachment.amazon-eks-cluster-policy ]
}