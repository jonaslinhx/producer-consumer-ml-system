resource "aws_sqs_queue" "queue" {
  name = "${var.mytags["project"]}_${terraform.workspace}"
  visibility_timeout_seconds = 60
  tags = var.mytags
}