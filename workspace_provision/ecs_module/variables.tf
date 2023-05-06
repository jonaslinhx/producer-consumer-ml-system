variable "ecs_cluster" {
    type = string
}
variable "asg_arn" {
    type = string
}
variable "region" {
    type = string
}
variable "ecs_task_iam_role" {
    type = string
}
variable "ecs_service_iam_role" {
    type = string
}
variable "ecs_tasks" {
    type = list(map)
}