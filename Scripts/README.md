0 2 * * * /bin/bash /root/sstp.sh >> /var/log/ems_ftp_cron.log 2>&1


#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin

# ================= Configuration =================
HOST="x.x.x.x"
USER="syslogdata"
PASS="Admin@123"

BASE_DIR="/syslog_data2/performance_report"
TODAY=$(date +%F)

PM_DIR="$BASE_DIR/pm_csv/$TODAY"
EMS_BKP_DIR="$BASE_DIR/ems_backup/$TODAY"
NE_BKP_DIR="$BASE_DIR/ne_backup/$TODAY"

LOGFILE="/var/log/ems_ftp_pull_${TODAY}.log"
LOCKFILE="/tmp/ems_ftp_pull.lock"

# Timeout settings (seconds)
SFTP_TIMEOUT=600      # 10 minutes
SCP_TIMEOUT=1800      # 30 minutes

# ================= Prevent multiple instances =================
if [ -f "$LOCKFILE" ]; then
    echo "$(date) : Script already running. Exiting..." >> "$LOGFILE"
    exit 1
fi
touch "$LOCKFILE"

# Ensure lock is always removed on exit or interruption
trap 'rm -f "$LOCKFILE"; exit' INT TERM EXIT

# Ensure local directories exist
mkdir -p "$PM_DIR" "$EMS_BKP_DIR" "$NE_BKP_DIR"

echo "===== EMS SFTP Pull Started at $(date) =====" >> "$LOGFILE"

# ================= Function for retries =================
run_with_retry() {
    local cmd="$1"
    local retries=3
    local count=1
    local success=0

    while [ $count -le $retries ]; do
        echo "Attempt $count: $cmd" >> "$LOGFILE"
        eval "$cmd" >> "$LOGFILE" 2>&1
        if [ $? -eq 0 ]; then
            success=1
            break
        fi
        echo "Attempt $count failed, retrying..." >> "$LOGFILE"
        sleep 5
        count=$((count + 1))
    done

    if [ $success -ne 1 ]; then
        echo ">> ERROR: Command failed after $retries attempts: $cmd" >> "$LOGFILE"
    fi
}

# ================= 1. PM CSV Files =================
echo ">> Pulling PM CSV files..." >> "$LOGFILE"
run_with_retry "timeout $SFTP_TIMEOUT sshpass -p '$PASS' sftp -oBatchMode=no -oStrictHostKeyChecking=no '$USER@$HOST' <<EOF
lcd $PM_DIR
cd /nfmt/data/pm-spark/csvreports/user1
mget *
bye
EOF"

# ================= 2. EMS Backup =================
echo ">> Pulling EMS Backup recursively..." >> "$LOGFILE"
run_with_retry "timeout $SCP_TIMEOUT sshpass -p '$PASS' scp -r -oStrictHostKeyChecking=no '$USER@$HOST:/nfmt/data/BackupJobs' '$EMS_BKP_DIR'"

# ================= 3. NE Backup =================
echo ">> Pulling NE Backup recursively..." >> "$LOGFILE"
run_with_retry "timeout $SCP_TIMEOUT sshpass -p '$PASS' scp -r -oStrictHostKeyChecking=no '$USER@$HOST:/nfmt/data/eml/eml_ft_data/100' '$NE_BKP_DIR'"

echo "===== EMS SFTP Pull Completed at $(date) =====" >> "$LOGFILE"

# ================= Remove lock =================
rm -f "$LOCKFILE"
trap - INT TERM EXIT









*********************************************************************************************************************************************


#!/bin/bash

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin

# ================= Configuration =================
HOST="10.136.32.10"
USER="syslogdata"
PASS="Admin@123"

BASE_DIR="/syslog_data2/performance_report"
TODAY=$(date +%F)

PM_DIR="$BASE_DIR/pm_csv/$TODAY"
EMS_BKP_DIR="$BASE_DIR/ems_backup/$TODAY"
NE_BKP_DIR="$BASE_DIR/ne_backup/$TODAY"

LOGFILE="/var/log/ems_ftp_pull.log"
LOCKFILE="/tmp/ems_ftp_pull.lock"

# Timeout settings (seconds)
SFTP_TIMEOUT=600     # 10 minutes
SCP_TIMEOUT=1800     # 30 minutes

# ================= Prevent multiple instances =================
if [ -f "$LOCKFILE" ]; then
    echo "$(date) : Script already running. Exiting..." >> "$LOGFILE"
    exit 1
fi
touch "$LOCKFILE"

													   
											

# Ensure local directories exist
mkdir -p "$PM_DIR" "$EMS_BKP_DIR" "$NE_BKP_DIR"

echo "===== EMS SFTP Pull Started at $(date) =====" >> "$LOGFILE"

														  
				  
				  
				   
				 
				   

									 
												 
									  
							 
					 
				 
		  
															   
			   
							
		

							   
																				   
	  
 

# ================= 1. PM CSV Files =================
echo ">> Pulling PM CSV files..." >> "$LOGFILE"
timeout $SFTP_TIMEOUT sshpass -p "$PASS" sftp -oBatchMode=no -oStrictHostKeyChecking=no "$USER@$HOST" <<EOF >> "$LOGFILE" 2>&1
lcd $PM_DIR
cd /nfmt/data/pm-spark/csvreports/user1
mget *
bye
EOF

if [ $? -ne 0 ]; then
    echo ">> ERROR: PM CSV files transfer failed or timed out." >> "$LOGFILE"
fi

# ================= 2. EMS Backup =================
echo ">> Pulling EMS Backup recursively..." >> "$LOGFILE"
timeout $SCP_TIMEOUT sshpass -p "$PASS" scp -r -oStrictHostKeyChecking=no "$USER@$HOST:/nfmt/data/BackupJobs" "$EMS_BKP_DIR" >> "$LOGFILE" 2>&1

if [ $? -ne 0 ]; then
    echo ">> ERROR: EMS Backup transfer failed or timed out." >> "$LOGFILE"
fi

# ================= 3. NE Backup =================
echo ">> Pulling NE Backup recursively..." >> "$LOGFILE"
timeout $SCP_TIMEOUT sshpass -p "$PASS" scp -r -oStrictHostKeyChecking=no "$USER@$HOST:/nfmt/data/eml/eml_ft_data/100" "$NE_BKP_DIR" >> "$LOGFILE" 2>&1

if [ $? -ne 0 ]; then
    echo ">> ERROR: NE Backup transfer failed or timed out." >> "$LOGFILE"
fi

# ================= Completion =================
echo "===== EMS SFTP Pull Completed at $(date) =====" >> "$LOGFILE"

# Remove lock file
rm -f "$LOCKFILE"
