output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.main.name
}

output "acr_login_server" {
  description = "ACR login server URL"
  value       = module.acr.acr_login_server
}

output "acr_admin_username" {
  description = "ACR admin username"
  value       = module.acr.acr_admin_username
  sensitive   = true
}

output "acr_admin_password" {
  description = "ACR admin password"
  value       = module.acr.acr_admin_password
  sensitive   = true
}

output "aks_cluster_name" {
  description = "Name of the AKS cluster"
  value       = module.aks.cluster_name
}

output "aks_kube_config" {
  description = "Kubeconfig for the AKS cluster"
  value       = module.aks.kube_config
  sensitive   = true
}

output "aks_get_credentials_command" {
  description = "Azure CLI command to get AKS credentials"
  value       = "az aks get-credentials --name ${module.aks.cluster_name} --resource-group ${azurerm_resource_group.main.name} --overwrite-existing"
}

output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = module.network.vnet_id
}

output "aks_subnet_id" {
  description = "ID of the AKS subnet"
  value       = module.network.aks_subnet_id
}
