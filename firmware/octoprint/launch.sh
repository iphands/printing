#!/bin/bash

docker kill octoprint
docker rm octoprint

docker run -d \
  -v /main/docker/octoprint/data:/octoprint:rw \
  -v /main/docker/octoprint/runner.sh:/runner.sh:ro \
  -p 8000:80 \
  --name octoprint \
  octoprint/octoprint /runner.sh
