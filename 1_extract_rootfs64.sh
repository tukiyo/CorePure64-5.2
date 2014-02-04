#!/bin/sh
set -e

if [ -e extract ];then
  sudo rm -rf extract
fi
mkdir extract
cd extract

if [ "$(uname -s)" == "Darwin" ];then
  gzcat ../iso_data/boot/rootfs64.gz | sudo cpio -i
else
  zcat ../iso_data/boot/rootfs64.gz | sudo cpio -i -H newc -d
fi

cd ..

set -x
cp -a extract/opt/bootlocal.sh opt/
