#!/bin/bash
# A script to perform incremental backups using rsync

set -o errexit
set -o nounset
set -o pipefail

BACKUP_DIRS=(/etc /root/backups /root/Arduino)

for f in ${BACKUP_DIRS[@]};
do
 echo ${f}
#readonly SOURCE_DIR="/home/andres/Git"
SOURCE_DIR="$f"
BACKUP_DIR="/mnt/servidorprueba${f}"
DATETIME="$(date '+%Y-%m-%d_%H:%M:%S')"
BACKUP_PATH="${BACKUP_DIR}/${DATETIME}"
LATEST_LINK="${BACKUP_DIR}/latest"


ssh backup@192.168.0.113 "mkdir -p "${BACKUP_DIR}""
rsync -av --delete \
  "${SOURCE_DIR}/" \
  --link-dest "${LATEST_LINK}" \
  --exclude=".cache" \
  backup@192.168.0.113:"${BACKUP_PATH}"\

ssh backup@192.168.0.113 "rm -rf "${LATEST_LINK}""
ssh backup@192.168.0.113 "ln -s "${BACKUP_PATH}" "${LATEST_LINK}""
done 

