# Panduan Deploy - Sentimen Ijazah Web App

## Struktur Folder
```
sentimen-ijazah/
├── backend/
│   ├── main.py
│   ├── requirements.txt
│   ├── render.yaml
│   └── models/
│       ├── model_terbaik_final.pkl      ← copy dari Colab
│       └── tfidf_vectorizer_final.pkl   ← copy dari Colab
└── frontend/
    ├── src/
    ├── package.json
    └── vercel.json
```

---

## STEP 1 — Download model dari Google Colab

```python
from google.colab import files
files.download('model_terbaik_final.pkl')
files.download('tfidf_vectorizer_final.pkl')
```
Letakkan kedua file ke folder `backend/models/`

---

## STEP 2 — Deploy Backend ke Render

1. Push folder `backend/` ke GitHub
2. Buka https://render.com → New Web Service
3. Konfigurasi:
   - Build Command: `pip install -r requirements.txt`
   - Start Command: `uvicorn main:app --host 0.0.0.0 --port $PORT`
4. Deploy → catat URL: `https://sentimen-ijazah-api.onrender.com`

CATATAN: Hapus `models/*.pkl` dari .gitignore agar file pkl ikut ter-push.

---

## STEP 3 — Deploy Frontend ke Vercel

1. Push folder `frontend/` ke GitHub
2. Buka https://vercel.com → New Project
3. Environment Variable: `VITE_API_URL` = URL Render dari step 2
4. Framework: Vite → Deploy

---

## Jalankan Lokal

Backend:
```bash
cd backend
pip install -r requirements.txt
uvicorn main:app --reload --port 8000
```

Frontend:
```bash
cd frontend
npm install
echo "VITE_API_URL=http://localhost:8000" > .env
npm run dev
```
Buka: http://localhost:5173

---

## Endpoint API
| Method | Path               | Fungsi                      |
|--------|--------------------|-----------------------------|
| GET    | /health            | Status server               |
| POST   | /predict           | Prediksi sentimen teks baru |
| GET    | /stats             | Statistik lengkap dataset   |
| GET    | /stats/video       | Distribusi per video        |
| GET    | /stats/agreement   | PA + Kappa anotator         |
| GET    | /model             | Info semua model            |
| GET    | /model/comparison  | Perbandingan 4 varian       |
| GET    | /model/confusion   | Confusion matrix            |
| GET    | /model/terdahulu   | Penelitian terdahulu        |
