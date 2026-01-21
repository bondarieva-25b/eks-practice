cluster_name = "practice_tf_cluster"
cluster_version = "1.34"
subnets = ["subnet-00b4a90e3cb427044", "subnet-0abc9875e70a0753c", "subnet-0d149229666b921a2"]
ec2_types = ["t3.small"]
asg_size_desired = 1
asg_size_max = 2
asg_size_min = 1
