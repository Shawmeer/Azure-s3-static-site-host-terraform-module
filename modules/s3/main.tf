resource "aws_s3_bucket" "skr_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_website_configuration" "skr_bucket" {
  bucket = aws_s3_bucket.skr_bucket.id

  index_document {
    suffix = "index.html"
  }
}
resource "aws_s3_bucket_public_access_block" "skr_bucket" {
  bucket = aws_s3_bucket.skr_bucket.id

  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "allow_cloudfront" {
  bucket = aws_s3_bucket.skr_bucket.id

  depends_on = [aws_s3_bucket_public_access_block.skr_bucket]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCloudFrontServicePrincipalReadOnly"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.skr_bucket.arn}/*"
      }
    ]
  })
}
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.skr_bucket.bucket
  key          = "index.html"
  source       = "${path.module}/index.html"
  content_type = "text/html"
}