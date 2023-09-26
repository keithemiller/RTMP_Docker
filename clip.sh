#!/bin/sh


# ffmpeg -sseof -42 -i test1-1684093550.flv -t 60 test_eof.mp4
echo "Content-type: text/html"
echo ""
echo "Clipping the following streams:"
for each filename in /video_files/live do
  echo $filename
end for 

