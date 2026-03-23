# Azure Variables

variable "resource_group_name" {
  description = "The resource group name"
  type        = string
  default     = "azure-static-site-rg"
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
  default     = "samirazurestaticsite"
}

variable "location" {
  description = "The Azure region where resources will be deployed"
  type        = string
  default     = "eastus"
}

variable "storage_account_tier" {
  description = "The tier of the storage account"
  type        = string
  default     = "Standard"
}

variable "storage_account_replication_type" {
  description = "The replication type for the storage account"
  type        = string
  default     = "LRS"
}

variable "index_document" {
  description = "The index document for the static website"
  type        = string
  default     = "index.html"
}

variable "enable_cdn" {
  description = "Enable Azure CDN in front of the storage account"
  type        = bool
  default     = false
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