#!/bin/bash
export PATH=/usr/local/bin:/usr/bin:/bin

# Bash script for backup of important Linux directories to remote share
# Bas Willemstijn
# Version 0.1
# 5 june 2020

# === Variables section ===
declare -a SOURCES=("/root" "/home" "/var/www" "/var/log" "/var/lib" "/var/opt" "/var/local" "/var/backups" "/opt" "/etc" "/usr/local" "/srv")
RSYNC_OPTIONS="--verbose --archive --human-readable --progress --itemize-changes --delete" # RSync replication options

TARGET="//[SERVER-IP-ADDRESS]/[DESTINATION]/[DIRECTORY]"
MOUNTPOINT="/mnt/[LOCAL]/[DIRECTORY]"
USERNAME="[USERNAME]"
PASSWORD="[PASSWORD]"

# === Functions ===

#rsync backup

# === Script ===

logger -s "Starting the backup of this server."

# Fetch installed packages on system
dpkg --get-selections > /root/current-installed-packages.list

# Make backup of SQL Database
# mysqldump --user='USER' --password='PASS' DBNAME | gzip -9 > /root/Documents/TARGETFILENAME.sql.gz

# Check if backup disk is mounted, and if not, mount it.
if ! mountpoint -q ${MOUNTPOINT}/; then
        echo "Mounting the external file system."
        echo "Mountpoint is ${MOUNTPOINT}"
        if ! /sbin/mount.cifs ${TARGET} ${MOUNTPOINT} -o user=${USERNAME},pass=${PASSWORD},vers=2.0; then
                echo "An error code was returned by mount command!"
                exit 5
        else echo "Backup mounted successfully.";
        fi
else echo "${MOUNTPOINT} is already mounted.";
fi

# Target volume **must** be mounted by this point. If not, die screaming.
if ! mountpoint -q ${MOUNTPOINT}/; then
        echo "Mounting failed! Cannot run backup without backup volume!"
        exit 1
fi

# Start backup of directories

# Loop through the target array
for i in "${SOURCES[@]}"
do
   echo "$i"
   rsync $RSYNC_OPTIONS $i $MOUNTPOINT;
done

# Umnount target directory
umount /mnt/ActiveBackup/tatooine

logger -s "Backup of server finished."
