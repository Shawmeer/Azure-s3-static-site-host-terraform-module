output "cloudfront_url" {
  value = aws_cloudfront_distribution.cdn.domain_name
}

output "oac_id" {
  value = aws_cloudfront_origin_access_control.oac.id
}