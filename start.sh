#!/bin/bash

chown -r mumble-server: mumble-server/

if [ ! -f /home/mumble-server/config/mumble-server.ini ]
then
  sed -i 's/var.lib.mumble-server/home\/mumble-server\/config/' /etc/mumble-server.ini
  cp /etc/mumble-server.ini /home/mumble-server/config
  chmod a+rw /home/mumble-server/config/mumble-server.ini
  chown -R mumble-server:adm /home/mumble-server/
  echo Created /home/mumble-server/config/mumble-server.ini. Exiting.
  exit 1
fi

echo Starting mumble-server service
sed -i 's/^INIFILE=.*/INIFILE=\/home\/mumble-server\/config\/mumble-server.ini/' /etc/init.d/mumble-server
service mumble-server start

while true
do
  sleep 3600
done
