terraform {
    backend "s3" {
        region = "ap-southeast-1"
        bucket = "terraform-dsd"
        key = "test/terraform.tfstate"
    }
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.16"
        }
    }
    required_version = ">=1.2.0"
}

provider "aws" {region = var.region}
variable "region" {type=string}
variable "mytags" {type=map}