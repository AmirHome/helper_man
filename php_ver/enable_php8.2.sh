#!/usr/bin/env bash

# Enable php 8.2
sudo a2dismod php5.6
sudo a2dismod php7.0 
sudo a2dismod php7.1
sudo a2dismod php7.4 
sudo a2dismod php8.0 
sudo a2dismod php8.1

sudo a2enmod php8.2
sudo update-alternatives --set php /usr/bin/php8.2
sudo service apache2 restart
