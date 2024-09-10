#!/bin/bash

# Check if environment argument is provided
if [ -z "$1" ]; then
  echo "Usage: ./start.sh <env>"
  exit 1
fi

# Set the environment variable
ENV=$1

# Function to check if the backend is local
is_local_backend() {
  if grep -q 'backend "local"' "terraform.tf"; then
    return 0  
  else
    return 1
  fi
}

# Clean local files if not using local backend
if is_local_backend; then
  echo "Detected local backend. Skipping cleanup of .terraform files to preserve state."
else
  echo "Detected remote backend. Cleaning local files..."
  if [ -f ".terraform.lock.hcl" ]; then
    rm .terraform.lock.hcl
    echo "Deleted .terraform.lock.hcl"
  else
    echo ".terraform.lock.hcl not found"
  fi

  if [ -d ".terraform" ]; then
    rm -rf .terraform
    echo "Deleted .terraform directory"
  else
    echo ".terraform directory not found"
  fi
fi

# Prepare environment
echo "Setting up environment for ${ENV}..."
export TF_VAR_environment=$ENV

# Initialize Terraform with the specified backend configuration
terraform init -backend-config="${ENV}.env.tfbackend" -reconfigure

# Check if the workspace already exists
if terraform workspace list | grep -q "${ENV}"; then
  terraform workspace select "${ENV}"
else
  terraform workspace new "${ENV}"
fi

echo "Environment setup complete for ${ENV}"
echo "Current environment: ${ENV}"
