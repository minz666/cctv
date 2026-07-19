#!/bin/bash

# =======================================================================
# CONFIGURATION (Silakan sesuaikan bagian ini)
# =======================================================================

# 1. URL RTSP dari IP Camera Anda
RTSP_URL="rtsp://username:password@IP_KAMERA_ANDA:554/live/ch0"

# 2. URL Server RTMP YouTube (Gunakan rtmp:// sesuai di YouTube Studio Anda)
YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"

# 3. Kunci Streaming / Stream Key dari YouTube Studio Anda
STREAM_KEY="xxxx-xxxx-xxxx-xxxx-xxxx"

# =======================================================================
# PROSES STREAMING (Jangan ubah bagian bawah ini kecuali Anda paham)
# =======================================================================

echo "=========================================================="
echo " Mulai menjalankan Live Streaming IP Camera ke YouTube... "
echo "=========================================================="

# Loop otomatis (Auto-Restart) jika koneksi ke kamera terputus
while true
do
    echo "[$(date)] Menghubungkan ke IP Camera dan mengirim ke YouTube..."
    
    ffmpeg -hide_banner -loglevel info \
    -rtsp_transport tcp -i "$RTSP_URL" \
    -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=44100 \
    -c:v libx264 -preset veryfast -pix_fmt yuv420p -g 50 \
    -b:v 2500k -maxrate 2500k -bufsize 5000k \
    -c:a aac -b:a 128k -ar 44100 \
    -map 0:v:0 -map 1:a:0 -shortest \
    -f flv "$YOUTUBE_URL/$STREAM_KEY"

    echo "[$(date)] Koneksi terputus atau kamera offline."
    echo "Mencoba menghubungkan ulang dalam 5 detik..."
    sleep 5
done
