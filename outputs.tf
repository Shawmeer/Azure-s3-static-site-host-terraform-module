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
  description = "The static website endpoint (direct access)"
  value       = module.azure_storage.static_website_endpoint
}

output "static_website_host" {
  description = "The static website host"
  value       = module.azure_storage.static_website_host
}

output "cdn_endpoint_url" {
  description = "The CDN endpoint URL"
  value       = module.azure_cdn.cdn_endpoint_url
}