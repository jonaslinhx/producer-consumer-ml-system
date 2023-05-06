variable "mytags" {
    type = map
}
variable "alb_security_groups" {
    type = list(string)
}
variable "alb_subnets" {
    type = list(string)
}
variable "alb_vpc" {
    type = string
}
variable "alb_target_groups" {
    type = list(map)
}