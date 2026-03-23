# Terraform Variables for Azure Static Site with CDN

resource_group_name              = "azure-static-site-rg"
storage_account_name             = "samirazurestaticsite"
location                         = "eastus"
storage_account_tier             = "Standard"
storage_account_replication_type = "LRS"
index_document                   = "index.html"

# Enable CDN
enable_cdn                       = true
cdn_profile_name                 = "samir-cdn-profile"
cdn_endpoint_name                = "samir-cdn-endpoint"
cdn_sku                          = "Standard_Microsoft"