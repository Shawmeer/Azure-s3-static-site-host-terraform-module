output "bucket_name" {
  value = aws_s3_bucket.skr_bucket.bucket
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.skr_bucket.bucket_regional_domain_name
}

output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.skr_bucket.website_endpoint
}