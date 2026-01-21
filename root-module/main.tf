data "aws_vpc" "main_vpc" {
    default = true
}

data "aws_subnets" "default_subnets" {
    filter {
        name   = "vpc-id"
        values = [data.aws_vpc.main_vpc.id]
    }

    filter {
        name   = "default-for-az"
        values = ["true"]
    }

    filter {
        name   = "availability-zone"
        values = [
            "us-east-1a",
            "us-east-1b",
            "us-east-1c",
        ]
    }
}

output "default_subnets" {
    value = data.aws_subnets.default_subnets.ids
}

module "eks_cluster1" {
    source = "../eks-module"
    cluster_name = var.cluster_name 
    cluster_version = var.cluster_version

    # for deafult VPC
    #subnets = data.aws_subnets.default_subnets.ids

    # for custom VPC
    subnets = module.vpc.subnet_ids

    ec2_types = var.ec2_types
    asg_size_desired = var.asg_size_desired
    asg_size_max = var.asg_size_max
    asg_size_min = var.asg_size_min
    admin_role_arn = var.admin_role_arn
}

module "vpc" {
    source = "../vpc-module"
}
