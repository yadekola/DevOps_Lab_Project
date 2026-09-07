#!/bin/bash

# Update package list and install necessary packages
sudo apt-get update
sudo apt-get install -y apache2 wget

# Download the website files from tooplate.com
wget -O /var/www/html/index.html https://www.tooplate.com/zip/2124_templatemo.zip

# Unzip the downloaded files
sudo apt-get install -y unzip
unzip /var/www/html/index.html -d /var/www/html/

# Set permissions for the web directory
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/

# Restart Apache to apply changes
sudo systemctl restart apache2