#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Root check
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Installation
apt install postgresql
apt install apache2 apache2-utils
apt install php php-pgsql libapache2-mod-php

# Enter the app name
while read -r -t 0; do
    read -r
done
read -p "Enter the new app name : " APP_NAME
APP_NAME=$(echo $APP_NAME | tr '[:upper:]' '[:lower:]')

# Create the database if it doesn't exist
if sudo -u postgres psql -lqt | cut -d \| -f 1 | grep -qw $APP_NAME
then
    echo "The database $APP_NAME already exists"
else
    sudo -u postgres psql -c "CREATE DATABASE $APP_NAME;"
    sudo -u postgres psql -c "CREATE USER $APP_NAME WITH ENCRYPTED PASSWORD '$APP_NAME';"
    sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE $APP_NAME TO $APP_NAME;"
    sudo -u postgres psql -c "ALTER USER $APP_NAME WITH SUPERUSER;"
    sudo -u postgres psql -c "ALTER USER $APP_NAME WITH CREATEDB;"
    sudo -u postgres psql -c "ALTER USER $APP_NAME WITH CREATEROLE;"
    sudo -u postgres psql -c "ALTER USER $APP_NAME WITH REPLICATION;"
    sudo -u postgres psql -c "ALTER USER $APP_NAME WITH BYPASSRLS;"
    sudo -u postgres psql -c "ALTER USER $APP_NAME WITH CONNECTION LIMIT -1;"
    sudo -u postgres psql -c "ALTER USER $APP_NAME WITH VALID UNTIL 'infinity';"
fi

# Create the connect_pg.php file
CONNECT_PATH="$SCRIPT_DIR/../src/connect_database/"
cp "$CONNECT_PATH/connect_pg_example.php" "$CONNECT_PATH/connect_pg.php"
sed -i "s/\$login\s*=/    \$login = '$APP_NAME';/" "$CONNECT_PATH/connect_pg.php"
sed -i "s/\$db_pwd\s*=/    \$db_pwd = '$APP_NAME';/" "$CONNECT_PATH/connect_pg.php"
sed -i "s/\$db_name\s*=/    \$db_name = '$APP_NAME';/" "$CONNECT_PATH/connect_pg.php"

# Chek if the app already exists
if [ -d "/var/www/$APP_NAME" ]
then
    echo "The app $APP_NAME already exists"
    echo "Please delete it before running this script (rm -rf /var/www/$APP_NAME)"
    echo "If the site is already enabled try to go to http://$APP_NAME.local to access it"
    exit
fi

# Create the app folder
mkdir /var/www/$APP_NAME

# Add the app site to the hosts file
printf "127.0.0.1\t%s.local\n" "$APP_NAME" | cat - /etc/hosts > temp && mv temp /etc/hosts

# Create the app site
echo "<VirtualHost *:80>
    ServerName $APP_NAME.local
    ServerAlias www.$APP_NAME.local
    DocumentRoot /var/www/$APP_NAME
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" > /etc/apache2/sites-available/$APP_NAME.conf

# Enable the app site
a2ensite $APP_NAME > /dev/null

# Restart Apache
systemctl restart apache2

# Put the app in the app folder
SCRIPT_NAME="push_server.sh"
SCRIPT_PATH="$SCRIPT_DIR/../$SCRIPT_NAME"

sed -i "/^APP_NAME=/c\APP_NAME=\"$APP_NAME\"" "$SCRIPT_PATH"

"$SCRIPT_PATH"

# Terminal message
echo ""
echo "==============================="
echo "The app $APP_NAME has been created"
echo "Read the README.md file to know how to use properly the framework"
echo ""
echo "By default the PostgreSQL database is $APP_NAME, the user is $APP_NAME and the password is $APP_NAME"
echo "Don't forget to change them for the production"
echo ""
echo "The $APP_NAME is now available at http://$APP_NAME.local"
echo "Use the push_server.sh script to push the app to the server"