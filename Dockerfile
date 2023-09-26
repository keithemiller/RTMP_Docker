FROM alpine:latest

## Install Alpine Packages
RUN apk update
RUN apk upgrade -U
RUN apk add nginx
RUN apk add nginx-mod-rtmp
RUN apk add ffmpeg
RUN apk add python3
## Networking tools
# RUN apk add lsof
## Init System not needed
# Run apk add openrc

## Append to the Nginx Config
#COPY rtmp.conf /etc/nginx/rtmp.conf
COPY rtmp.conf /tmp/rtmp.conf
#COPY rtmp2.conf /tmp/rtmp.conf
RUN cat /tmp/rtmp.conf >> /etc/nginx/modules/10_rtmp.conf
#RUN cat /tmp/rtmp.conf > /etc/nginx/modules/10_rtmp.conf

## Append to the sites-available/rtmp
COPY sites_available_append.txt /tmp/sites_available_append.txt
RUN mkdir /etc/nginx/sites-available/
RUN cat /tmp/sites_available_append.txt >> /etc/nginx/sites-available/rtmp

## Create HLS/Dash stream directory
RUN mkdir /var/www/html/
RUN mkdir /var/www/html/stream
RUN chmod -R 777 /var/www
#RUN chown -R www-data:www-data /var/www

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
EXPOSE 8088
EXPOSE 8080

CMD ["/start.sh"]
