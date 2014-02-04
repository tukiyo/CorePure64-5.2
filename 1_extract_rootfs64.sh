#!/bin/sh
set -e

if [ ! -d extract ];then
  mkdir extract
fi
cd extract

if [ "$(uname -s)" == "Darwin" ];then
  gzcat ../iso_data/boot/rootfs64.gz | sudo cpio -i
else
  zcat ../iso_data/boot/rootfs64.gz | sudo cpio -i -H newc -d
fi
