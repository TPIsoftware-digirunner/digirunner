#!/bin/bash
tar xvf /root/digirunner.tar
cp /root/digirunner/config/application-gcp.properties /root/application-gcp.properties
chmod 777 /exports 
mv /root/digirunner/* /exports/
chown -R 1003:1004 /exports/
