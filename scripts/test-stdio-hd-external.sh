#!/bin/sh -e
#./build-complete.sh

sh -e $2/scripts/build-image-external.sh $1 $2
qemu-system-i386 -m 512 -hda $2/disk.img -name "DayOS" -serial stdio
