resource "aws_autoscaling_group" "asg" {
    name = "AssignmentASG"
    min_size = 1
    max_size = 4
    desired_capacity = 1
    vpc_zone_identifier = module.vpc.public_subnets
    launch_template {
        name = aws_launch_template.ec2Lt.name
        version = "$Latest"
    }
}

resource "aws_autoscaling_policy" "asgPolicy" {
    name = "asgPolicy"
    adjustment_type = "ChangeInCapacity"
    policy_type = "TargetTrackingScaling"
    target_tracking_configuration {
      predefined_metric_specification {
        predefined_metric_type = "ASGAverageCPUUtilization"
      }
      target_value = 60
    }
    autoscaling_group_name = aws_autoscaling_group.asg.name
  
}

resource "aws_launch_template" "ec2Lt" {
    name = "hklt"
    image_id = var.ami
    instance_type = "t2.micro"
    key_name = aws_key_pair.ec2Key.key_name
    vpc_security_group_ids = [aws_security_group.ec2Sg.id]
    tags = {
      "Name" = "AssignmentLT"
      "Owner" = "harshil.khamar@intuitive.cloud"
    }
    tag_specifications {
      resource_type = "instance"
      tags = {
        "Name" = "AssignmentEc2"
        "Owner" = "harshil.khamar@intuitive.cloud"
      }
    }
    user_data = base64encode(templatefile("nginx.tftpl",{db_address = module.rds.db_instance_address}))
}

resource "aws_autoscaling_attachment" "asgAttachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  lb_target_group_arn = aws_lb_target_group.albTargetGroup.arn
}
