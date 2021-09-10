# RPi serial over ip

## What is this?

I have a big honkin Dell server downstairs where I run my 3D printer containers.
Octoprint, Klipper, Moonraker, Fluidd, etc. it all runs on that server.

I do not want to run jack on my RPi2 that is attached to my printer, thus I
setup socat to forward /dev/ttyACM0 over tcp/ip and have socat on the other end
to make a `/dev/makergear` device that the Klipper server attaches to.

As far as Klipper knows it is attached to a local pseudo tty.

## Notes and gotchas

### Klipper setup

See https://github.com/iphands/printing/blob/main/firmware/klipper/container/runtime/runner.sh
for details on how that end works.

### Baud rates

The 250000 baud rate is not natively supported by the tooling I am using here. I
think it might even boil down to some glibc issue.

I tried all sorts of workarounds:

- socat's `-inspeed` `-outspeed` options
- setting the tty baud rate via non standard system calls

In the end I could not get the first hop to work (RPi -> Klipper container).
Im going to try again but if anyone has ideas, please open an issue and lemme know.
