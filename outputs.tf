# Azure Outputs

output "resource_group_name" {
  description = "The resource group name"
  value       = module.azure_storage.resource_group_name
}

output "resource_group_location" {
  description = "The resource group location"
  value       = module.azure_storage.resource_group_location
}

output "storage_account_name" {
  description = "The storage account name"
  value       = module.azure_storage.storage_account_name
}

output "static_website_endpoint" {
  description = "Static website endpoint URL (accessible directly)"
  value       = module.azure_storage.static_website_endpoint
}

# CDN Outputs (when enabled)
output "cdn_endpoint_url" {
  description = "CDN endpoint URL (when CDN is enabled)"
  value       = var.enable_cdn ? module.azure_cdn[0].cdn_endpoint_url : null
}

output "cdn_endpoint_host_name" {
  description = "CDN endpoint host name"
  value       = var.enable_cdn ? module.azure_cdn[0].cdn_endpoint_host_name : null
}