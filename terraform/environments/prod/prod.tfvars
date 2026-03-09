resource_group_name = "voting-app-prod-rg"
location            = "northeurope"

tags = {
  project     = "voting-app"
  environment = "prod"
  managed_by  = "terraform"
}

vnet_name          = "voting-app-prod-vnet"
vnet_address_space = ["10.10.0.0/16"]
aks_subnet_prefix  = ["10.10.1.0/24"]

acr_name = "sganadicontainerprod"
acr_sku  = "Standard"

cluster_name       = "voting-app-prod-aks"
dns_prefix         = "votingappprod"
kubernetes_version = "1.29"
node_count         = 2
min_node_count     = 2
max_node_count     = 5
node_vm_size       = "Standard_D2s_v3"
max_pods_per_node  = 50
