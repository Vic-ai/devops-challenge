#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Get the base directory
WORKSPACE="$(realpath "$(dirname "${0}")/../")"
AWS_REGION="$(aws configure get region)"

app_git_url="${app_git_url:-https://github.com/Vic-ai/devops-python-sample-app}"
app_name="$(basename ${app_git_url})"
app_version='main'

# Get ECR URI repository
echo "[INFO] get ECR uri"
ecr_url="$(terragrunt output -json \
            --terragrunt-working-dir "${WORKSPACE}/terraform/enviroments/staging/${AWS_REGION}/ecr" \
            | jq --raw-output '.repositories.value[].url')"

echo "[INFO] building ${app_name} docker image "
docker build -t "${app_name}:${app_version}" \
             -t "${ecr_url}:${app_version}" \
       "${app_git_url}.git#${app_version}"

echo "[INFO] scanning ${app_name} docker image for vulnerabilities"
trivy image --ignore-unfixed --severity "HIGH,CRITICAL" \
            --no-progress --security-checks vuln \
            "${ecr_url}:${app_version}"

# Require https://github.com/awslabs/amazon-ecr-credential-helper
docker push "${ecr_url}:${app_version}"
