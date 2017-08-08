#!/bin/bash
#default
CHROOTDIR=/data/chroot

root=${CHROOTDIR}/$1

chroot ${root} /bin/login

