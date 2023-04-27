module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "devpro-elb"

  load_balancer_type = "application"

  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnets
  security_groups    = [
    module.vote_service_sg.security_group_id,
    module.devproELB_sg.security_group_id
  ]

  access_logs = {
  bucket = aws_s3_bucket.alb_logs.id
}


  target_groups = [
  {
    name_prefix      = "pref-"
    backend_protocol = "HTTP"
    backend_port     = 80
    target_type      = "instance"
  }
]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"
      target_group_index = 0
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Environment = "Test"
  }
}

resource "aws_lb_target_group_attachment" "attach_instances" {
  for_each = module.ec2_instance

  target_group_arn = module.alb.target_group_arns[0]
  target_id        = each.value.id
  port             = 80
}