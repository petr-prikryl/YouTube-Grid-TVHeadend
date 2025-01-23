#!/bin/bash

# Define the source streams
SOURCE1="/usr/bin/env streamlink --stdout --default-stream best --url https://www.youtube.com/watch?v=cMukxZRThvk"
SOURCE2="/usr/bin/env streamlink --stdout --default-stream best --url https://www.youtube.com/watch?v=9d0Jzl2cNJU"
SOURCE3="/usr/bin/env streamlink --stdout --default-stream best --url https://www.youtube.com/watch?v=cHDFlWSoD-s"
SOURCE4="/usr/bin/env streamlink --stdout --default-stream best --url https://www.youtube.com/watch?v=0Ua8_c0Nphg"
SOURCE5="/usr/bin/env streamlink --stdout --default-stream best --url https://www.youtube.com/watch?v=eJlH1ieQIK8"
SOURCE6="/usr/bin/env streamlink --stdout --default-stream best --url https://www.youtube.com/watch?v=YY-IqCQHAvU"
SOURCE7="/usr/bin/env streamlink --stdout --default-stream best --url https://www.youtube.com/watch?v=Jzt5AgWGTyM"
SOURCE8="/usr/bin/env streamlink --stdout --default-stream best --url https://www.youtube.com/watch?v=CSAcxQA2shE"
SOURCE9="/usr/bin/env streamlink --stdout --default-stream best --url https://www.youtube.com/watch?v=l7WQYC733Ks"

# Create a 3x3 grid and output to stdout
/usr/bin/ffmpeg \
-i <($SOURCE1) -i <($SOURCE2) -i <($SOURCE3) -i <($SOURCE4) -i <($SOURCE5) -i <($SOURCE6) -i <($SOURCE7) -i <($SOURCE8) -i <($SOURCE9) \
-filter_complex \
"[0:v]scale=320:240[tile1]; [1:v]scale=320:240[tile2]; [2:v]scale=320:240[tile3]; \
 [3:v]scale=320:240[tile4]; [4:v]scale=320:240[tile5]; [5:v]scale=320:240[tile6]; \
 [6:v]scale=320:240[tile7]; [7:v]scale=320:240[tile8]; [8:v]scale=320:240[tile9]; \
 [tile1][tile2][tile3]hstack=3[top]; \
 [tile4][tile5][tile6]hstack=3[middle]; \
 [tile7][tile8][tile9]hstack=3[bottom]; \
 [top][middle][bottom]vstack=3[out]" \
-map "[out]" -c:v libx264 -f mpegts pipe:1
