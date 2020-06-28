#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# This is your Docker ID/path
dockerpath="gargpulkit/tourism_app"

# Run the Docker Hub container with kubernetes
kubectl run tourismapp\
	--generator=run-pod/v1\
	--image=$dockerpath\
	--port=8080

# List kubernetes pods
kubectl get pods 

# Forward the container port to a host
kubectl port-forward tourismapp 8000:8080

