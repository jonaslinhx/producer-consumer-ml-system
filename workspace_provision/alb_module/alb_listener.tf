resource "aws_lb" "alb" {
    name = "${var.mytags["project"]}-alb-${var.mytags["workspace"]}"
    internal = false
    load_balancer_type = "application"
    security_groups     = var.alb_security_groups
    subnets             = var.alb_subnets
    enable_cross_zone_load_balancing = true
    tags = var.mytags
}

resource "aws_lb_listener" "listener" {
    load_balancer_arn = aws_lb.alb.arn
    port = "80"
    protocol = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.default.arn
    }
    
    tags = merge(
        var.mytags,
        { Name = "${var.mytags["project"]}-alb-listener-${var.mytags["workspace"]}" }
    )
}

resource "aws_lb_listener_rule" "rules" {
    count = length(var.alb_target_groups)
    listener_arn = aws_lb_listener.listener.arn
    priority = 100 + (count.index * 100)

    action {
        type = "forward"
        target_group_arn = aws_lb_target_group.target_group[count.index].arn
    }

    condition {
        path_pattern {
            values = ["/${var.alb_target_groups[count.index].name}*"]
        }
    }
}