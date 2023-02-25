#!/bin/bash
set +x
echo "$1"
while ! nslookup www.bohra.co.uk | grep -i "$1" -q; do
  echo -e "\033[1;36mWaiting for dns..."
  sleep 1
done
