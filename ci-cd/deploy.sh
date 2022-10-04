#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Get the base directory
WORKSPACE="$(realpath "$(dirname "${0}")/../")"

# Create ECR repository
terragrunt apply -auto-approve \
           --terragrunt-working-dir "${WORKSPACE}/terraform/enviroments/staging/eu-west-1/ecr"

# Build and push image to ecr
${WORKSPACE}/ci-cd/build.sh

# TODO: use secret storage(soops, ci-cd security storage, etc)
export TF_VAR_secret="tIdiDuoYsnoitalutargnoC"

# Create lightsail
terragrunt apply -auto-approve \
           --terragrunt-working-dir "${WORKSPACE}/terraform/enviroments/staging/eu-west-1/lightsail"
