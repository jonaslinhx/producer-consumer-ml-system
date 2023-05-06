resource "aws_autoscaling_group" "asg1" {
    name = "${var.mytags["project"]}-asg-${var.mytags["workspace"]}"
    min_size = 0
    desired_capacity = var.desired
    max_size = var.desired + 1
    default_instance_warmup = 120
    default_cooldown = 120

    health_check_type = "EC2"
    health_check_grace_period = 60
    termination_policies = ["OldestInstance"]
    availability_zones = var.availability_zones

    # Linkage to ALB Target Groups
    # target_group_arns = [
    #     aws_lb_target_group.car-detector.arn,
    #     aws_lb_target_group.damage-detector.arn
    # ]

    launch_template {
        id = aws_launch_template.template1.id
        version = aws_launch_template.template1.latest_version
    }

    # Automatically refresh instance in ASG when ASG is updated
    # Creates new instances before destroy old instance
    instance_refresh {
        strategy = "Rolling"
        preferences {
            min_healthy_percentage = 100
        }
        triggers = ["tag"]
    }

    lifecycle {
        create_before_destroy = true
        ignore_changes = [desired_capacity]
    }

    tag {
        key = "owner"
        value = var.mytags["owner"]
        propagate_at_launch = true
    }
    tag {
        key = "team"
        value = var.mytags["team"]
        propagate_at_launch = true
    }
    tag {
        key = "project"
        value = var.mytags["project"]
        propagate_at_launch = true
    }
}
