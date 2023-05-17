#!/bin/sh
/usr/sbin/nginx
tail -F /var/log/nginx/access.log
