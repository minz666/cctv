#!/bin/bash

# === KONFIGURASI 2 KAMERA ===
RTSP_1="rtsp://username:password@IP_KAMERA_1:554/live/ch0"
RTSP_2="rtsp://username:password@IP_KAMERA_2:554/live/ch0"

YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"
STREAM_KEY="xxxx-xxxx-xxxx-xxxx-xxxx" # Ganti dengan stream key Anda

echo "Mulai menggabungkan 2 kamera ke YouTube Live..."

while true
do
    echo "[$(date)] Menghubungkan kamera..."
    
    ffmpeg -hide_banner -loglevel info \
    -rtsp_transport tcp -i "$RTSP_1" \
    -rtsp_transport tcp -i "$RTSP_2" \
    -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=44100 \
    -filter_complex "\
    nullsrc=size=1920x1080[base]; \
    [0:v]scale=960:540[cam1]; \
    [1:v]scale=960:540[cam2]; \
    [base][cam1]overlay=0:270[tmp]; \
    [tmp][cam2]overlay=960:270[v]" \
    -map "[v]" -map 2:a \
    -c:v libx264 -preset veryfast -pix_fmt yuv420p -g 50 \
    -b:v 3500k -maxrate 3500k -bufsize 7000k \
    -c:a aac -b:a 128k -ar 44100 -shortest \
    -f flv "$YOUTUBE_URL/$STREAM_KEY"

    echo "[$(date)] Koneksi terputus. Mengulang dalam 5 detik..."
    sleep 5
done
