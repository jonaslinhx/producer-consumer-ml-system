resource "aws_lb_target_group" "default" {
    name =
    port =
}

resource "aws_lb_target_group" "target_group" {
    count = length(var.alb_target_groups)
    name = "${var.mytags["project"]}-alb-tg-${var.mytags["workspace"]}"
    port = 80
    protocol = "HTTP"
    target_type = "instance"
    vpc_id = var.alb_vpc
    tag = var.mytags

    health_check {
        enabled             = true
        healthy_threshold   = 5
        interval            = 30
        matcher             = "200"
        path                = "/${var.alb_target_groups[count.index].name}/health"
        timeout             = 5
        unhealthy_threshold = 2
    }

    stickiness {
        enabled         = false
        type            = "lb_cookie"
    }
}
