#!/bin/sh

die() { printf 'FATAL: %s\n' "$1" && exit 1 ;}

[ ! -e ubuntu.qcow ] && { qemu-img create -f qcow2 ubuntu.qcow 20G || die 1 ;}

wget http://releases.ubuntu.com/19.10/ubuntu-19.10-desktop-amd64.iso

qemu-system-x86_64 -hda ubuntu.qcow -boot d -cdrom ubuntu-19.10-desktop-amd64.iso -m 640