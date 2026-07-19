#!/bin/bash

# === KONFIGURASI 4 KAMERA ===
RTSP_1="rtsp://username:password@IP_KAMERA_1:554/live/ch0"
RTSP_2="rtsp://username:password@IP_KAMERA_2:554/live/ch0"
RTSP_3="rtsp://username:password@IP_KAMERA_3:554/live/ch0"
RTSP_4="rtsp://username:password@IP_KAMERA_4:554/live/ch0"

YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"
STREAM_KEY="xxxx-xxxx-xxxx-xxxx-xxxx" # Ganti dengan stream key Anda

echo "Mulai menggabungkan 4 kamera ke YouTube Live..."

while true
do
    echo "[$(date)] Menghubungkan 4 kamera..."
    
    ffmpeg -hide_banner -loglevel info \
    -rtsp_transport tcp -i "$RTSP_1" \
    -rtsp_transport tcp -i "$RTSP_2" \
    -rtsp_transport tcp -i "$RTSP_3" \
    -rtsp_transport tcp -i "$RTSP_4" \
    -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=44100 \
    -filter_complex "\
    [0:v]scale=960:540[v0]; \
    [1:v]scale=960:540[v1]; \
    [2:v]scale=960:540[v2]; \
    [3:v]scale=960:540[v3]; \
    [v0][v1][v2][v3]xstack=inputs=4:layout=0_0|960_0|0_540|960_540[v]" \
    -map "[v]" -map 4:a \
    -c:v libx264 -preset veryfast -pix_fmt yuv420p -g 50 \
    -b:v 4500k -maxrate 4500k -bufsize 9000k \
    -c:a aac -b:a 128k -ar 44100 -shortest \
    -f flv "$YOUTUBE_URL/$STREAM_KEY"

    echo "[$(date)] Koneksi terputus atau ada kamera offline. Mengulang dalam 5 detik..."
    sleep 5
done
