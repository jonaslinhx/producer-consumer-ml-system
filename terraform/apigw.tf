
/*
Rate Limiting
Authentication
Static Content
IP whitelisting
SSL termination
*/

resource "aws_api_gateway_rest_api" "api" {
    name = var.apigw_name
    tags = var.mytags
    endpoint_configuration {types=["REGIONAL"]}
}

resource "aws_api_gateway_resource" "resource" {
    rest_api_id = aws_api_gateway_rest_api.api.id
    parent_id = aws_api_gateway_rest_api.api.root_resource_id
    path_part = "invocations"
}

resource "aws_api_gateway_method" "method" {
    rest_api_id = aws_api_gateway_rest_api.api.id
    resource_id = aws_api_gateway_resource.resource.id
    http_method = "POST"
    authorization = "NONE"
    api_key_required = true
}




resource "aws_api_gateway_deployment" "deploy" {
    rest_api_id = aws_api_gateway_rest_api.api.id
    triggers = {
        redeployment = sha1(jsonencode([
            aws_api_gateway_resource.resource.id,
            aws_api_gateway_method.method.id
        ]))
    }
}

resource "aws_api_gateway_stage" "production" {
    deployment_id = aws_api_gateway_deployment.deploy.id
    rest_api_id = aws_api_gateway_rest_api.api.id
    stage_name = "production"
}

variable "apigw_name" {type=string}
variable "api_key" {type=string}