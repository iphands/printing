#!/bin/bash
set -e

KLIPPER_GIT=/home/iphands/prog/klipper/
PRINTING_GIT=/home/iphands/printing/models
SERVER=noir.lan

rsync -avPS ${PRINTING_GIT}/firmware/klipper/container/runtime/* root@${SERVER}:/main/docker/klipper/
rsync -avPS "$KLIPPER_GIT" root@${SERVER}:/main/docker/klipper/git/
rsync -avPS "${PRINTING_GIT}/firmware/klipper/config/*.cfg" root@${SERVER}:/main/docker/klipper/config/

# time docker save klipper-server | zstd -1 - > klipper.tar.zst
# rsync -avPS ./klipper.tar.zst root@${SERVER}:/main/docker/klipper/

# time docker save klipper-server | lz4 -1 - > klipper.tar.lz4
# rsync -avPS ./klipper.tar.lz4 root@${SERVER}:/main/docker/klipper/
