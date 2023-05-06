variable "region" {
    type = string
}
variable "accountId" {
    type = string
}
variable "mytags" {
    type = map
}
variable "apigw_name" {
    type = string
}
variable "apigw_resource" {
    type = string
}
variable "lambda_producer_name" {
    type = string
}
variable "deisred" {
    type = number
}
variable "ec2_ami" {
    type = string
}
variable "ec2_instance_type" {
    type = string
}
variable "ec2_pem_key" {
    type = string
}
variable "ec2_security_groups" {
    type = list(string)
}
variable "ec2_iam_role" {
    type = string
}
variable "ebs_size" {
    type = number
}
variable "ec2_user_data" {
    type = string
}
variable "availability_zones" {
    type = list
}