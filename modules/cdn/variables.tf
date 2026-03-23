# Azure CDN Module Variables

variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be deployed"
  type        = string
  default     = "global"
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

variable "storage_account_primary_web_endpoint" {
  description = "The primary web endpoint of the storage account"
  type        = string
}

variable "cdn_sku" {
  description = "The SKU of the CDN profile"
  type        = string
  default     = "Standard_Microsoft"
}