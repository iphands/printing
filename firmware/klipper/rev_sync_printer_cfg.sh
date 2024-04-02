#!/bin/bash
set -e

KLIPPER_GIT=/home/iphands/prog/klipper/
PRINTING_GIT=/home/iphands/printing/models
SERVER=noir.lan

rsync -avPS "root@${SERVER}:/main/docker/klipper/config/printer.cfg" .
