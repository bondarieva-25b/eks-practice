module "eks_cluster1" {
    source = "../eks-module"
    cluster_name = var.cluster_name 
    cluster_version = var.cluster_version
    subnets = var.subnets
    ec2_types = var.ec2_types
    asg_size_desired = var.asg_size_desired
    asg_size_max = var.asg_size_max
    asg_size_min = var.asg_size_min
}
