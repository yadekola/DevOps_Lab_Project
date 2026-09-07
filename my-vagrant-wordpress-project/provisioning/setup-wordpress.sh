#!/bin/bash

# Update package list and install necessary packages
sudo apt update
sudo apt install -y apache2 mysql-server php libapache2-mod-php php-mysql wget unzip

# Start and enable Apache and MySQL services
sudo systemctl start apache2
sudo systemctl enable apache2
sudo systemctl start mysql
sudo systemctl enable mysql

# Download and set up WordPress
wget -c http://wordpress.org/latest.zip
unzip latest.zip
sudo mv wordpress /var/www/html/

# Set permissions
sudo chown -R www-data:www-data /var/www/html/wordpress
sudo chmod -R 755 /var/www/html/wordpress

# Create a MySQL database and user for WordPress
sudo mysql -e "CREATE DATABASE wordpress;"
sudo mysql -e "CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'password';"
sudo mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Configure WordPress to connect to the database
cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
sed -i "s/database_name_here/wordpress/" /var/www/html/wordpress/wp-config.php
sed -i "s/username_here/wp_user/" /var/www/html/wordpress/wp-config.php
sed -i "s/password_here/password/" /var/www/html/wordpress/wp-config.php

# Restart Apache to apply changes
sudo systemctl restart apache2

echo "WordPress setup completed!"