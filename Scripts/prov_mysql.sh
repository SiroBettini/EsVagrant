# Add a message of the day
cat <<EOF | sudo tee /etc/motd
  ___  ___ 
 |   \| _ )
 | |) | _ \\
 |___/|___/
EOF
# Install MySQL
sudo apt update
sudo apt install mysql-server -y
sudo systemctl start mysql.service
# Create a MySQL user, the DB, and a default user for the application
sudo mysql < "/vagrant/Scripts/db.sql"
# Set MySQL to listen on 0.0.0.0
sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i "s/.*mysqlx-bind-address.*/mysqlx-bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql.service