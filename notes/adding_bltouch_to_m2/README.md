# Adding bltouch to an original Makergear M2 (12v and RAMBo 1.0d)

I started up my printer again after about two years of downtime and decided
that it was time for an upgrade. Oh boy what an upgrade it was!!

## Updating to Marlin 2.0.x

### Original firmware

My printer was shipped in 2012, and has all the original parts (spare a few
printed things and some fans).

Along with these original parts was the original firmware version. The firmware
reported itself as `1.0.0 RC2`. So not even `1.0.0` some dang release candidate!

```none
Recv: echo: External Reset
Recv: Marlin: 1.0.0 RC2
Recv: echo: Last Updated: 2012-05-30 | Author: johnny
Recv: echo: Free Memory: 4775  PlannerBufferBytes: 1232
```

### Updating to the latest

This task was not super daunting. It was a stare and compare between the Marlin
`2.0.9.1` source and the `1.0.0 RC2` source.

You can have a look see at
[all the changes](https://github.com/iphands/printing/commits/main/firmware/Marlin-2.0.x)
(and at each commit) I made starting from `2.0.9.1`.

## bltouch time!

### Ordering

I have been fascinated by auto bed leveling for years, and damn when I checked
the price of the bltouch I was shocked. $40 some dollars?! I thought:
> I should have done this ages ago!

### Looking for clues

So I had no idea about the RAMBo boards specs and how to make this thing work.
I spent a loooong time reading and googling around for clues.

Finally I got desperate and asked for help:
- https://reprap.org/forum/read.php?1,885884
- https://www.reddit.com/r/3Dprinting/comments/pfbd5y/trying_to_wire_up_a_bltouch_to_an_old_rambo_10d/
- https://www.reddit.com/r/Reprap/comments/pfb5rt/rambo_10d_bltouch_wiring_help/
- And a forum.makergear.com post that never got approved (grr)

My stuff is setup is so old though I was not hopeful for an answer.

Finally I found
[this post](https://3dprintboard.com/showthread.php?9335-Rambo-Servo-Setup-for-Auto-Bed-Leveling-for-Noobs)
which inspired some confidence in me!

This was also a
[super helpful resource/guide](https://teachingtechyt.github.io/upgrades.html#bltouch).

And finally these specs were invaluable:
- https://reprap.org/wiki/File:Rambo-conn-all.jpg
- https://reprap.org/wiki/Rambo_development
- https://docplayer.net/36972357-Rambo-1-1b-user-manual-by-reprap-electro.html
-- Or google RAMBo reprap electro guide

### Prepping the RAMBo 1.0d with Motor Ext pins

I had to soldier new header pins onto the pinless Motor Ext headers.
It was simple enough. I used some Play Doh to hold the pins in place while the
board was flipped over. Not the best job but _it works_.

Pics:
- [The start](./pics/board_nopins.jpg)
- [Setup to work](./pics/board_playdoh.jpg)
- [The aftermath](./pics/board_solderjob.jpg)

### Wiring

I had a helluvah time doing this. I was trying to only use the new Motor Ext
pins I had installed and not feeling confident about that at all.

Finally I decided to use the Motor Ext 1 row pin 1, 2 and 3 for the PWM control
of the bltouch and the Z Min pins for the detection of bltouches limit signal.

See these for reference:
- https://reprap.org/mediawiki/images/5/5c/Rambo-conn-all.jpg
- [reprap electro ref 1](./pics/specs_mx_1.jpg)
- [reprap electro ref 2](./pics/specs_mx_2.jpg)

I ended up having to cannibalize a spare servo I had lying around to steal the
connector as my bltouch kit came with only one cable that was a 5 pin connector.

### Text diagram

Looking at the front of the circuit board (left to right).
| note    | 1         | 2      | 3          | 4           | 5           |
| ------- | --------- | ------ | ---------- | ----------- | ----------- |
| Color   | white     | black  | yellow     | blue/brown  | red         |
| Purpose | z trigger | gnd    | pwm        | gnd         | +5v         |
| RAMBo   | ZMIN S    | ZMIN - | MEXT1 pin3 | MEXT1 pin 2 | MEXT1 pin 1 |

### Wiring continued!

**WARNING** readme!

I had a hard time inserting the connector of my cable into the bltouch itself.
It was funny I thought... After fussing with things I did by hand this part
should just plug and play.

I googled around to find out what the orientation was supposed to be for the
harness and noticed something _horrible_. The wires in the harness/connector
were backwards/opposite/mirrored.

Instead of: whi, bla, yel, blu, red
I had:      red, blu, yel, bla, whi

And the connector only slotted in one direction (physical). I was *bummed* I had
just done a ton of wiring and did not want to undo it all (and it was like 2am).

I opted to just cut the ribbon cable reverse it in the cable and re-twist / heat
shrink it back together. All in all that was the best option.

There are numerous reports of ^ frying boards. Be careful!

### Mounting

Newer Makergear M2's use a 24v hotend that is radically different from the one
I have. Thus none of the mounts on the interwebz work for me.

I have a fan mount I designed that I like a lot and fired up blender to modify it.
Here are some links to the old and new parts:
- [The old mount](https://github.com/iphands/printing/blob/main/makergear_m2/fanmounts/fanmounts.stl)
- [Mark I of my bltouch mount](https://github.com/iphands/printing/blob/main/makergear_m2/fanmounts/fanmounts_bltouch.stl)
- [Mark II of my bltouch mount](https://github.com/iphands/printing/blob/main/makergear_m2/fanmounts/fanmount_bltouch_extended.stl)
- [All the part files](https://github.com/iphands/printing/tree/main/makergear_m2/fanmounts)

I originally
[shimmed up the Mark I print](./pics/mount_marki.jpg)
with some nuts to make it sit low enough.
[Mark II](./pics/mount_markii.jpg)
fixes that issue.

### Firmware setup

I followed [this guide](https://teachingtechyt.github.io/upgrades.html#bltouch)
a ton. Love the guy on YouTube and he is a
[Danny Ric](https://en.wikipedia.org/wiki/Daniel_Ricciardo) fan so he is good
people in my book!

I diverged a little from his guide on the z offset calibration. Here are my [notes for
that](https://github.com/iphands/printing/blob/main/firmware/leveling/notes).

Here are my
[initial changes to the firmware](https://github.com/iphands/printing/commit/1c48b4e4f64271aa2efbf7a82c36ef1d07ce83f2#diff-e120371914922492deb62f26bc798af776e2465eb62f2a46a72505c4653fcbc3)
to get going.

Again here is the history of
[all the changes](https://github.com/iphands/printing/commits/main/firmware/Marlin-2.0.x)
I make/made to my firmware.

### Results

The bed leveling compensation is quite insane!
If I print this
[test circle](https://github.com/iphands/printing/blob/main/test/calibrate.stl)
I get dimensional accuracy of +-0.03mm. Also the first thing I did after getting
it all setup (including some z offset) was print one single layer and measure
with my calipers... the first layer height was supposed to be 0.30mm and the first
six measurements I took on the ring were 0.30mm _exactly_ on my calipers.

TODO: post some "first layer porn"

All in all I could not be happier with the upgrade!
