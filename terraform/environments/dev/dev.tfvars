resource_group_name = "voting-app-dev-rg"
location            = "northeurope"

tags = {
  project     = "voting-app"
  environment = "dev"
  managed_by  = "terraform"
}

vnet_name          = "voting-app-dev-vnet"
vnet_address_space = ["10.0.0.0/16"]
aks_subnet_prefix  = ["10.0.1.0/24"]

acr_name = "sganadicontainercicd"
acr_sku  = "Basic"

cluster_name       = "voting-app-dev-aks"
dns_prefix         = "votingappdev"
kubernetes_version = "1.33.7"
node_count         = 1
min_node_count     = 1
max_node_count     = 2
node_vm_size       = "Standard_D2s_v3"
max_pods_per_node  = 30


