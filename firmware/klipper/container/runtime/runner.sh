#!/bin/bash

/home/klippy/klippy-env/bin/python /home/klippy/klipper/klippy/klippy.py /home/klippy/.config/printer.cfg &

while true
do
  sleep 0.250
  ls /tmp/printer >/dev/null 2>&1 || continue
  echo "SOCAT: connected to /tmp/printer"
  socat tcp-listen:8888,reuseaddr,fork file:/tmp/printer,nonblock,b115200,raw,echo=0
done
