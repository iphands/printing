#!/bin/bash

docker stop klipper-server
docker rm klipper-server

docker run --name klipper-server \
  -it \
  -v /main/docker/klipper/tmp:/tmp:rw \
  -v /main/docker/klipper/config:/home/klippy/.config \
  -v /main/docker/klipper/runner.sh:/runner.sh:ro \
  -v /main/docker/klipper/git:/home/klippy/klipper:rw \
  -v /main/docker/klipper/gcodes:/opt/printer_data/gcodes:rw \
  --device /dev/makergear:/dev/makergear \
  -p 8888:8888 \
  klipper-server
