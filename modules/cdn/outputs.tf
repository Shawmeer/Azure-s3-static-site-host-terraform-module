# CDN Module Outputs

output "cdn_profile_name" {
  description = "The name of the CDN profile"
  value       = azurerm_cdn_profile.this.name
}

output "cdn_endpoint_name" {
  description = "The name of the CDN endpoint"
  value       = azurerm_cdn_endpoint.this.name
}

output "cdn_endpoint_host_name" {
  description = "The host name of the CDN endpoint"
  value       = azurerm_cdn_endpoint.this.fqdn
}

output "cdn_endpoint_url" {
  description = "The URL of the CDN endpoint"
  value       = "https://${azurerm_cdn_endpoint.this.fqdn}"
}
