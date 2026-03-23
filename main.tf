# Main Azure Configuration
# Uses Azure Storage Account with Static Website (free tier)
# + Azure CDN for caching and global distribution

module "azure_storage" {
  source = "./modules/storage-account"

  resource_group_name              = var.resource_group_name
  storage_account_name             = var.storage_account_name
  location                         = var.location
  storage_account_tier             = var.storage_account_tier
  storage_account_replication_type = var.storage_account_replication_type
  index_document                   = var.index_document
}

# Azure CDN Module (Front Door alternative - cheaper than full Front Door)
# Enable this to use Azure CDN in front of the storage account
module "azure_cdn" {
  source = "./modules/cdn"

  count = var.enable_cdn ? 1 : 0

  resource_group_name              = var.resource_group_name
  cdn_profile_name                 = var.cdn_profile_name
  cdn_endpoint_name                = var.cdn_endpoint_name
  cdn_sku                          = var.cdn_sku
  storage_account_primary_endpoint = module.azure_storage.static_website_host
  index_document                   = var.index_document
}