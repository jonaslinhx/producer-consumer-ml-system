terraform {
    backend "s3" {
        workspace_key_prefix = "project-name"
        bucket = "terraform-remote-state"
        key = "terraform.tfstate"
        region = "ap-southeast-1"
    }
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>4.16"
        }
    }
    required_version = ">=1.2.0"
}

provider "aws" {
    region = var.region
}

module "asg_module" {
    source = "./asg_module"

    desired = var.desired
    ec2_ami = var.ec2_ami
    ec2_instance_type = var.ec2_instance_type
    ec2_pem_key = var.ec2_pem_key
    ec2_security_groups = var.ec2_security_groups
    ec2_iam_role = var.ec2_iam_role
    ebs_size = var.ebs_size
    ec2_user_data = var.ec2_user_data
    mytags = merge(var.mytags, {workpace=terraform.workspace})
    availability_zones = var.availability_zones
}

module "alb_module" {
    source = "./alb_module"

    alb_vpc = var.alb_vpc
    alb_security_groups = var.ec2_security_groups
    alb_subnets = var.subnets
    alb_target_groups = var.target_groups
    mytags = merge(var.mytags, {workpace=terraform.workspace})
}

