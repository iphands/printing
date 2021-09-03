#!/bin/bash
set -e
bash sync.sh
while inotifywait -e close_write printer.cfg
do
  bash ./sync.sh
done
