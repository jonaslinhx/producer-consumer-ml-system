# API KEY
resource "aws_api_gateway_usage_plan" "usage_plan" {
    name = "${var.apigw_name}-usagePlan"
    tags = var.mytags

    api_stages {
        api_id = aws_api_gateway_rest_api.api.id
        stage = aws_api_gateway_stage.production.stage_name
    }

    # quota_settings {
    #   limit = Maximum number of requests that can be made in a given time period.
    #   offset = Number of requests subtracted from the given limit in the initial time period.
    #   period = # DAY,WEEK,MONTH
    # }

    throttle_settings {
        burst_limit = 0 #maximum rate limit over a time ranging from one to a few seconds, depending upon whether the underlying token bucket is at its full capacity.
        rate_limit = 1
    }
}

# Attach api_key to usage_plan
resource "aws_api_gateway_usage_plan_key" "usage_plan_key" {
    key_id = aws_api_gateway_api_key.api_key.id
    usage_plan_id = aws_api_gateway_usage_plan.usage_plan.id
    key_type = "API_KEY"
}

resource "aws_api_gateway_api_key" "api_key" {
    name = "${var.apigw_name}-apiKey"
    tags = var.mytags
    value = var.api_key
}