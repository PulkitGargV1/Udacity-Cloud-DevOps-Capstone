#!/usr/bin/env bash

# Create dockerpath

dockerpath="gargpulkit/udagram_app"

# Authenticate & tag
docker login --username $1 --password $2 

docker image push $dockerpath
