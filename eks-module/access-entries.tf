resource "aws_eks_access_entry" "admin_role_access" {
    cluster_name = aws_eks_cluster.first.name
    principal_arn = var.admin_role_arn
    type = "STANDARD"
}

resource "aws_eks_access_policy_association" "admin_policy" {
    cluster_name = aws_eks_cluster.first.name
    principal_arn = aws_eks_access_entry.admin_role_access.principal_arn
    policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

    access_scope {
      type = "cluster"
    }
}

