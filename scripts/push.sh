#!/usr/bin/env bash

set -e
# Need to change to my own repo here instead of planetlabs
VERSION=$(git rev-parse --short HEAD)
docker push "planetlabs/draino:${VERSION}"
