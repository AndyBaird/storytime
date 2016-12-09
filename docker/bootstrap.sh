#!/bin/bash
echo "Link in preinstalled packages...";
rm -rf /root/app/node_modules
ln -s /root/node_modules /root/app/node_modules
echo "npm start the app...";
cd /root/app; npm ls --depth=0; /usr/local/bin/npm start > /root/app/app.log 2>&1 &
# echo "Launch the SSHD server...";
# /usr/sbin/sshd -D &
chmod -R 0777 /tmp
echo "Tailing the service..."
tail -f /root/app/app.log