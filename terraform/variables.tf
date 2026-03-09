variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "voting-app-rg"
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "northeurope"
}

variable "tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default = {
    project     = "voting-app"
    environment = "dev"
    managed_by  = "terraform"
  }
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
  default     = "voting-app-vnet"
}

variable "vnet_address_space" {
  description = "Address space for the VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "aks_subnet_prefix" {
  description = "CIDR prefix for the AKS subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "acr_name" {
  description = "Name of the Azure Container Registry (must be globally unique)"
  type        = string
  default     = "sganadicontainercicd"
}

variable "acr_sku" {
  description = "SKU tier for ACR"
  type        = string
  default     = "Basic"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.acr_sku)
    error_message = "ACR SKU must be Basic, Standard, or Premium."
  }
}

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "voting-app-aks"
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
  default     = "votingapp"
}

variable "kubernetes_version" {
  description = "Kubernetes version for AKS"
  type        = string
  default     = "1.29"
}

variable "node_count" {
  description = "Initial node count for the default node pool"
  type        = number
  default     = 1
}

variable "min_node_count" {
  description = "Minimum node count for autoscaling"
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "Maximum node count for autoscaling"
  type        = number
  default     = 3
}

variable "node_vm_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_B2s"
}

variable "max_pods_per_node" {
  description = "Maximum number of pods per node"
  type        = number
  default     = 30
}
