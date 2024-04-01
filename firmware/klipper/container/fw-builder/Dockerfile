FROM fedora:36
RUN  dnf update -y
RUN  dnf install -y \
    ncurses-devel \
    libusb-devel \
    avrdude gcc-avr32-linux-gnu binutils-avr32-linux-gnu avr-libc \
    arm-none-eabi-gcc-cs arm-none-eabi-newlib \
    make avr-gcc \
    python2 \
    binutils

CMD ["sh", "-c", "cd /src/klipper && make clean && time make -j32" ]
