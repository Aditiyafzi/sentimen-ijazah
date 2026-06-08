# 🚀 CLOUD RUN DEPLOYMENT - QUICK REFERENCE

Copy-paste commands untuk deploy ke Google Cloud Run.

---

## 📦 STEP 1: SETUP GOOGLE CLOUD

```powershell
# Set project
gcloud config set project penilaian-sentimen

# Enable APIs
gcloud services enable run.googleapis.com
gcloud services enable artifactregistry.googleapis.com
gcloud services enable cloudbuild.googleapis.com

# Configure Docker
gcloud auth configure-docker gcr.io
```

---

## 🐳 STEP 2: DEPLOY BACKEND

```powershell
# Navigate to backend
cd backend

# Deploy to Cloud Run
gcloud run deploy penilaian-sentimen-api `
  --source . `
  --platform managed `
  --region asia-southeast1 `
  --allow-unauthenticated `
  --memory 512Mi `
  --timeout 3600
```

**Output akan memberikan URL seperti:**
```
Service URL: https://penilaian-sentimen-api-xxxxxx.a.run.app
```

**CATAT URL INI! Nanti untuk frontend.**

---

## ✅ STEP 3: TEST BACKEND

```powershell
# Replace URL dengan URL Anda
$url = "https://penilaian-sentimen-api-xxxxxx.a.run.app"

# Test health endpoint
curl "$url/health"

# Test predict endpoint
$body = @{ text = "ijazah jokowi bagus" } | ConvertTo-Json
Invoke-RestMethod -Uri "$url/predict" -Method Post -ContentType "application/json" -Body $body
```

---

## 🌐 STEP 4: DEPLOY FRONTEND (VERCEL)

### Manual Setup:

1. Login ke https://vercel.com
2. Import repository → Select `sentimen-ijazah`
3. Configure:
   - **Root Directory:** `frontend`
   - **Build Command:** `npm run build`
   - **Output Directory:** `dist`
4. Add Environment Variable:
   - **Name:** `VITE_API_URL`
   - **Value:** `https://penilaian-sentimen-api-xxxxxx.a.run.app` (ganti dengan URL Anda)
5. Click **Deploy**

### Via CLI (jika sudah install Vercel CLI):

```bash
cd frontend
vercel --env VITE_API_URL=https://penilaian-sentimen-api-xxxxxx.a.run.app
```

---

## 🔍 MONITORING & DEBUGGING

### Check service status
```powershell
gcloud run services list --region asia-southeast1
```

### View service details
```powershell
gcloud run services describe penilaian-sentimen-api --region asia-southeast1
```

### View logs
```powershell
gcloud run services describe penilaian-sentimen-api --region asia-southeast1 --format=yaml
```

### Or access Cloud Console
```
https://console.cloud.google.com/run?project=penilaian-sentimen
```

---

## 🔄 UPDATE DEPLOYMENT

Jika ada changes di backend:

```powershell
cd backend

# Redeploy (akan auto-detect changes)
gcloud run deploy penilaian-sentimen-api `
  --source . `
  --platform managed `
  --region asia-southeast1 `
  --allow-unauthenticated
```

---

## 💻 TEST LOCALLY (SEBELUM DEPLOY)

### Backend
```powershell
cd backend

# Option 1: Using run script
.\run_local.bat

# Option 2: Manual
python -m venv venv
.\venv\Scripts\Activate.ps1
pip install -r requirements.txt
uvicorn main:app --reload --port 8000
```

### Frontend (terminal baru)
```powershell
cd frontend
npm install
echo "VITE_API_URL=http://localhost:8000" | Out-File -Encoding UTF8 .env
npm run dev
```

Buka: http://localhost:5173

---

## 📊 BILLING & COST

### View billing
```
https://console.cloud.google.com/billing?project=penilaian-sentimen
```

### Set budget alert
```
https://console.cloud.google.com/billing/budgets?project=penilaian-sentimen
```

### Cloud Run pricing
- **Free tier:** 2 juta requests/bulan
- **Pay-per-use:** $0.40 per 1 juta requests (after free tier)
- **CPU/Memory:** Based on actual usage

Your credit: **$5** (dari Trial account)

---

## 🚨 COMMON ISSUES & FIXES

### Error: "gcloud command not found"
```powershell
# Restart PowerShell or system
# Reinstall Google Cloud SDK from https://cloud.google.com/sdk/docs/install
```

### Error: "Models not found"
```
Make sure backend/models/ has:
- model_terbaik_final.pkl
- tfidf_vectorizer_final.pkl
```

### Error: "Frontend cannot connect to backend"
```
1. Check VITE_API_URL in Vercel Environment Variables
2. Must be: https://penilaian-sentimen-api-xxxxxx.a.run.app
3. NO trailing slash
4. Redeploy Vercel after updating env var
```

### Port 8000 already in use (lokal)
```powershell
# Find process using port 8000
Get-Process -Id (Get-NetTCPConnection -LocalPort 8000).OwningProcess

# Kill process
Stop-Process -Id <PID> -Force
```

---

## 📞 USEFUL LINKS

- **Cloud Console:** https://console.cloud.google.com
- **Cloud Run Dashboard:** https://console.cloud.google.com/run
- **Billing Dashboard:** https://console.cloud.google.com/billing
- **Vercel Dashboard:** https://vercel.com/dashboard
- **gcloud Documentation:** https://cloud.google.com/docs/gcloud

---

## ✨ FULL FLOW SUMMARY

```
1. gcloud config set project penilaian-sentimen
2. gcloud services enable run.googleapis.com artifactregistry.googleapis.com cloudbuild.googleapis.com
3. gcloud auth configure-docker gcr.io
4. cd backend
5. gcloud run deploy penilaian-sentimen-api --source . --platform managed --region asia-southeast1 --allow-unauthenticated
6. [CATAT BACKEND URL]
7. Login Vercel → Import repo → Set VITE_API_URL → Deploy
8. Test aplikasi di browser
9. 🎉 DONE!
```

---

**Save this file untuk easy reference saat deploy! ✅**
