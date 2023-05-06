resource "aws_ecs_service" "service" {
    count = length(var.ecs_tasks)
    name = var.ecs_tasks[count.index].name
    cluster = data.aws_ecs_cluster.cluster.cluster_name
    task_definition = aws_ecs_task_definition.task[count.index].arn
    launch_type = "EC2"
    desired_count = var.ecs_tasks[count.index].task_count
    iam_role = var.ecs_service_iam_role
    health_check_grace_period_seconds = 30
    enable_ecs_managed_tags = true

    load_balancer {
        target_group_arn = var.ecs_tasks[count.index].target_group_arn
        container_name = "${var.ecs_tasks[count.index].name}-container"
        container_port = 8080
    }

    ordered_placement_strategy {
      type = "spread"
      field = "instanceId"
    }

    deployment_circuit_breaker {
        enable = true
        rollback = true
    }

    force_new_deployment = true
    deployment_minimum_healthy_percent = 100
    deployment_maximum_percent = 200
    propagate_tags = "TASK_DEFINITION"
    tags = var.mytags
}