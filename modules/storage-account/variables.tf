# Azure Storage Account Variables

variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
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