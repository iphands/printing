#!/bin/bash
set -e

_connect_to_remote_printer() {
  while true
  do
    sleep 0.250
    echo "Conneting to printer on rpi2"
    # sudo socat pty,uid=1000,gid=1000,link=/dev/ttyACM0,nonblock,raw,echo=0,ignoreof,waitslave tcp:rpi2.lan:8888
    sudo socat PTY,raw,echo=0,link=/dev/makergear tcp:rpi2.lan:8888
  done
}

_forward_fake_printer() {
  while true
  do
    sleep 0.250
    ls /tmp/printer >/dev/null 2>&1 || continue
    sudo socat -d -d tcp-l:8888,fork,keepalive,nodelay,reuseaddr /tmp/printer,nonblock,b230400,raw,echo=0
  done
}

_run_klipper() {
  while true
  do
    sleep 0.250
    [[ -c /dev/makergear ]] || { echo "not ready"; continue; }

    BAUD=`egrep ^baud /home/klippy/.config/printer.cfg  | awk '{print $2}'`
    echo "############## STARTING klipper ($BAUD)"
    sudo /home/klippy/klippy-env/bin/python /home/klippy/klipper/klippy/klippy.py /home/klippy/.config/printer.cfg -a /tmp/klippy_uds
  done
}

_fix_uds() {
  while true
  do
    sudo chmod 777 /tmp/klippy_uds || true
    sleep 0.250
  done
}

_run_moonraker() {
  sudo touch /tmp/moonraker.log
  sudo chown klippy:klippy /tmp/moonraker.log
  sudo chown klippy:klippy -R .
}

# _connect_to_remote_printer &
# sudo rm /tmp/printer || true
_run_klipper &
_fix_uds
# chmod 777 /tmp/klippy_uds
# _run_moonraker &
# _forward_fake_printer
