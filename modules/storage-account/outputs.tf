# Outputs for Azure Storage Account Module

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "resource_group_location" {
  value = azurerm_resource_group.rg.location
}

output "storage_account_name" {
  value = azurerm_storage_account.static_site.name
}

output "storage_account_id" {
  value = azurerm_storage_account.static_site.id
}

output "static_website_endpoint" {
  value = azurerm_storage_account.static_site.primary_web_endpoint
}

output "static_website_host" {
  value = azurerm_storage_account.static_site.primary_web_host
}