resource "aws_dynamodb_table" "table1" {
    name = var.mytags["project"]
    billing_mode = "PAY_PER_REQUEST"
    # read_capacity = 1
    # write_capacity = 4
    hash_key = "environment"
    range_key = "timestamp"

    attribute {
        name = "environment"
        type = "S"
    }

    attribute {
        name = "timestamp"
        type = "S"
    }

    tags = var.mytags

    lifecycle {
        ignore_changes = [read_capacity]
    }
}

# resource "aws_appautoscaling_target" "read_target" {
#     max_capacity = 10
#     min_capacity = 1
#     resource_id = "table/${aws_dynamodb_table.table1.name}"
#     scalable_dimension = "dynamodb:table:ReadCapacityUnits"
#     service_namespace = "dynamodb"
# }

# resource "aws_appautoscaling_policy" "dynamodb_table_read_policy" {
#     name = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.read_target.resource_id}"
#     policy_type = "TargetTrackingScaling"
#     resource_id = aws_appautoscaling_target.read_target.resource_id
#     scalable_dimension = aws_appautoscaling_target.read_target.scalable_dimension
#     service_namespace = aws_appautoscaling_target.read_target.service_namespace

#     target_tracking_scaling_policy_configuration {
#         predefined_metric_specification {
#             predefined_metric_type = "DynamoDBReadCapacityUtilization"
#         }
#         target_value = 70
#     }
# }