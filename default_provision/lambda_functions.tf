data "aws_s3_bucket_object" "lambda_producer_zip" {
    bucket = var.lambda_zip_bucket
    key = var.lambda_producer_key
}
data "aws_s3_bucket_object" "lambda_consumer_zip" {
    bucket = var.lambda_zip_bucket
    key = var.lambda_consumer_key
}

data "aws_iam_policy_document" "assume_role" {
    statement {
        effect = "Allow"

        principals {
            type        = "Service"
            identifiers = ["lambda.amazonaws.com"]
        }

        actions = ["sts:AssumeRole"]
    }
}

resource "aws_iam_role" "lambda_iam_role" {
    name  = "lambda_iam_role"
    assume_role_policy = data.aws_iam_policy_document.assume_role.json
    tags = var.mytags
}

resource "aws_lambda_function" "lambda_producer" {
    s3_bucket = data.aws_s3_bucket_object.lambda_producer_zip
    s3_key = data.aws_s3_bucket_object.lambda_producer_zip.key
    s3_object_version = data.aws_s3_bucket_object.lambda_producer_zip.version_id
    function_name = var.lambda_producer_name
    role = aws_iam_role.lambda_iam_role.arn
    tags = var.mytags
}

resource "aws_lambda_function" "lambda_consumer" {
    s3_bucket = data.aws_s3_bucket_object.lambda_consumer_zip
    s3_key = data.aws_s3_bucket_object.lambda_consumer_zip.key
    s3_object_version = data.aws_s3_bucket_object.lambda_consumer_zip.version_id
    function_name = var.lambda_consumer_name
    role = aws_iam_role.lambda_iam_role.arn
    tags = var.mytags
}

variable "lambda_producer_name" {
    type = string
}
variable "lambda_consumer_name" {
    type = string
}
variable "lambda_zip_bucket" {
    type = string
}
variable "lambda_producer_key" {
    type = string
}
variable "lambda_consumer_key" {
    type = string
}