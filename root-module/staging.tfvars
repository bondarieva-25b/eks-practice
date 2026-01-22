cluster_name = "practice_tf_cluster_staging"
cluster_version = "1.34"
ec2_types = ["t3.small"]
asg_size_desired = 1
asg_size_max = 2
asg_size_min = 1
admin_role_arn = "arn:aws:iam::058316962389:user/staging"
