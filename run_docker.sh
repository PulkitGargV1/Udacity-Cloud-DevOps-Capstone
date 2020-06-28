#!/usr/bin/env bash

# Build image and add a descriptive tag
docker build --tag=tourism_app .

# List docker images
docker image ls

# Run flask app
docker run -p 8000:8080 tourism_app
