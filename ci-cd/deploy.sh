#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Get the base directory
WORKSPACE="$(realpath "$(dirname "${0}")/../")"
AWS_REGION="$(aws configure get region)"

# Create ECR repository
terragrunt apply -auto-approve \
           --terragrunt-working-dir "${WORKSPACE}/terraform/enviroments/staging/${AWS_REGION}/ecr"

# Build and push image to ecr
${WORKSPACE}/ci-cd/build.sh

# TODO: use secret storage(sops, ci-cd security storage, etc)
export TF_VAR_secret="tIdiDuoYsnoitalutargnoC"

# Create lightsail
terragrunt apply -auto-approve \
           --terragrunt-working-dir "${WORKSPACE}/terraform/enviroments/staging/${AWS_REGION}/lightsail"
