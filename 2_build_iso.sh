#!/bin/sh
set -e

#SKIP_ADVDEF=0
SKIP_ADVDEF=1

echo "[info] sudo cp -a opt/ extract/"
sudo cp -a opt extract

cd extract
sudo find . | sudo cpio -o -H newc | gzip -2 > ../rootfs64.gz
cd ..

if [ $SKIP_ADVDEF -gt 0 ]; then
  echo "[skip] advdef -z4 rootfs64.gz"
else
  if [ "$(which advdef)" == "" ];then
    echo "[info] If you want to compress better, install advancecomp package. "
  else
    echo "[start] advdef -z4 rootfs64.gz"
    advdef -z4 rootfs64.gz
    echo "[end] advdef -z4 rootfs64.gz"
  fi
fi
sudo mv rootfs64.gz iso_data/boot/rootfs64.gz

if [ "$(which mkisofs)" == "" ];then
  echo "[quit] need mkisofs command. (mac: cdrtools, CentOS: genisoimage)"
  exit 1
fi
sudo mkisofs -l -J -R -V TC-custom -no-emul-boot -boot-load-size 4 -boot-info-table \
  -b boot/isolinux/isolinux.bin -c boot/isolinux/boot.cat -input-charset utf-8 \
  -o tc_$(date +%Y-%m-%d).iso ./iso_data/

ls -l *.iso
