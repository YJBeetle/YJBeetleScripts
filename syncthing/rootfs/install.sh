#!/bin/sh
#install
useradd syncthing
mkdir -p /home/syncthing/Sync/
chown -R syncthing:syncthing /home/syncthing
update-rc.d -f syncthing defaults
