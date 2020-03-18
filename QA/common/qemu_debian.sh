#!/bin/sh

die() { printf 'FATAL: %s\n' "$1" && exit 1 ;}

[ ! -e debian.qcow ] && { qemu-img create -f qcow2 debian.qcow 20G || die 1 ;}

#qemu-system-x86_64 -drive format=raw,file=test.img 

#qemu-system-x86_64 -hda debian.qcow -m 640, file=test.img 

#qemu-system-x86_64 -hda ubuntu.qcow -boot d file=test.img -m 640

qemu-system-x86_64 -hda debian.qcow -boot d -cdrom debian-10.2.0-amd64-netinst.iso -m 640