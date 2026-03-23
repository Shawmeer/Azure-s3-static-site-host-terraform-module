# Azure CDN Module
# Equivalent to AWS CloudFront distribution

resource "azurerm_cdn_profile" "cdn_profile" {
  name                = var.cdn_profile_name
  location            = "global"
  resource_group_name = var.resource_group_name
  sku                 = var.cdn_sku

  tags = {
    Environment = "Dev"
    Project      = "Static Website CDN"
  }
}

resource "azurerm_cdn_endpoint" "cdn_endpoint" {
  name                = var.cdn_endpoint_name
  location            = "global"
  profile_name        = azurerm_cdn_profile.cdn_profile.name
  resource_group_name = var.resource_group_name

  origin {
    name      = "storage-origin"
    host_name = var.storage_account_primary_web_endpoint
  }

  origin_host_header = var.storage_account_primary_web_endpoint

  is_https_allowed = true
  is_http_allowed  = true

  tags = {
    Environment = "Dev"
    Project      = "Static Website CDN"
  }
}