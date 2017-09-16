#!/bin/bash
### BEGIN INIT INFO
# Provides:          VMshare
# Required-Start:    $network $local_fs $remote_fs
# Required-Stop:     $network $local_fs $remote_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: VMshare
# Description:       VMshare
### END INIT INFO

# Author: YJBeetle <YJBeetle@gmail.com>

rootimg=/opt/Data-Server/VMshare/root.img
redir='-redir tcp:2222::22 -redir udp:19132::19132'

name=VMshare
BIN="/usr/bin/qemu-system-x86_64 -enable-kvm -m 6G -smp 2 -nographic ${rootimg} ${redir}"

start(){
    $BIN &
    RETVAL=$?
    if [ "$RETVAL" = "0" ]; then
        echo "$name start success"
    else
        echo "$name start failed"
    fi
}

stop(){
    pid=`ps -ef | grep -v grep | grep -i "${BIN}" | awk '{print $2}'`
    if [[ ! -z $pid ]]; then
        kill $pid
        RETVAL=$?
        if [ "$RETVAL" = "0" ]; then
            echo "$name stop success"
        else
            echo "$name stop failed"
        fi
    else
        echo "$name is not running"
        RETVAL=1
    fi
}

status(){
    pid=`ps -ef | grep -v grep | grep -i "${BIN}" | awk '{print $2}'`
    if [[ -z $pid ]]; then
        echo "$name is not running"
        RETVAL=1
    else
        echo "$name is running with PID $pid"
        RETVAL=0
    fi
}

case "$1" in
'start')
    start
    ;;
'stop')
    stop
    ;;
'status')
    status
    ;;
'restart')
    stop
    start
    RETVAL=$?
    ;;
*)
    echo "Usage: $0 { start | stop | restart | status }"
    RETVAL=1
    ;;
esac
exit $RETVAL
