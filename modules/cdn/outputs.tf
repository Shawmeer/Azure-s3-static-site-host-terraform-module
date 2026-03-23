# Outputs for Azure CDN Module

output "cdn_profile_id" {
  value = azurerm_cdn_profile.cdn_profile.id
}

output "cdn_endpoint_id" {
  value = azurerm_cdn_endpoint.cdn_endpoint.id
}

output "cdn_endpoint_host_name" {
  value = azurerm_cdn_endpoint.cdn_endpoint.host_name
}

output "cdn_endpoint_url" {
  value = "https://${azurerm_cdn_endpoint.cdn_endpoint.host_name}"
}