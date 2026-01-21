terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket = "practice-eks-450558842433-tfstate"
    #bucket = "practice-eks-058316962389-tfstate-staging"
    key    = "terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
  }
}


# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
