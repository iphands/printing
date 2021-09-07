#!/bin/bash
set -e
bash sync.sh
while inotifywait -r -e close_write .
do
  bash ./sync.sh
done
