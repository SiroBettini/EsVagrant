# Add a message of the day
cat <<EOF | sudo tee /etc/motd
 __      __   _    
 \ \    / /__| |__ 
  \ \/\/ / -_) '_ \\
   \_/\_/\___|_.__/
EOF
# Installing every needed dependencies
sudo apt update
sudo apt install apache2 libapache2-mod-php php php-curl php-cli php-mysql php-gd php-fpm -y
sudo apt install adminer -y
# Configure adminer
sudo a2enconf php\*-fpm
sudo a2enconf adminer
# Setting for Sartori's MVC
sudo a2enmod rewrite
sudo sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
# Restarting apache2 service
sudo systemctl reload apache2 && sudo systemctl restart apache2