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

variable "region" {
    type = string
}
variable "mytags" {
    type = map
}