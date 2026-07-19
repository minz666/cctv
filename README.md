# cctv
Streaming CCTV to Youtube
---
Tutorial
   ```Download
   git clone https://github.com/minz666/cctv.git
   ```
   ```
   cd cctv
   ```
   ```
   apt install ffmpeg
   ```
Masukkan data streaming
   ```
   nano 1cam.sh
   ```
Pilih salah satu file
   ```
   chmod +x 1cam.sh
   ```
   ```
   ./1cam.sh
   ```
---
Agar streaming tetap berjalan secara nonstop meskipun Anda menutup aplikasi terminal/SSH di HP atau komputer Anda, manfaatkan fitur `screen`:

1. Buat sesi screen baru bernama `live-cam`:
   ```
   screen -S live-cam
   ```
2. Jalankan skrip di dalam sesi tersebut:
   ```
   ./stream.sh
   ```
3. Keluar dari tampilan screen tanpa mematikan program (Detach):
   Tekan kombinasi tombol **`Ctrl + A`**, lalu lepas dan tekan **`D`**.
4. Jika ingin masuk kembali ke tampilan proses streaming kapan saja, ketik:
   ```
   screen -r live-cam
   ```

---

## 📋 Prasyarat Sistem
* **OS Linux**: Direkomendasikan Ubuntu 20.04 LTS / 22.04 LTS atau Debian.
* **Spesifikasi**:
  * **1 Kamera (Direct/Transcode)**: 1 Core CPU, 1 GB RAM cukup.
  * **2-4 Kamera (Multiview Grid)**: Minimal 2 Core CPU atau lebih (karena membutuhkan proses *encoding/transcoding* video yang berat).
* **IP Camera**: Mendukung protokol RTSP (baik format H.264 maupun H.265).
* **Koneksi Internet**: Koneksi internet lokal tempat kamera berada harus stabil untuk mengunggah data.

---

<p align="center">
      <strong>Donate</strong>
    <br>
<a href="https://ibb.co.com/Mkh8wB9H"><img src="https://i.ibb.co.com/tphZjL36/qr-Min-Z-Store-22-11-23-1700648439.jpg" alt="qr-Min-Z-Store-22-11-23-1700648439" border="0"></a>
</p>
