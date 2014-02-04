TinyCoreLinux5.2_x86_64_custom
==============================

TinyCoreLinux5.2_x86_64を簡単に再構築するために環境を用意。

実行環境
==========

* MacOS X + brew
* CentOS 6.5 x86_64

再構築方法
==========

* `sh 1_extract_rootfs64.sh`
* extractフォルダにiso_data/boot/rootfs64.gzの中身が展開されるので、好きにカスタマイズする。
* `sh 2_build_iso.sh` にてisoを作成
