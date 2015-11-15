#!/bin/bash
#
# Script by Christoph Daniel Miksche
# License: GNU General Public License
#
# Contact:
# > http://cdm.webpage4.me
# > Twitter: CMiksche
# > GitHub: CMiksche
#
# Run as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
# Include config
source ./01-config.sh
sudo apt-get install apache2 php5
if ["$database" == "mysql"]
	then sudo apt-get install mysql-server phpmyadmin
fi
if ["$ftpserver" == "vsftpd"]
	then sudo apt-get install vsftpd
fi
# Backup
mkdir /var/www_backup
mkdir /var/www_backup/data
echo "0 3 * * 6 datum=\`date -I\` ; tar -zcf /var/www_backup/data/backup_$datum.tgz /var/www" >> /etc/crontab
# Set Rights
chown -hR "$defaultuser" /var/www
chmod -R 0777 /var/www
chown -hR "$defaultuser" /var/www_backup
chmod -R 0777 /var/www_backup

# Restart apache2
service apache2 restart
