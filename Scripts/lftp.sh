#!/bin/bash

# ======================================
# HFCL FTP Daily Sync from Nokia Server
# ======================================

# --- CONFIGURATION ---

HOST='X.X.X.X'                     # Nokia FTP server IP
USER='ftp_username'               # FTP username
PASS='ftp_password'               # FTP password
REMOTE_DIR='/nokia/data/'         # Remote FTP directory
LOCAL_DIR='/opt/hfcl_data/'       # Local directory to sync into
LOG_FILE='/var/log/hfcl_ftp_sync.log' # Log file

# --- START ---

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting daily FTP sync..." >> "$LOG_FILE"

# Ensure lftp is installed
if ! command -v lftp &> /dev/null; then
    echo "Error: lftp not installed." >> "$LOG_FILE"
    exit 1
fi

# Create local directory if not exist
mkdir -p "$LOCAL_DIR"

# Run the FTP sync
lftp -u "$USER","$PASS" "$HOST" <<EOF >> "$LOG_FILE" 2>&1
set ftp:ssl-allow no
mirror --verbose --delete --parallel=2 "$REMOTE_DIR" "$LOCAL_DIR"
bye
EOF
