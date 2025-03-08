#!/usr/bin/env bash

set -e

# Get AWS account ID and region
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
AWS_REGION=$(aws configure get region)
ECR_REPO="pub-draino"

# Build version from git commit
VERSION=$(git rev-parse --short HEAD)

# Build the image
docker build --tag "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:latest" .
