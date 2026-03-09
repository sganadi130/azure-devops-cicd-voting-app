terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80"
    }
  }

  # backend "azurerm" {
  #   resource_group_name  = "tfstate-rg"
  #   storage_account_name = "tfstatesganadidevops"
  #   container_name       = "tfstate"
  #   key                  = "voting-app.tfstate"
  # }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  vnet_name           = var.vnet_name
  vnet_address_space  = var.vnet_address_space
  aks_subnet_prefix   = var.aks_subnet_prefix
  tags                = var.tags
}

module "acr" {
  source              = "./modules/acr"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  acr_name            = var.acr_name
  acr_sku             = var.acr_sku
  tags                = var.tags
}

module "aks" {
  source                = "./modules/aks"
  resource_group_name   = azurerm_resource_group.main.name
  location              = azurerm_resource_group.main.location
  cluster_name          = var.cluster_name
  dns_prefix            = var.dns_prefix
  kubernetes_version    = var.kubernetes_version
  node_count            = var.node_count
  min_node_count        = var.min_node_count
  max_node_count        = var.max_node_count
  node_vm_size          = var.node_vm_size
  max_pods_per_node     = var.max_pods_per_node
  aks_subnet_id         = module.network.aks_subnet_id
  acr_id                = module.acr.acr_id
  tags                  = var.tags
}
