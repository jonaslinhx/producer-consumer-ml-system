data "aws_api_gateway_rest_api" "apigw" {
    name = var.apigw_name
}
data "aws_api_gateway_resource" "resource" {
    rest_api_id = data.aws_api_gateway_rest_api.apigw.id
    path = var.apigw_resource
}
data "aws_lambda_function" "lambda_producer" {
    name = var.lambda_producer_name
}

resource "aws_lambda_permission" "permission" {
    statement_id    = "AllowExecutionFromAPIGateway"
    action          = "lambda:InvokeFunction"
    function_name   = data.aws_lambda_function.lambda_producer.arn
    principal       = "apigateway.amazonaws.com"
    source_arn      = "arn:aws:execute-api:${var.region}:${var.accountId}:${data.aws_api_gateway_rest_api.apigw.id}/${terraform.workspace}/POST${data.aws_api_gateway_resource.resource.path}"
    qualifier       = terraform.workspace
}

resource "aws_api_gateway_deployment" "deploy" {
    rest_api_id = data.aws_api_gateway_rest_api.apigw.id

    triggers = {
        redeployment = sha1(jsonencode([data.aws_api_gateway_rest_api.apigw.body]))
    }

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_api_gateway_stage" "stage" {
    deployment_id   = aws_api_gateway_deployment.deploy.id
    rest_api_id     = data.aws_api_gateway_rest_api.apigw.id
    stage_name      = terraform.workspace
    variables       = {
        lambdaAlias = terraform.workspace
    }
}

