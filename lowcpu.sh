#!/bin/bash

# ==========================================
# KONFIGURASI RTSP & YOUTUBE
# ==========================================
RTSP_URL="rtsp://admin:danran1165@145.179.128.68:554/Streaming/Channels/101"

# Stream key kamu
YOUTUBE_KEY="80fv-jhh-qnnw-521u-97ub"

# Menggunakan RTMP standar tanpa TLS/SSL agar lancar di Termux
YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2/$YOUTUBE_KEY"

# ==========================================
# SKRIP STREAMING AUTOMATIS
# ==========================================
while true; do
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Memulai transmisi ke YouTube Live..."
  
  ffmpeg -loglevel info -rtsp_transport tcp -i "$RTSP_URL" \
    -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=44100 \
    -c:v copy \
    -c:a aac -b:a 128k \
    -map 0:v:0 -map 1:a:0 \
    -f flv "$YOUTUBE_URL"

  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Koneksi terputus. Mencoba menghubungkan kembali dalam 5 detik..."
  sleep 5
done
