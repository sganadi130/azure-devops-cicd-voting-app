# Infrastructure as Code — Terraform

Terraform configurations to provision the complete Azure infrastructure for the Voting App CI/CD pipeline.

## Structure
```
terraform/
├── main.tf                         # Root module — orchestrates all modules
├── variables.tf                    # Input variables
├── outputs.tf                      # Output values
├── modules/
│   ├── network/                    # VNet, Subnets, NSG
│   ├── acr/                        # Azure Container Registry
│   └── aks/                        # AKS + Log Analytics + ACR pull role
└── environments/
    ├── dev/dev.tfvars              # Dev environment variables
    └── prod/prod.tfvars            # Production environment variables
```

## Resources Provisioned

| Resource | Purpose |
|----------|---------|
| Resource Group | Logical grouping for all resources |
| Virtual Network + Subnet | Network isolation for AKS |
| Network Security Group | Controls inbound traffic (NodePort, HTTP, HTTPS) |
| Azure Container Registry | Private Docker image storage |
| AKS Cluster | Kubernetes cluster with autoscaling |
| Log Analytics Workspace | Monitoring and logging for AKS |
| AcrPull Role Assignment | Allows AKS to pull images from ACR without imagePullSecrets |

## Usage

### Deploy Dev Environment
```bash
az login
cd terraform
terraform init
terraform plan -var-file="environments/dev/dev.tfvars"
terraform apply -var-file="environments/dev/dev.tfvars"
```

### Deploy Production Environment
```bash
terraform plan -var-file="environments/prod/prod.tfvars"
terraform apply -var-file="environments/prod/prod.tfvars"
```

### Connect to AKS
```bash
terraform output aks_get_credentials_command
```

### Destroy Infrastructure
```bash
terraform destroy -var-file="environments/dev/dev.tfvars"
```

## Design Decisions

1. **Modular structure** — Network, ACR, and AKS are separate reusable modules
2. **Environment separation** — Dev and Prod use different tfvars with appropriate sizing
3. **AcrPull role assignment** — AKS uses managed identity to pull from ACR, eliminating imagePullSecrets
4. **Calico network policy** — Enables pod-to-pod network security
5. **Log Analytics integration** — AKS monitoring enabled out of the box
6. **Node autoscaling** — Configured with min/max bounds per environment
7. **Remote state ready** — Backend block commented out, ready for team use
