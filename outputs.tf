output "bucket_name" {
  description = "S3 bucket name"
  value       = module.S3.bucket_name
}

output "website_endpoint" {
  description = "Static website endpoint"
  value       = module.S3.website_endpoint
}

output "cloudfront_url" {
  description = "CloudFront distribution URL"
  value       = module.cloudfront.cloudfront_url
}