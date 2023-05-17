#!/bin/sh

# Start NGINX
/usr/sbin/nginx

# Start Python HTTP CGI Server
python3 -m http.server --cgi 8080 & 

tail -F /var/log/nginx/access.log
