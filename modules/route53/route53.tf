data "aws_route53_zone" "hosted_zone" {
  name         = var.zone_name
  #name = "${var.public_ip}."
  private_zone = false
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.hosted_zone.id
  name    = "www.${var.zone_name}"
  #name = "www.${var.public_ip}"
  type    = "CNAME"
  ttl     = 300
  #records = [aws_eip.lb.public_ip]
  records = [var.public_ip]
}