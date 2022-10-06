#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Get the base directory
WORKSPACE="$(realpath "$(dirname "${0}")/../")"
AWS_REGION="$(aws configure get region)"

aws ecr-public batch-delete-image \
      --repository-name devops-python-sample-app \
      --image-ids imageTag=main \
      --region 'us-east-1'

terragrunt run-all destroy \
      --terragrunt-working-dir "${WORKSPACE}/terraform/enviroments/staging/${AWS_REGION}"
