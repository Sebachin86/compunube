#!/usr/bin/env bash
# Reviso que estén las variables y que los comandos fallen si algo sale mal.
set -Eeuo pipefail
: "${AWS_REGION:?Define AWS_REGION}"
REPO="${ECR_REPOSITORY:-equipment-api}"
ACCOUNT="$(aws sts get-caller-identity --query Account --output text)"
REGISTRY="$ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com"
aws ecr describe-repositories --repository-names "$REPO" --region "$AWS_REGION" >/dev/null 2>&1 || aws ecr create-repository --repository-name "$REPO" --region "$AWS_REGION"
aws ecr get-login-password --region "$AWS_REGION" | docker login --username AWS --password-stdin "$REGISTRY"
docker build -t "$REPO:1.0" "$(dirname "$0")/../api"
docker tag "$REPO:1.0" "$REGISTRY/$REPO:1.0"
docker push "$REGISTRY/$REPO:1.0"
echo "Imagen publicada: $REGISTRY/$REPO:1.0"
