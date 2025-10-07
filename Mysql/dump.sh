#!/bin/bash
# -------------------------------------------------------------------
# MySQL Daily Dump + Restore Script (Server B -> Server A)
# -------------------------------------------------------------------

# === Configuration ===
REMOTE_HOST="x.x.x.x"          # Server B
REMOTE_USER="backupuser"            # SSH user on Server B
REMOTE_DB="production_db"           # Remote MySQL DB
REMOTE_MYSQL_USER="root"
REMOTE_MYSQL_PASS="RemotePass123"

LOCAL_DB="restore_db"               # Local DB name to restore on Server A
LOCAL_MYSQL_USER="root"
LOCAL_MYSQL_PASS="LocalPass123"

BACKUP_DIR="/backup/mysql_daily"
LOG_FILE="$BACKUP_DIR/restore.log"
MAIL_TO="admin@example.com"

DATE=$(date +%F)
DUMP_FILE="mysql_backup_${REMOTE_DB}_${DATE}.sql"
REMOTE_TMP="/tmp/${DUMP_FILE}"

# Ensure directories exist
mkdir -p "$BACKUP_DIR"

# === Start Logging ===
echo "=== $(date '+%F %T') - Starting MySQL Dump & Restore ===" >> "$LOG_FILE"

# === Step 1: Dump from remote server ===
echo "[INFO] Dumping remote DB: $REMOTE_DB from $REMOTE_HOST..." >> "$LOG_FILE"
ssh ${REMOTE_USER}@${REMOTE_HOST} "mysqldump -u${REMOTE_MYSQL_USER} -p${REMOTE_MYSQL_PASS} ${REMOTE_DB} > ${REMOTE_TMP}"
if [ $? -ne 0 ]; then
    echo "[ERROR] Remote dump failed!" >> "$LOG_FILE"
    echo "MySQL dump failed on ${REMOTE_HOST}" | mail -s "MySQL Restore Failed [${DATE}]" "$MAIL_TO"
    exit 1
fi

# === Step 2: Copy dump to local server ===
scp ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_TMP} ${BACKUP_DIR}/${DUMP_FILE}
if [ $? -ne 0 ]; then
    echo "[ERROR] SCP failed!" >> "$LOG_FILE"
    echo "Failed to copy dump from ${REMOTE_HOST}" | mail -s "MySQL Restore Failed [${DATE}]" "$MAIL_TO"
    exit 1
fi

# === Step 3: Restore on local server ===
echo "[INFO] Restoring dump to local DB: $LOCAL_DB..." >> "$LOG_FILE"
mysql -u${LOCAL_MYSQL_USER} -p${LOCAL_MYSQL_PASS} ${LOCAL_DB} < ${BACKUP_DIR}/${DUMP_FILE}
if [ $? -ne 0 ]; then
    echo "[ERROR] Restore failed!" >> "$LOG_FILE"
    echo "MySQL restore failed on local server" | mail -s "MySQL Restore Failed [${DATE}]" "$MAIL_TO"
    exit 1
fi

# === Step 4: Cleanup remote & old backups ===
ssh ${REMOTE_USER}@${REMOTE_HOST} "rm -f ${REMOTE_TMP}"
find ${BACKUP_DIR} -type f -mtime +7 -name "mysql_backup_*.sql" -delete

# === Step 5: Success Notification ===
echo "[INFO] Backup and restore completed successfully!" >> "$LOG_FILE"
echo "MySQL dump and restore completed successfully on ${DATE}" | mail -s "MySQL Restore Success [${DATE}]" "$MAIL_TO"

echo "=== $(date '+%F %T') - Completed ===" >> "$LOG_FILE"

