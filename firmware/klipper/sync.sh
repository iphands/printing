#!/bin/bash
set -e

KLIPPER_GIT=/home/iphands/prog/klipper/
PRINTING_GIT=/home/iphands/printing/models

rsync -avPS ${PRINTING_GIT}/firmware/klipper/container/runtime/* root@nas.lan:/main/docker/klipper/
rsync -avPS "$KLIPPER_GIT" root@nas.lan:/main/docker/klipper/git/
rsync -avPS "${PRINTING_GIT}/firmware/klipper/printer.cfg" root@nas.lan:/main/docker/klipper/config/printer.cfg

# time docker save klipper-server | zstd -1 - > klipper.tar.zst
# rsync -avPS ./klipper.tar.zst root@nas.lan:/main/docker/klipper/

# time docker save klipper-server | lz4 -1 - > klipper.tar.lz4
# rsync -avPS ./klipper.tar.lz4 root@nas.lan:/main/docker/klipper/
