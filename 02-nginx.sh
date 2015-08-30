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
# Install Packages
sudo apt-get install nginx php5-fpm vsftpd
# Set Rights
chown -hR "$defaultuser" /var/www
chmod -R 0777 /var/www
# Allow FTP Commands
sed -i "s/#write_enable=YES/write_enable=YES/g" /etc/vsftpd.conf
# Go to "sites-available"
cd /etc/nginx/sites-available
# Copy example
cp ./copy/nginxsite /etc/nginx/sites-available/"$website"
# Change Name
sed -i "s/yourdomain.com/$website/g" /etc/vsftpd.conf
# Set link
ln -s /etc/nginx/sites-available/"$website" /etc/nginx/sites-enabled/"$website"
# Restart nginx
service nginx restart
