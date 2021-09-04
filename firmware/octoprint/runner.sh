#!/bin/bash
apt-get install -y socat
while true
do
	sleep 0.001
	rm -rf /dev/makergear
	echo "SOCAT: reconnectiong to klipper"
	socat pty,link=/dev/makergear,nonblock,raw,echo=0,ignoreof,waitslave tcp:rpi2.lan:8888
	# socat pty,link=/dev/makergear,waitslave tcp:rpi2.lan:8888
done
