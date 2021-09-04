#!/bin/bash
set -e
# socat pty,link=/dev/ttyACM0,waitslave tcp:nas.lan:8888 &
/home/klippy/klippy-env/bin/python /home/klippy/klipper/klippy/klippy.py /home/klippy/.config/printer.cfg &

while true
do
  sleep 0.250
  ls /tmp/printer >/dev/null 2>&1 || continue
  echo "SOCAT: connected to /tmp/printer"
  socat tcp-listen:8888,reuseaddr,fork file:/tmp/printer,nonblock,ispeed=250000,ospeed=250000,raw,echo=0
done
