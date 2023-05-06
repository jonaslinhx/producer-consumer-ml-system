variable "mytags" {
    type = map
}
variable "desired" {
    type = number
}
variable "availability_zones" {
    type = list
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
    type = list
}
variable "ec2_iam_role" {
    type = string
}
variable "ebs_size" {
    type = number
}
variable "ec2_user_data"{
    type = string
}