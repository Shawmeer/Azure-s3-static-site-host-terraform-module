# Azure Storage Account for Static Website Hosting

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "static_site" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type

  static_website {
    index_document = var.index_document
  }

  tags = {
    Environment = "Dev"
    Project      = "Static Website Hosting"
  }
}

resource "azurerm_storage_account_network_rules" "storage_network_rules" {
  storage_account_id = azurerm_storage_account.static_site.id

  default_action             = "Allow"
  bypass                      = ["AzureServices"]
  ip_rules                    = []
  virtual_network_subnet_ids  = []
}