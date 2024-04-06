#!/bin/bash
set -e
cd ~/printing/models/firmware/klipper/slicer-configs
rsync -avPS ~/.var/app/com.prusa3d.PrusaSlicer/config/PrusaSlicer/* .
