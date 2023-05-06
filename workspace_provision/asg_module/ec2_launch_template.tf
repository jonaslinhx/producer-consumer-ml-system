resource "aws_launch_template" "template1" {
    name = "${var.mytags["project"]}-asg-template-${var.mytags["workspace"]}"
    ebs_optimized = true
    image_id = var.ec2_ami
    instance_type = var.ec2_instance_type
    instance_initiated_shutdown_behavior = "terminate"
    key_name = var.ec2_pem_key
    # Security Group in Default VPC
    vpc_security_group_ids = var.ec2_security_groups
    user_data = filebase64(var.ec2_user_data)

    # In linux the root ebs is xvda, ubuntu is sda1.
    block_device_mappings {
        device_name = "/dev/xvda"
        ebs {
            volume_size = var.ebs_size
            delete_on_termination = true
            volume_type = "gp3"
        }
    }

    capacity_reservation_specification {
        capacity_reservation_preference = "open"
    }
    
    iam_instance_profile {
        arn = var.ec2_iam_role
    }

    monitoring {
        enabled = true
    }
    
    # In addition to ASG propagated tags
    tag_specifications {
        resource_type = "instance"
        tags = {Name = "${var.mytags["project"]}-ec2-${var.mytags["workspace"]}"}
    }

    tags = var.mytags
}