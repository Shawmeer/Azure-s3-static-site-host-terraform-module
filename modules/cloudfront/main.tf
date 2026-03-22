resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = var.oai_comment
  origin_access_control_origin_type = "s3"
  signing_protocol                  = "sigv4"
  signing_behavior                  = "always"
}

resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name = var.bucket_domain_name
    origin_id   = "S3-Origin"

    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id       = "S3-Origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  # Custom error pages for 403 and 404
  custom_error_response {
    error_code         = 403
    response_code      = 200
    response_page_path = "/index.html"
    error_caching_min_ttl = 300
  }

  custom_error_response {
    error_code         = 404
    response_code      = 200
    response_page_path = "/index.html"
    error_caching_min_ttl = 300
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

# Cache invalidation resource
# Run: terraform apply -var="invalidate_cache=true" to trigger
# Or: aws create-invalidation --distribution-id <id> --paths "/*"
resource "null_resource" "cache" {
  count = var.invalidate_cache ? 1 : 0

  triggers = {
    distribution_id = aws_cloudfront_distribution.cdn.id
  }

  provisioner "local-exec" {
    command = "aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.cdn.id} --paths '/*'"
  }
}
