# Azure CDN Module
# Uses Azure CDN in front of Storage Account static website

resource "azurerm_cdn_profile" "this" {
  name                = var.cdn_profile_name
  location            = "global"
  resource_group_name = var.resource_group_name
  sku                 = var.cdn_sku
}

resource "azurerm_cdn_endpoint" "this" {
  name                = var.cdn_endpoint_name
  profile_name        = azurerm_cdn_profile.this.name
  location            = "global"
  resource_group_name = var.resource_group_name

  origin {
    name           = "storage-origin"
    host_name      = var.storage_account_primary_endpoint
    https_port     = 443
    http_port      = 80
  }

  is_http_allowed  = true
  is_https_allowed = true
}
