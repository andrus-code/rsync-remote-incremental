rsync-remote-incremental
==========================
Bash script for making remote backups of linux servers using SSH and rsync. The script creates incremental backups for less storage-usage.
A full backup of all files is created at the first, after that all daily backups are incremental (with hardlinks to the full-backup, so each directory contains all files, but each file is only stored once).


