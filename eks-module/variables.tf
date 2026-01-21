variable "cluster_name" {
    type = string
}

variable "cluster_version" {
   type = string
}

variable "subnets" {
  type = list(string)
}

variable "ec2_types" {
  type = list(string)
}

variable "asg_size_desired" {
  type = number
}

variable "asg_size_max" {
  type = number
}

variable "asg_size_min" {
    type = number
}

variable "admin_role_arn" {
  type = string
}
