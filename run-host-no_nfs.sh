#!/bin/bash
TARGETIP=192.168.16.5
GWIP=192.168.16.1
SERVERIP=192.168.16.1
QEMUPATH=`pwd`/qemu-host/qemu-1.0/bin/qemu-system-arm
NFSPATH=/home/benzene/sslab/kvm/nfs/ubuntu-lucid
HOSTIMG=`pwd`/kernel-host/zImage.coderefine
#INITRD=`pwd`/rootfs/initrd.gz
INITRD=`pwd`/rootfs/initrd.img-2.6.38-1000-linaro-vexpress
SD_IMG=`pwd`/rootfs/linaro-natty-vexpress.img
QEMU_IFUP=`pwd`/qemu-host/qemu-ifup
QEMU_IFDOWN=`pwd`/qemu-host/qemu-ifdown
sudo $QEMUPATH \
     -M vexpress-a9 \
     -cpu cortex-a9 \
     -kernel $HOSTIMG \
     -net nic -net tap,script=$QEMU_IFUP,downscript=$QEMU_IFDOWN \
     -m 1024 \
     -smp 1 \
     -nographic \
     -drive if=sd,cache=writeback,file=$SD_IMG \
     -initrd $INITRD \
     -append "root=/dev/mmcblk0p2 rw mem=1024M raid=noautodetect console=ttyAMA0,38400n8 rootwait vmalloc=256MB devtmpfs.mount=0 ip=$TARGETIP::$GWIP:255.255.255.0" 

#     -append "root=/dev/nfs rw mem=1024M console=ttyAMA0,38400n8 ip=$TARGETIP::$GWIP:255.255.255.0 nfsroot=$SERVERIP:$NFSPATH"
