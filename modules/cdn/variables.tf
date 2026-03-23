# CDN Module Variables

variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}

variable "cdn_profile_name" {
  description = "The name of the CDN profile"
  type        = string
  default     = "cdn-profile"
}

variable "cdn_endpoint_name" {
  description = "The name of the CDN endpoint"
  type        = string
  default     = "cdn-endpoint"
}

variable "cdn_sku" {
  description = "The SKU of the CDN profile (Standard_Microsoft, Standard_Verizon, Premium_Verizon)"
  type        = string
  default     = "Standard_Microsoft"
}

variable "storage_account_primary_endpoint" {
  description = "The primary endpoint of the storage account"
  type        = string
}

variable "index_document" {
  description = "The index document for the static website"
  type        = string
  default     = "index.html"
}

variable "enable_spa_redirect" {
  description = "Enable SPA redirect for routing"
  type        = bool
  default     = true
}

variable "custom_domain" {
  description = "Custom domain to use (optional)"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
