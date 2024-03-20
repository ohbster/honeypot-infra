data "aws_canonical_user_id" "current" {}
data "aws_caller_identity" "current" {}

locals {
  aws_account_map = {
    us-east-1      = "127311923021"
    us-east-2      = "033677994240"
    us-west-1      = "027434742980"
    us-west-2      = "797873946194"
    af-south-1     = "098369216593"
    ap-east-1      = "754344448648"
    ap-southeast-3 = "589379963580"
    ap-south-1     = "718504428378"
    ap-northeast-3 = "383597477331"
    ap-northeast-1 = "600734575887"
    ap-southeast-1 = "114774131450"
    ap-southeast-2 = "783225319266"
    ap-northeast-1 = "582318560864"
    ca-central-1   = "985666609251"
    eu-central-1   = "054676820928"
    eu-west-1      = "156460612806"
    eu-west-2      = "652711504416"
    eu-south-1     = "635631232127"
    eu-west-3      = "009996457667"
    eu-north-1     = "897822967062"
    me-central-1   = "076674570225"
    sa-east-1      = "507241528517"
  }
}
# module "eip" {
#   count = length(var.subnets)
#   source = "../base_modules/vpc/elastic_ip"
#   name = "${var.name}-eip"
#   tags = var.tags
#   vpc = var.vpc_id
# }

module "alb_s3_role" {
  source = "../base_modules/iam/role"
  name   = "${var.name}-alb_s3_role"
}
module "alb_log_s3" {
  source     = "../s3"
  versioning = true
}
resource "aws_s3_object" "logs_dir" {
  bucket = module.alb_log_s3.name
  key    = "AWSLogs"
  source = "/dev/null"
}
resource "aws_s3_bucket_policy" "policy" {
  #bucket = aws_s3_bucket.bucket.id
  bucket = module.alb_log_s3.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          #"AWS": "arn:aws:iam::127311923021:root" #!TODO: Must map this to region. 
          "AWS" : "arn:aws:iam::${local.aws_account_map[var.region]}:root" #!TODO: Must map this to region. 
        },
        "Action" : "s3:PutObject",
        "Resource" : "arn:aws:s3:::${module.alb_log_s3.name}/${var.name}-lb/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
      }
    ]
  })
}

module "lb_sg" {
  source    = "../security_group"
  port_list = [443, 80]
  vpc_id    = var.vpc_id
  name      = "${var.name}-lb_sg"
  tags      = var.tags
}

#toggle this
module "public_certificate" {
  source      = "../acm"
  domain_name = var.domain_name

}

resource "aws_lb" "lb" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = "application"
  #security_groups    = [aws_security_group.lb_sg.id]
  #security_groups = var.security_groups
  security_groups = [module.lb_sg.security_group_id]
  #subnets            = [for subnet in aws_subnet.public : subnet.id]
  subnets = var.subnets
 
  enable_deletion_protection = false

  access_logs {
    #bucket  = aws_s3_bucket.lb_logs.id
    #bucket = var.s3_log_bucket_id
    bucket  = module.alb_log_s3.name
    prefix  = "${var.name}-lb"
    enabled = true
  }

  tags = merge(var.tags, { Name = var.name })
}

resource "aws_lb_target_group" "alb_tg" {
  name        = "${var.name}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
  tags        = merge(var.tags, { Name = var.name })
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn = "arn:aws:acm:us-east-1:378576100664:certificate/70b47e31-1660-4fc1-97b0-67de6bce693e"
  #certificate_arn = var.certificate_arn
  certificate_arn = module.public_certificate.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
  tags = merge(var.tags, { Name = var.name })
}

