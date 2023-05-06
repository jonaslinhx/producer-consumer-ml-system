output "car-detector_arn" {
    value = aws_lb_target_group.target_group[0].arn
}
output "damage-detector_arn" {
    value = aws_lb_target_group.target_group[1].arn
}
output "car-info_arn" {
    value = aws_lb_target_group.target_group[2].arn
}
