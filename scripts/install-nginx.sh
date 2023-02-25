#!/bin/bash
export PATH=$PATH:/usr/bin
# install nginx
while [ ! -f /var/lib/cloud/instance/boot-finished ]; do
  echo -e "\033[1;36mWaiting for cloud-init..."
  sleep 1
done
apt-get update
apt-get -y install nginx certbot python3-certbot-nginx
ufw allow "Nginx Full"
ufw status
