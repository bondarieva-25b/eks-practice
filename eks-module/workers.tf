resource "aws_eks_node_group" "workers" {
  cluster_name    = aws_eks_cluster.first.name
  node_group_name = "${var.cluster_name}-workers"
  node_role_arn   = aws_iam_role.workers-role.arn
  subnet_ids      = var.subnets
  instance_types = var.ec2_types

  scaling_config {
    desired_size = var.asg_size_desired
    max_size     = var.asg_size_max
    min_size     = var.asg_size_min
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.workers-role-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.workers-role-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.workers-role-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_iam_role" "workers-role" {
  name = "${var.cluster_name}-workers-iam-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "workers-role-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.workers-role.name
}

resource "aws_iam_role_policy_attachment" "workers-role-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.workers-role.name
}

resource "aws_iam_role_policy_attachment" "workers-role-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.workers-role.name
}
