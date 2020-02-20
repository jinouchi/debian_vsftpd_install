#!/bin/bash
# The purpose of this script is to install and configure, and start vsftpd with anonymous-only access.
# It is recommended that you do not run this script more than once to avoid duplicate entries in your /etc/vsftpd.conf file.
# This script was adapted from instructions published by Melissa Anderson at https://www.digitalocean.com/community/tutorials/how-to-set-up-vsftpd-for-anonymous-downloads-on-ubuntu-16-04

# Install vsftpd
sudo apt-get update
sudo apt-get install vsftpd

# Backup config file
sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.orig

# Create /var/ftp directory
sudo mkdir -p /var/ftp

# Set user/group to nobody/nogroup
sudo chown nobody:nogroup /var/ftp

# Configure anonymous only access
sed -i "s/anonymous_enable=NO/anonymous_enable=YES/g" /etc/vsftpd.conf
sed -i "s/local_enable=YES/local_enable=NO/g" /etc/vsftpd.conf

echo '
# Point users at the directory we created earlier.
anon_root=/var/ftp/
#
# Stop prompting for a password on the command line.
no_anon_password=YES
#
# Show the user and group as ftp:ftp, regardless of the owner.
hide_ids=YES
#
# Limit the range of ports that can be used for passive FTP
pasv_min_port=40000
pasv_max_port=50000' >> /etc/vsftpd.conf

sudo systemctl restart vsftpd
sudo systemctl status vsftpd
