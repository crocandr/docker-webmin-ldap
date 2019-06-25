#!/bin/bash

# default password
[ -z "$ROOT_PASSWORD" ] && { ROOT_PASSWORD="SuperSecret"; }

# set password
echo $ROOT_PASSWORD | passwd root --stdin

# run webmin
/etc/webmin/start || exit 1

#
WEBMIN_LOG="/var/webmin/webmin.log"
[ -f $WEBMIN_LOG ] && { tail -f /var/webmin/webmin.log || exit 1; }
touch /tmp/empty.txt && tail -f /tmp/empty.txt || exit 1
