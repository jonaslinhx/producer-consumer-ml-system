resource "aws_ecs_task_definition" "task" {
    count = length(var.ecs_tasks)
    family = "${var.mytags["project"]}-${var.ecs_tasks[count.index].name}-task"
    execution_role_arn = var.ecs_task_iam_role
    task_role_arn = var.ecs_task_iam_role
    tags = var.mytags

    container_definitions = jsonencode([
        {
            name = "${var.ecs_tasks[count.index].name}-container"
            image = "${var.ecs_tasks[count.index].image}:${var.ecs_tasks[count.index].image_tag}"
            cpu = var.ecs_tasks[count.index].cpu
            memory = var.ecs_tasks[count.index].memory
            essential = true

            healthCheck = {
                command = ["CMD-SHELL", "curl -f http://localhost:8080/ping"]
                interval = 20
                retries = 3
                startPeriod = 20
                timeout = 5          
            }

            logConfiguration = {
                logDriver = "awslogs"
                options = {
                    awslogs-create-group = "true"
                    awslogs-group = "/ecs/${var.mytags["project"]}-${var.ecs_tasks[count.index].name}"
                    awslogs-region = var.region
                    awslogs-stream-prefix = "ecs"
                }            
            }
        }
    ])
}