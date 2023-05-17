
FROM alpine:latest

## Install Alpine Packages
RUN apk update
RUN apk upgrade -U
RUN apk add nginx
RUN apk add nginx-mod-rtmp
RUN apk add ffmpeg
RUN apk add python3
## Networking tools
#RUN apk add lsof
## Init System not needed
#Run apk add openrc

## Append to the Nginx Config
#COPY rtmp.conf /etc/nginx/rtmp.conf
COPY rtmp.conf /tmp/rtmp.conf
RUN cat /tmp/rtmp.conf >> /etc/nginx/modules/10_rtmp.conf
#RUN cat /tmp/rtmp.conf >> /etc/nginx/nginx.conf

## Create the shared directory
RUN mkdir /video_files
RUN mkdir /video_files/live
RUN mkdir /video_files/archive
RUN mkdir /video_files/clips
VOLUME /video_files
RUN chmod -R 777 /video_files

# Video Clip script into CGI server folder
COPY clip.sh /cgi-bin/clip.sh
RUN chmod +x /cgi-bin/clip.sh

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 1935/tcp
EXPOSE 80
EXPOSE 8080

CMD ["/start.sh"]
