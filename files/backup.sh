#!/bin/bash

CONF_DIR="/etc/webmin"
BCKP_DIR="/backup"

cp -rfp $CONF_DIR/* $BCKP_DIR/

