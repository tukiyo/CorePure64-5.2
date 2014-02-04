#!/bin/sh
set -e

cd extract
sudo find | sudo cpio -o -H newc | gzip -2 > ../rootfs64.gz
cd ..

advdef -z4 rootfs64.gz
sudo mv rootfs64.gz iso_data/boot/rootfs64.gz

sudo mkisofs -l -J -R -V TC-custom -no-emul-boot -boot-load-size 4 -boot-info-table \
  -b boot/isolinux/isolinux.bin -c boot/isolinux/boot.cat -input-charset utf-8 \
  -o tc_$(date -I).iso ./iso_data/

ls -l *.iso
