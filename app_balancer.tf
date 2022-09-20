module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "7.0.0"
  # insert the 4 required variables here
  name = "${local.name}-alb"
  load_balancer_type = "application"
  vpc_id             = module.vpc.vpc_id
  subnets            =[
    module.vpc.public_subnets[0],
    module.vpc.public_subnets [1]
  ]
  security_groups    = [module.loadbalancer-sg.security_group_id]
#loadbalancer-sg    module.public_bastion_sg

#listeners
  # HTTP Listener - HTTP to HTTPS Redirect
  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
     }
    }
]
#Target group app1

target_groups = [
    {
      name_prefix      = "app1-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      deregistration_delay = 10
      health_check = {
        enabled = true
        interval =  30
        path = "/app1/index.html"
        port = "traffic-port"
        healthy_threshold = 3
        unhealthy_threshold = 3
        timeout = 6
        protocol = "HTTP"
        matcher = "200-399"
      }
      protocol_version = "HTTP1"
       # App1 Target Group - Targets
      targets = {
        my_target_1 = {
          target_id =  module.ec2_private_app1.id[0]
          port = 80
        }
        my_other_target_1 = {
          target_id =  module.ec2_private_app1.id[1]
          port = 80
        }
      }
        tags = local.common_tags #target group tags
      },
   # target group app2
   {
      name_prefix      = "app2-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      deregistration_delay = 10
      health_check = {
        enabled = true
        interval =  30
        path = "/app2/index.html"
        port = "traffic-port"
        healthy_threshold = 3
        unhealthy_threshold = 3
        timeout = 6
        protocol = "HTTP"
        matcher = "200-399"
      }
      protocol_version = "HTTP1"
       # App2 Target Group - Targets
      targets = {
        my_target_2 = {
          target_id = module.ec2_private_app2.id[0]
          port = 80
        }
        my_other_target_2 = {
          target_id = module.ec2_private_app2.id[1]
          port = 80
        }
      }
        tags = local.common_tags #target group tags
    }

  ]

   #HTTPS Listener
  https_listeners = [
    # HTTPS Listener Index = 0 for HTTPS 443
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = module.acm.acm_certificate_arn
      action_type = "fixed-response"
      fixed_response = {
        content_type = "text/plain"
        message_body = "Fixed Static message - for Root Context"
        status_code  = "200"
      }
    }, 
  ]

  # HTTPS Listener Rules
  https_listener_rules = [
    # Rule-1: /app1* should go to App1 EC2 Instances
    { 
      https_listener_index = 0
      actions = [
        {
          type               = "forward"
          target_group_index = 0
        }
      ]
      conditions = [{
        path_patterns = ["/app1*"]
      }]
    },
    # Rule-2: /app2* should go to App2 EC2 Instances    
    {
      https_listener_index = 0
      actions = [
        {
          type               = "forward"
          target_group_index = 1
        }
      ]
      conditions = [{
        path_patterns = ["/app2*"]
      }]
    },    
  ]



  tags = local.common_tags # ALB Tags
}

