resource "aws_api_gateway_rest_api" "apigw" {
    name        = var.apigw_name
    tags        = merge(var.mytags, {workspace=terraform.workspace})

    endpoint_configuration {
        types = ["REGIONAL"]
    }
}

resource "aws_api_gateway_resource" "resource" {
    rest_api_id = aws_api_gateway_rest_api.apigw.id
    parent_id   = aws_api_gateway_rest_api.apigw.root_resource_id
    path_part   = var.resource_name
}

resource "aws_api_gateway_method" "method" {
    rest_api_id =  aws_api_gateway_rest_api.apigw.id
    resource_id = aws_api_gateway_resource.resource.id
    http_method = "POST"
    authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
    rest_api_id = aws_api_gateway_rest_api.apigw.id
    resource_id = aws_api_gateway_resource.resource.id
    http_method = aws_api_gateway_method.method.http_method
    # Lambda Function can only be invoked via "POST"
    integration_http_method = "POST" 
    # For Lambda Proxy Integration
    type        = "AWS_PROXY"
    # Lambda Function
    uri         = "arn:aws:apigateway:ap-southeast-1:lambda:path/2015-03-31/functions/${aws_lambda_function.lambda_producer.arn}:$${stageVariables.lambdaAlias}/invocations"
    # Timeout
    timeout_milliseconds    = 29000
}

variable "apigw_name" {
    type = string
}
variable "resoruce_name" {
    type = string
}