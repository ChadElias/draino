#!/usr/bin/env bash

set -e

# Get AWS account ID and region
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
AWS_REGION=$(aws configure get region)
ECR_REPO="draino"

# Get version from git commit
VERSION=$(git rev-parse --short HEAD)

# Login to ECR
aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

# Create repository if it doesn't exist
aws ecr describe-repositories --repository-names ${ECR_REPO} || aws ecr create-repository --repository-name ${ECR_REPO}

# Push the image
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:latest 