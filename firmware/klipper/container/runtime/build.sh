#!/bin/bash
set -e

DOCKERFILE=/main/docker/klipper/Dockerfile
KLIPPER_SRC=/main/docker/klipper/git

# DOCKERFILE=/home/iphands/printing/models/firmware/klipper/container/runtime/Dockerfile
# KLIPPER_SRC=/home/iphands/prog/klipper

cp scripts/install-ubuntu-18.04.sh git/scripts/
# cp scripts/install_moonraker.sh git/scripts/

cd "$KLIPPER_SRC"
docker build --rm -f "$DOCKERFILE" . -t klipper
