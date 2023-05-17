
FROM alpine:latest

## Install Alpine Packages
RUN apk update
RUN apk upgrade -U
RUN apk add nginx
RUN apk add nginx-mod-rtmp
RUN apk add ffmpeg
## Networking tools
RUN apk add lsof
## Init System not needed
#Run apk add openrc

COPY start.sh /start.sh
RUN chmod +x /start.sh

## Append to the Nginx Config
COPY nginx.conf /tmp/nginx.conf
RUN cat /tmp/nginx.conf >> /etc/nginx/nginx.conf

## Create the shared directory
RUN mkdir /video_files
VOLUME /video_files

EXPOSE 1935/tcp
EXPOSE 80

CMD ["/start.sh"]
