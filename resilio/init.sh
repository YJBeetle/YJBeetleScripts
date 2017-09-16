#!/bin/bash
su YJBeetle -c /etc/resilio-sync/init_user_config.sh
systemctl disable resilio-sync
systemctl enable resilio-sync-YJBeetle