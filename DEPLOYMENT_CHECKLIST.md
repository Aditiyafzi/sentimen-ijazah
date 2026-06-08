# 🚀 CLOUD RUN DEPLOYMENT CHECKLIST

Status deployment untuk Sentimen Ijazah ke Google Cloud Run.

---

## ✅ PROJECT STRUCTURE VERIFICATION

- [x] `backend/main.py` - API code siap
- [x] `backend/requirements.txt` - Dependencies terdefenisi
- [x] `backend/models/model_terbaik_final.pkl` - Model ada
- [x] `backend/models/tfidf_vectorizer_final.pkl` - Vectorizer ada
- [x] `backend/Dockerfile` - Dibuat untuk Cloud Run
- [x] `backend/.dockerignore` - Dibuat untuk optimize build
- [x] `backend/.gitignore` - Updated agar .pkl tidak ter-ignore
- [x] `frontend/` - React + Vite siap
- [x] `frontend/.env.example` - API URL template ada

---

## 🔐 GOOGLE CLOUD SETUP

- [x] Akun Google Cloud dibuat
- [x] Project `penilaian-sentimen` aktif
- [x] Billing account terhubung (Trial $5)
- [ ] **TODO:** Enable Cloud Run API: `gcloud services enable run.googleapis.com`
- [ ] **TODO:** Enable Artifact Registry API: `gcloud services enable artifactregistry.googleapis.com`
- [ ] **TODO:** Enable Cloud Build API: `gcloud services enable cloudbuild.googleapis.com`
- [ ] **TODO:** Configure Docker: `gcloud auth configure-docker gcr.io`

---

## 🐳 DOCKER VERIFICATION

- [ ] **TODO:** Test build lokal: `cd backend && docker build -t sentimen-test .`
- [ ] **TODO:** Test run lokal: `docker run -p 8080:8080 sentimen-test`
- [ ] **TODO:** Verify API: `curl http://localhost:8080/health`

---

## 🚀 CLOUD RUN DEPLOYMENT

- [ ] **TODO:** Deploy backend:
  ```powershell
  cd backend
  gcloud run deploy penilaian-sentimen-api `
    --source . `
    --platform managed `
    --region asia-southeast1 `
    --allow-unauthenticated `
    --memory 512Mi
  ```

- [ ] **TODO:** Catat Backend URL: `https://penilaian-sentimen-api-xxxxx.a.run.app`

- [ ] **TODO:** Test backend: 
  ```powershell
  curl https://penilaian-sentimen-api-xxxxx.a.run.app/health
  ```

---

## 🌐 VERCEL FRONTEND DEPLOYMENT

- [ ] **TODO:** Push ke GitHub (atau sync)
- [ ] **TODO:** Login ke https://vercel.com
- [ ] **TODO:** Import repository `sentimen-ijazah`
- [ ] **TODO:** Set Root Directory: `frontend`
- [ ] **TODO:** Add Environment Variable:
  - Name: `VITE_API_URL`
  - Value: `https://penilaian-sentimen-api-xxxxx.a.run.app`
- [ ] **TODO:** Deploy
- [ ] **TODO:** Catat Frontend URL: `https://sentimen-ijazah-xxx.vercel.app`

---

## 🧪 INTEGRATION TESTING

- [ ] **TODO:** Akses Frontend URL di browser
- [ ] **TODO:** Test Predict endpoint (masukkan teks, lihat hasil)
- [ ] **TODO:** Test Stats endpoint (Dashboard halaman)
- [ ] **TODO:** Test Model endpoint (Evaluasi halaman)
- [ ] **TODO:** Check console browser untuk CORS error (seharusnya tidak ada)

---

## 💰 COST MONITORING

- [ ] **TODO:** Set budget alert: https://console.cloud.google.com/billing/budgets
- [ ] **TODO:** Monitor usage: https://console.cloud.google.com/billing/reports

---

## 🐛 TROUBLESHOOTING

### Jika Build Fail:
```powershell
# Lihat logs
gcloud run services describe penilaian-sentimen-api --region asia-southeast1
```

### Jika API Error 500:
```powershell
# Check logs langsung
gcloud run services describe penilaian-sentimen-api --region asia-southeast1 --format=yaml
```

### Jika Frontend Cannot Connect:
1. Cek `VITE_API_URL` di Vercel env var
2. Pastikan trailing slash TIDAK ada (harus: `https://xxx.a.run.app`)
3. Redeploy Vercel setelah update env var

---

## 📝 NOTES

- Backend URL: ________________________
- Frontend URL: _______________________
- Deployed Date: _______________________
- Last Updated: _______________________

---

## ✨ DONE!

Setelah semua items tercek dan berwarna hijau ✅, aplikasi Anda **LIVE** di Cloud Run! 🎉
