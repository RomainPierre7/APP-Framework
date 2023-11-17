#!/bin/bash

APP_NAME="APP_NAME"

sudo rm -rf /var/www/$APP_NAME/*
sudo cp -r src/* /var/www/$APP_NAME/

echo "Server updated"