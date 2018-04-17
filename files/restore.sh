#!/bin/bash

CONF_DIR="/etc/webmin"
BCKP_DIR="/backup"

cp -rfp $BCKP_DIR/* $CONF_DIR/ && \
  echo "Please restart Webmin container to activate restored config!"
