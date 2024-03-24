#This module is necessary for ISSUE #8 - Distribution does not utilise a WAF

resource "aws_wafv2_web_acl" "waf" {
  name  = "${var.name}-waf"
  scope = "REGIONAL" #Choices are "CLOUDFRONT" or "REGIONAL"
  default_action {
    allow {

    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.name}-waf-metric"
    sampled_requests_enabled   = true
  }

  rule {
    name     = "rule-1"
    priority = 1

    override_action {
      count {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        rule_action_override {
          action_to_use {
            count {}
          }
          name = "SizeRestrictions_QUERYSTRING"
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${var.name}-waf-rule-metric"
      sampled_requests_enabled   = true
    }
  }
}

resource "aws_wafv2_web_acl_association" "wacl_asociation" {
  resource_arn = var.target
  web_acl_arn  = aws_wafv2_web_acl.waf.arn
}