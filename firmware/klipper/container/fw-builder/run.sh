#!/bin/bash

docker run --name klipper-fw \
  --rm \
  -it \
  -v /home/iphands/prog/klipper:/src/klipper:rw \
  klipper-fw $1
