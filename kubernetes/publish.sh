#!/bin/bash

# Build and push the docker images before by running ../docker/publish.sh (with arguments)
set -e

kubectl delete -f . --ignore-not-found --wait=true
kubectl create -f .
