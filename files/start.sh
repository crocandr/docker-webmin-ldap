#!/bin/bash

# default password
[ -z "$ROOT_PASSWORD" ] && { ROOT_PASSWORD="SuperSecret"; }

# set password
echo $ROOT_PASSWORD | passwd root --stdin

# run webmin
/etc/webmin/start || exit 1

#
tail -f /var/webmin/webmin.log || exit 1
