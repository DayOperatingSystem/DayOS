#!/bin/sh

rm -f $1/ramdisk.tar

#mkdir -p rootsys/image/system
#cp $1/kernel rootsys/
#cp $1/uname rootsys/image
#cp $1/basic rootsys/image
#cp $1/*.elf rootsys/image
#cp $1/*.drv rootsys/image/system

cp -r $2/modules/Base/shell/lisp/ $1/image

# Ramdisk bauen
cp $2/modules/Base/init/init.cfg $1/image
cd $1/image
tar -H gnu -cvf $1/ramdisk.tar .
cd $2

# Image einhängen.
sh $2/scripts/mount-image.sh

# Ordner erstellen
mkdir -p $2/img/dayos/bin
mkdir -p $2/img/boot/grub2

# Den DayOS-Kernel auf das Image kopieren.
cp $1/kernel $2/img/dayos/bin
# Die RAM-Disk kopieren
cp $1/ramdisk.tar $2/img/dayos
# Die menu.lst auf das Image kopieren.
cp $2/scripts/grub/grub.cfg $2/img/boot/grub2/grub.cfg
cp $2/scripts/grub/grub.cfg $2/img/boot/grub/grub.cfg
# sudo cp scripts/grub/splash.xpm.gz img/boot/grub/splash.xpm.gz

# einen Moment warten
sleep 1

# Image aushängen.
#sudo umount img/
#sudo losetup -D

#rmdir img/
sync
