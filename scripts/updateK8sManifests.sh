#!/bin/bash

set -x

# Set the repository URL
REPO_URL="https://{PersonalAccessToken}@dev.azure.com/sganadi130/voting-app/_git/voting-app"

# Clone the git repository into the /tmp directory
git clone "$REPO_URL" /tmp/temp_repo

# Navigate into the cloned repository directory
cd /tmp/temp_repo

# Set git config
git config user.email "pipeline@azuredevops.com"
git config user.name "Azure Pipeline"

# Update the image tag in the deployment manifest
sed -i "s|image:.*|image: sganadicontainercicd.azurecr.io/$2:$3|g" k8s-specifications/$1-deployment.yaml

# Verify the change
cat k8s-specifications/$1-deployment.yaml

# Add the modified files
git add .

# Commit the changes
git commit -m "Update $1 image to $2:$3"

# Push the changes back to the repository
git push

# Cleanup: remove the temporary directory
rm -rf /tmp/temp_repo
