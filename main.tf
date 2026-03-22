module "S3" {
  source         = "./modules/s3"
  bucket_name    = var.bucket_name
  index_document = var.index_document
}
module "cloudfront" {
  source = "./modules/cloudfront"

  bucket_domain_name = module.S3.bucket_regional_domain_name
}