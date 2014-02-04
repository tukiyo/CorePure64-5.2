#!/bin/sh
set -e

if [ ! -d extract ];then
   mkdir extract
fi

cd extract
zcat ../iso_data/boot/rootfs64.gz | sudo cpio -i -H newc -d
