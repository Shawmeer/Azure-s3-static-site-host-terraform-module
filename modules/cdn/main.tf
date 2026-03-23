# Azure CDN Module
# Uses Azure CDN (standard Microsoft or Verizon) for content delivery

resource "azurerm_cdn_profile" "this" {
  name                = var.cdn_profile_name
  resource_group_name = var.resource_group_name
  location            = "global"
  sku                 = var.cdn_sku
  tags                = var.tags
}

resource "azurerm_cdn_endpoint" "this" {
  name                = var.cdn_endpoint_name
  profile_name        = azurerm_cdn_profile.this.name
  resource_group_name = var.resource_group_name
  location            = "global"
  
  origin {
    name       = "storage-origin"
    host_name  = var.storage_account_primary_endpoint
    https_port = 443
    http_port  = 80
  }

  tags = var.tags
}
