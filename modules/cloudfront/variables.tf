variable "bucket_domain_name" {
  description = "S3 bucket domain name"
  type        = string
}

variable "oai_comment" {
  type    = string
  default = "OAI for S3 access"
}

variable "invalidate_cache" {
  description = "Set to true to trigger CloudFront cache invalidation"
  type        = bool
  default     = false
}