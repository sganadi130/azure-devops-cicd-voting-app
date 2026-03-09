# Helm Charts — Voting Application

Helm chart for deploying the Voting App microservices on Kubernetes.

## Structure
```
helm/voting-app/
├── Chart.yaml              # Chart metadata
├── values.yaml             # Default values
├── values-dev.yaml         # Dev environment overrides
├── values-prod.yaml        # Production overrides (more replicas, higher resources)
└── templates/
    ├── vote-deployment.yaml
    ├── result-deployment.yaml
    ├── worker-deployment.yaml
    ├── redis-deployment.yaml
    └── db-deployment.yaml
```

## Features

- **Resource limits and requests** on all pods
- **Liveness and readiness probes** on vote and result services
- **Environment-specific values** for dev vs production sizing
- **imagePullSecrets** for private ACR access
- **Persistent volume** for database

## Usage

### Install (Dev)
```bash
helm install voting-app helm/voting-app -f helm/voting-app/values-dev.yaml
```

### Install (Production)
```bash
helm install voting-app helm/voting-app -f helm/voting-app/values-prod.yaml
```

### Upgrade with new image tag
```bash
helm upgrade voting-app helm/voting-app --set vote.image.tag=30
```

### Uninstall
```bash
helm uninstall voting-app
```

### Template preview (dry run)
```bash
helm template voting-app helm/voting-app -f helm/voting-app/values-dev.yaml
```

## Integration with Argo CD

Argo CD can deploy this Helm chart directly by pointing to the `helm/voting-app` path and specifying the values file for the target environment.
EOF
