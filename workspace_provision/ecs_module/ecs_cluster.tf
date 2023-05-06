data "aws_ecs_cluster" "cluster" {
    cluster_name = var.ecs_cluster
}

resource "aws_ecs_capacity_provider" "provider" {
    name = "${var.mytags["project"]}-capacity-provider"
    tags = var.mytags

    auto_scaling_group_provider {
        auto_scaling_group_arn = var.asg_arn
    }
}

resource "aws_ecs_cluster_capacity_providers" "cluster_provider" {
    cluster_name = data.aws_ecs_cluster.cluster.cluster_name

    capacity_providers = [aws_ecs_capacity_provider.provider.name]
}