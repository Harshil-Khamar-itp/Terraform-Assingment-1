resource "aws_lb" "alb" {
    name = "assingmentLB"
    internal = false
    load_balancer_type = "application"
    subnets = module.vpc.public_subnets
    enable_cross_zone_load_balancing = true
    security_groups = [aws_security_group.lbSg.id]
}

resource "aws_lb_listener" "albListener" {
  load_balancer_arn = aws_lb.alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.albTargetGroup.arn
  }
}

resource "aws_lb_target_group" "albTargetGroup" {
    name = "albTargetGroup"
    port = 80
    protocol = "HTTP"
    vpc_id = module.vpc.vpc_id
}
