#!/bin/bash
set -eux

HTTP_SERVER=112.124.9.243
KERNEL_URL=https://github.com/friendlyarm/linux
KERNEL_BRANCH=nanopi2-v4.4.y

# hack for me
PCNAME=`hostname`
if [ x"${PCNAME}" = x"tzs-i7pc" ]; then
    HTTP_SERVER=192.168.1.9
    KERNEL_URL=git@192.168.1.5:/devel/kernel/linux.git
    KERNEL_BRANCH=nanopi2-v4.4.y
fi

# clean
mkdir -p tmp
sudo rm -rf tmp/*

cd tmp
git clone ../../.git sd-fuse_s5p6818
cd sd-fuse_s5p6818
wget http://${HTTP_SERVER}/dvdfiles/S5P6818/images-for-eflasher/friendlycore-lite-focal-arm64-images.tgz
tar xzf friendlycore-lite-focal-arm64-images.tgz
wget http://${HTTP_SERVER}/dvdfiles/S5P6818/images-for-eflasher/emmc-flasher-images.tgz
tar xzf emmc-flasher-images.tgz
wget http://${HTTP_SERVER}/dvdfiles/S5P6818/rootfs/rootfs-friendlycore-lite-focal-arm64.tgz
tar xzf rootfs-friendlycore-lite-focal-arm64.tgz
echo hello > friendlycore-lite-focal-arm64/rootfs/root/welcome.txt
(cd friendlycore-lite-focal-arm64/rootfs/root/ && {
	wget http://${HTTP_SERVER}/dvdfiles/S5P6818/images-for-eflasher/friendlycore-lite-focal-arm64-images.tgz -O deleteme.tgz
});
./build-rootfs-img.sh friendlycore-lite-focal-arm64/rootfs friendlycore-lite-focal-arm64

# build kernel
git clone ${KERNEL_URL} --depth 1 -b ${KERNEL_BRANCH} kernel-s5p6818
KERNEL_SRC=$PWD/kernel-s5p6818 ./build-kernel.sh friendlycore-lite-focal-arm64

# build uboot
git clone https://github.com/friendlyarm/u-boot --depth 1 -b nanopi2-v2016.01 uboot-s5p6818
UBOOT_SRC=$PWD/uboot-s5p6818 ./build-uboot.sh friendlycore-lite-focal-arm64

sudo ./mk-sd-image.sh friendlycore-lite-focal-arm64
sudo ./mk-emmc-image.sh friendlycore-lite-focal-arm64
