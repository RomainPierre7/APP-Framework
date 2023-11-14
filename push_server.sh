#!/bin/bash

APP_NAME="App Name"

sudo rm -rf /var/www/$APP_NAME/*
sudo cp -r src/* /var/www/$APP_NAME/
sudo mkdir /var/www/$APP_NAME/sql/
sudo cp sql/* /var/www/$APP_NAME/sql/

echo "Server updated"