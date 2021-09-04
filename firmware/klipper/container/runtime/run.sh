#!/bin/bash

docker run --name klipper-server \
  -it \
  -v /main/docker/klipper/tmp:/tmp:rw \
  -v /main/docker/klipper/config:/home/klippy/.config \
  -v /main/docker/klipper/runner.sh:/runner.sh:ro \
  -v /main/docker/klipper/git:/home/klippy/klipper:rw \
  --device /dev/ttyACM0:/dev/ttyACM0 \
  -p 8888:8888 \
  klipper-server
