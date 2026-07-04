# Panduan Deployment ke Railway

Projek ini sudah disesuaikan agar bisa langsung di-*deploy* ke **Railway**. Railway sangat cocok karena mendukung struktur monorepo dan secara otomatis mendeteksi konfigurasi yang diperlukan.

Ikuti langkah-langkah berikut untuk melakukan deployment:

## 1. Hubungkan Repository
1. Login ke [Railway.app](https://railway.app/).
2. Buat project baru (`New Project` -> `Deploy from GitHub repo`).
3. Pilih repository ini (`sij`).

Railway akan mulai mendeteksi, namun karena ini adalah *monorepo* (gabungan frontend dan backend), kita harus membuat dua *service* terpisah di dalam project Railway yang sama.

## 2. Deploy Backend
Saat Anda memilih repo, Railway mungkin akan mencoba mendeteksi otomatis. Hapus service default tersebut, lalu ikuti cara ini:
1. Klik tombol **New** -> **GitHub Repo** -> Pilih repository ini.
2. Segera setelah service dibuat, klik service tersebut, masuk ke tab **Settings**.
3. Di bagian **Deploy**, ubah **Root Directory** ke `/backend`.
4. Railway otomatis akan membaca `Dockerfile` di folder `backend`.
5. Buka tab **Variables** pada service backend, tambahkan (opsional, Railway sudah memberikan PORT secara default):
   - `PORT`: `8080` (Meskipun sudah diatur otomatis oleh Dockerfile yang baru kita update).

## 3. Deploy Frontend
1. Klik tombol **New** lagi di project Railway Anda -> **GitHub Repo** -> Pilih repository ini lagi.
2. Setelah service baru terbuat, klik service tersebut, lalu masuk ke tab **Settings**.
3. Di bagian **Deploy**, ubah **Root Directory** ke `/frontend`.
4. Buka tab **Variables** pada service frontend, tambahkan variabel berikut agar frontend tahu URL dari backend:
   - `VITE_API_URL`: Masukkan **Public URL dari service Backend** Anda (misalnya: `https://backend-production-xxx.up.railway.app`).
5. Railway akan mendeteksi `package.json`, menjalankan `npm run build`, lalu `npm start` (yang sekarang sudah dikonfigurasi untuk menjalankan static server `serve` berkat perubahan kita).

## 4. Konfigurasi Domain
1. Di masing-masing service (baik Backend maupun Frontend), masuk ke tab **Settings** -> bagian **Networking**.
2. Klik **Generate Domain** untuk mendapatkan URL publik gratis dari Railway.
3. Ingat untuk menyalin URL Backend ke variabel `VITE_API_URL` di Frontend dan melakukan _Redeploy_ Frontend (jika belum).

---

### Apa Saja yang Baru Saja Diubah?
- **Backend:** Mengedit `backend/Dockerfile` agar mendengarkan (listen) pada *environment variable* `$PORT` yang otomatis diberikan oleh sistem serverless seperti Railway.
- **Frontend:** Menginstal library `serve` dan menambahkan script `"start": "serve -s dist"` pada `package.json` untuk menjalankan build React statis dengan benar di mesin produksi (Railway Nixpacks).
