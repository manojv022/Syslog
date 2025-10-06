#!/bin/bash
 
# ========== EMS SFTP Server Details ==========
HOST="x.x.x.x"
USER="data"
PASS="Admin@123"
 
# ========== Local Storage Paths ==========
BASE_DIR="/data/performance_report"
TODAY=$(date +%F)
 
PM_DIR="$BASE_DIR/pm_csv/$TODAY"
EMS_BKP_DIR="$BASE_DIR/ems_backup/$TODAY"
NE_BKP_DIR="$BASE_DIR/ne_backup/$TODAY"
 
# Log file
LOGFILE="/var/log/ems_ftp_pull.log"
 
# Ensure local directories exist
mkdir -p "$PM_DIR" "$EMS_BKP_DIR" "$NE_BKP_DIR"
 
echo "===== EMS SFTP Pull Started at $(date) =====" >> "$LOGFILE"
 
# 1. PM CSV Files
echo ">> Pulling PM CSV files..." >> "$LOGFILE"
sshpass -p "$PASS" sftp -oBatchMode=no -oStrictHostKeyChecking=no "$USER@$HOST" <<EOF >> "$LOGFILE" 2>&1
lcd $PM_DIR
cd /nfmt/data/pm-spark/csvreports/user1
mget *
bye
EOF
 
# 2. EMS Backup
echo ">> Pulling EMS Backup..." >> "$LOGFILE"
sshpass -p "$PASS" sftp -oBatchMode=no -oStrictHostKeyChecking=no "$USER@$HOST" <<EOF >> "$LOGFILE" 2>&1
lcd $EMS_BKP_DIR
cd /nfmt/data/BackupJobs
mget *
bye
EOF
 
# 3. NE Backup
echo ">> Pulling NE Backup..." >> "$LOGFILE"
sshpass -p "$PASS" sftp -oBatchMode=no -oStrictHostKeyChecking=no "$USER@$HOST" <<EOF >> "$LOGFILE" 2>&1
lcd $NE_BKP_DIR
cd /nfmt/data/eml/eml_ft_data/100
mget *
bye
EOF
 
echo "===== EMS SFTP Pull Completed at $(date) =====" >> "$LOGFILE"
