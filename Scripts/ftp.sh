#!/bin/bash

HOST="192.168.1.20"        # HFCL server IP
USER="ftpuser"
PASS="ftppassword"
LOCAL_DIR="/var/log/nokia"
REMOTE_DIR="/uploads/nokia"

ftp -inv $HOST <<EOF
user $USER $PASS
cd $REMOTE_DIR
lcd $LOCAL_DIR
mput * 
bye
EOF
