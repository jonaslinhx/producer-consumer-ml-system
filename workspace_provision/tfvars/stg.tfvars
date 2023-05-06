region = "us-east-1"
accountId = "12345678"
mytag = {
    owner = "jonas"
    team = "ml_team"
    project = "model_deployment"
    description = "ML Backend System"
}

apigw_name = "apigw_name"
apigw_resource = "/resource_name"
lambda_producer_name = "lambda_producer_name"

# ASG
desired = 1
ec2_ami = "ami-02b2e78e9b867ffec" # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
ec2_instance_type = "m6i.xlarge"
ec2_pem_key = "devops"
ec2_security_groups = ["sg-01fc01d144cc1cea6"]
ec2_iam_role = "arn:aws:iam::302145289873:instance-profile/ecsInstanceRole"
ebs_size = 60
ec2_user_data = "linux_user_data.sh"
availability_zones = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]

# ALB
alb_vpc = "vpc-5ee62a38"
alb_subnets = ["subnet-3106b757", "subnet-4644e50e", "subnet-fab8d4a3"]
alb_target_groups = [
    "car-detector",
    "damage-detector",
    "car-info"
]