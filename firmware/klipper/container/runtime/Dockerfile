FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y sudo \
    virtualenv python-dev libffi-dev build-essential \
    libncurses-dev \
    libusb-dev \
    avrdude gcc-avr binutils-avr avr-libc \
    stm32flash libnewlib-arm-none-eabi \
    gcc-arm-none-eabi binutils-arm-none-eabi libusb-1.0

# Create user
RUN useradd -ms /bin/bash klippy && adduser klippy dialout
USER klippy

#This fixes issues with the volume command setting wrong permissions
RUN mkdir /home/klippy/.config
VOLUME /home/klippy/.config

### Klipper setup ###
WORKDIR /home/klippy

COPY . klipper/
USER root
RUN echo 'klippy ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers.d/klippy && \
    chown klippy:klippy -R klipper

# This is to allow the install script to run without error
RUN ln -s /bin/true /bin/systemctl

RUN apt-get install -y socat

USER klippy
RUN ./klipper/scripts/install-ubuntu-18.04.sh

# Clean up install script workaround
RUN sudo rm -f /bin/systemctl

CMD  [ "bash", "/runner.sh" ]
