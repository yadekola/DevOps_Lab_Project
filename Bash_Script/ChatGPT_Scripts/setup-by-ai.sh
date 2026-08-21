#!/bin/bash

# Install required packages
yum install httpd wget unzip -y

# Start and enable httpd
systemctl start httpd
systemctl enable httpd

# Move to the web root directory
cd /var/www/html

# Download HTML template
wget https://www.tooplate.com/zip-templates/2128_tween_agency.zip

# Extract the template
unzip -o 2128_tween_agency.zip

# Copy the website files to /var/www/html
cp -r 2128_tween_agency/* /var/www/html/

# Remove the downloaded files/folder
rm -rf 2128_tween_agency 2128_tween_agency.zip

# Restart httpd
systemctl restart httpd

# Check httpd status
systemctl status httpd
