#!/bin/bash

# scipt parameters
if [ "$#" -ne 3 ]; then
    echo "usage: $0 UID GID VERSION"
    exit 1
fi

uid=$1  # 902837 gpu-monitor
gid=$2  # 11169 MLO
version=$3

# stop when command output an error
set -e

# build, tag and push the two images

# -- Nginx
docker build --no-cache --build-arg uid=$uid --build-arg gid=$gid -t gpu-monitor-nginx:$version nginx
docker tag gpu-monitor-nginx:$version ic-registry.epfl.ch/mlo/gpu-monitor-nginx:$version
docker push ic-registry.epfl.ch/mlo/gpu-monitor-nginx:$version

# -- PHP
docker build --no-cache --build-arg uid=$uid --build-arg gid=$gid -t gpu-monitor-php:$version php
docker tag gpu-monitor-php:$version ic-registry.epfl.ch/mlo/gpu-monitor-php:$version
docker push ic-registry.epfl.ch/mlo/gpu-monitor-php:$version
