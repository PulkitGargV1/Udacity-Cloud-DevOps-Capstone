#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Create dockerpath

dockerpath="gargpulkit/tourism_app"

# Authenticate & tag
echo "Docker ID and Image: $dockerpath"

docker login --username $1 --password $2 
docker tag tourism_app $dockerpath:latest

# Push image to a docker repository

docker push $dockerpath:latest
