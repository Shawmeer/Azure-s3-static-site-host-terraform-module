# Main Azure Configuration
# Equivalent to AWS S3 + CloudFront setup

module "azure_storage" {
  source = "./modules/storage-account"

  resource_group_name              = var.resource_group_name
  storage_account_name             = var.storage_account_name
  location                         = var.location
  storage_account_tier             = var.storage_account_tier
  storage_account_replication_type = var.storage_account_replication_type
  index_document                   = var.index_document
}

module "azure_cdn" {
  source = "./modules/cdn"

  resource_group_name                   = module.azure_storage.resource_group_name
  cdn_profile_name                      = var.cdn_profile_name
  cdn_endpoint_name                     = var.cdn_endpoint_name
  storage_account_primary_web_endpoint = module.azure_storage.static_website_endpoint
  cdn_sku                               = var.cdn_sku
}