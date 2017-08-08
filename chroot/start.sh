#!/bin/bash
#default
CHROOTDIR=/data/chroot

#check
check(){
  if [ -d $1 ]; then
    echo "Start chroot $1"
    return 1
  else
    echo "chroot not found $1"
    return 0
  fi
}

#mount
mountdir(){
  mount -t proc proc $1/proc/
  mount -t sysfs sysfs $1/sys/
  mount -B /dev/ $1/dev/
  mount -t devpts devpts $1/dev/pts/
}

#run
run(){
  start_serives=`ls -1 $1/etc/rc5.d/ | awk '{print "/etc/rc5.d/"$1" start"}'`
  chroot $1/ /bin/bash << EOF
  $start_serives
  /etc/rc.local
EOF
}

#init
if [ $1 = 'all' ]; then
  for root in ${CHROOTDIR}/*
  do
    check ${root}
    mountdir ${root}
    run ${root}
  done
else
  root=${CHROOTDIR}/$1
  check ${root} && exit
  mountdir ${root}
  run ${root}
fi
