# 📊 Sentimen Ijazah - Analisis Sentimen Media Sosial

[![Backend Status](https://img.shields.io/badge/Backend-Cloud%20Run%20✓-green)](https://penilaian-sentimen-api-255173089522.asia-southeast1.run.app)
[![Frontend Status](https://img.shields.io/badge/Frontend-Vercel%20✓-blue)](https://sentimen-ijazah-nimexxs.vercel.app)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)]()

Sistem analisis sentimen berbasis Machine Learning untuk menganalisis komentar YouTube tentang isu ijazah Presiden Jokowi. Menggunakan algoritma **SVM-RBF** dengan pre-processing teks bahasa Indonesia menggunakan **PySastrawi**.

---

## 📋 Daftar Isi

- [Fitur](#fitur)
- [Tech Stack](#tech-stack)
- [Instalasi](#instalasi)
- [Penggunaan](#penggunaan)
- [API Documentation](#api-documentation)
- [Deployment](#deployment)
- [Struktur Project](#struktur-project)
- [Metodologi](#metodologi)
- [Penelitian Terkait](#penelitian-terkait)
- [Kontributor](#kontributor)

---

## ✨ Fitur

### 🎯 Core Features
- **Prediksi Sentimen Real-time** - Analisis sentimen teks baru secara instant
- **Dashboard Statistik** - Visualisasi distribusi sentimen dari 2,561 data labeled
- **Per-Video Analytics** - Breakdown sentimen untuk setiap video YouTube
- **Model Evaluation** - Confusion matrix, accuracy, precision, recall, F1-score
- **Annotator Agreement** - Calculation PA & Cohen/Fleiss Kappa

### 📊 Analytics
- Distribusi sentimen: Negatif (66.81%), Positif (22.49%), Netral (10.70%)
- 11 video viral dari berbagai channel (Metro TV, iNews, tvOneNews, dll)
- Analisis per-channel dan per-tipe (Pro, Netral, Kontra)
- Comparison dengan 4 varian model (SVM-RBF, LinearSVC, dengan/tanpa SMOTE)

### 🎨 UI/UX
- Responsive design (mobile, tablet, desktop)
- Interactive charts dengan Recharts
- Multi-halaman (Dashboard, Predict, Stats, Methodology, About)
- Dark/Light theme support

---

## 🛠️ Tech Stack

### **Backend**
```
FastAPI 0.111.0        - Web framework
Uvicorn 0.29.0         - ASGI server
scikit-learn 1.5.0     - Machine Learning
numpy 1.26.4           - Numerical computing
joblib 1.4.2           - Model serialization
PySastrawi 1.2.0       - Stemming bahasa Indonesia
Pydantic 2.7.1         - Data validation
```

### **Frontend**
```
React 18.2.0           - UI library
React Router 6.22.0    - Routing
Vite 5.2.0             - Build tool
Recharts 2.12.0        - Data visualization
Axios 1.6.0            - HTTP client
```

### **Deployment**
```
Google Cloud Run       - Backend hosting (Python 3.11)
Vercel                 - Frontend hosting (Vite)
GitHub                 - Version control
Docker                 - Containerization
```

### **ML Model**
```
Algorithm              - SVM with RBF Kernel
Training Data          - 2,048 samples (80%)
Testing Data           - 513 samples (20%)
Best Parameters        - C=10, gamma=0.1
Accuracy               - 75.24%
F1-Score               - 73.46%
```

---

## 📦 Instalasi

### **Prerequisites**
- Python 3.11+
- Node.js 18+
- npm atau yarn
- Git

### **Backend Setup (Local)**

#### Windows:
```powershell
cd backend
python -m venv venv
.\venv\Scripts\Activate.ps1
pip install -r requirements.txt
uvicorn main:app --reload --port 8000
```

#### Linux/Mac:
```bash
cd backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
uvicorn main:app --reload --port 8000
```

**Atau gunakan quick-start script:**
```bash
# Windows
./backend/run_local.bat

# Linux/Mac
bash backend/run_local.sh
```

**Backend akan berjalan di:** `http://localhost:8000`

### **Frontend Setup (Local)**

```bash
cd frontend
npm install
echo "VITE_API_URL=http://localhost:8000" > .env
npm run dev
```

**Frontend akan berjalan di:** `http://localhost:5173`

---

## 🚀 Penggunaan

### **Via API (Backend)**

#### Health Check
```bash
curl http://localhost:8000/health
```

Response:
```json
{
  "status": "ok",
  "model": "SVM-RBF Baseline"
}
```

#### Prediksi Sentimen
```bash
curl -X POST http://localhost:8000/predict \
  -H "Content-Type: application/json" \
  -d '{"text":"ijazah jokowi ini sangat bagus"}'
```

Response:
```json
{
  "text_asli": "ijazah jokowi ini sangat bagus",
  "text_proses": "ijazah jokowi bagus",
  "label": "Positif",
  "confidence": {
    "Negatif": 15.23,
    "Netral": 8.45,
    "Positif": 76.32
  }
}
```

#### Dapatkan Statistik
```bash
curl http://localhost:8000/stats
curl http://localhost:8000/stats/video
curl http://localhost:8000/stats/agreement
curl http://localhost:8000/model
curl http://localhost:8000/model/confusion
```

### **Via Web Dashboard**

1. **Buka aplikasi** → `https://sentimen-ijazah-xxx.vercel.app`
2. **Navigasi:**
   - **Dashboard** - Statistik keseluruhan
   - **Predict** - Prediksi sentimen teks baru
   - **Evaluasi** - Performa model dan confusion matrix
   - **Metodologi** - Penjelasan workflow research
   - **Terdahulu** - Perbandingan dengan penelitian lain
   - **Video Sentimen** - Analisis per-video YouTube

---

## 🔌 API Documentation

### **Endpoints**

| Method | Endpoint | Deskripsi | Response |
|--------|----------|-----------|----------|
| GET | `/` | Welcome message | JSON |
| GET | `/health` | Health check | `{status, model}` |
| POST | `/predict` | Prediksi sentimen | `{text_asli, text_proses, label, confidence}` |
| GET | `/stats` | Statistik lengkap | Dataset stats |
| GET | `/stats/video` | Per-video breakdown | Array videos |
| GET | `/stats/agreement` | Annotator agreement | PA & Kappa scores |
| GET | `/model` | Model info | Model metadata |
| GET | `/model/comparison` | 4 model variants | Models comparison |
| GET | `/model/confusion` | Confusion matrix | Matrix & percentages |
| GET | `/model/terdahulu` | Penelitian terkait | Related research |

### **Request/Response Examples**

**Predict Request:**
```json
{
  "text": "ijazah jokowi ini asli atau palsu sih?"
}
```

**Predict Response:**
```json
{
  "text_asli": "ijazah jokowi ini asli atau palsu sih?",
  "text_proses": "ijazah jokowi asli palsu",
  "label": "Negatif",
  "confidence": {
    "Negatif": 68.5,
    "Netral": 20.3,
    "Positif": 11.2
  }
}
```

### **Error Handling**

- **400 Bad Request** - Text kosong atau tidak valid
- **422 Unprocessable Entity** - Text tidak bisa di-process
- **500 Internal Server Error** - Server error

---

## 🚢 Deployment

### **Backend - Google Cloud Run**

#### One-Click Deploy:
```powershell
cd backend
gcloud run deploy penilaian-sentimen-api `
  --source . `
  --platform managed `
  --region asia-southeast1 `
  --allow-unauthenticated `
  --memory 512Mi
```

**Live URL:** `https://penilaian-sentimen-api-255173089522.asia-southeast1.run.app`

#### Features:
- ✅ Auto-scaling based on traffic
- ✅ $5 free trial credit (sufficient for hobby projects)
- ✅ Global CDN
- ✅ Pay-per-use pricing (no upfront cost)

### **Frontend - Vercel**

#### Setup:
1. Push code ke GitHub
2. Import di Vercel: `https://vercel.com/new`
3. Set Root Directory: `frontend`
4. Add Environment Variable:
   - `VITE_API_URL` = `https://penilaian-sentimen-api-255173089522.asia-southeast1.run.app`
5. Deploy

**Live URL:** `https://sentimen-ijazah-xxx.vercel.app`

#### Features:
- ✅ Auto-deploy on git push
- ✅ Preview deployments
- ✅ Free tier included
- ✅ Global edge network

### **Environment Setup**

**Production Environment Variables:**

*Backend (Cloud Run):*
```
PORT=8080 (auto-set by Cloud Run)
ENV=production
```

*Frontend (Vercel):*
```
VITE_API_URL=https://penilaian-sentimen-api-255173089522.asia-southeast1.run.app
```

---

## 📁 Struktur Project

```
sentimen-ijazah/
├── README.md                          ← Project overview
├── DEPLOY.md                          ← Deployment guide
├── DEPLOYMENT_CHECKLIST.md            ← Step-by-step checklist
├── QUICK_REFERENCE.md                 ← Quick commands
├── REVISION_SUMMARY.md                ← Changes made
│
├── backend/                           ← FastAPI Backend
│   ├── main.py                        ← Main API app
│   ├── requirements.txt               ← Dependencies
│   ├── Dockerfile                     ← Container config
│   ├── .dockerignore
│   ├── vercel.yaml                    ← Render config (alternative)
│   ├── README.md                      ← Backend docs
│   ├── run_local.bat / run_local.sh   ← Quick start scripts
│   ├── models/                        ← Trained ML models
│   │   ├── model_terbaik_final.pkl    ← SVM model
│   │   └── tfidf_vectorizer_final.pkl ← TF-IDF vectorizer
│   ├── data/                          ← Training datasets
│   │   └── dataset_berlabel.csv       ← Labeled comments
│   └── __pycache__/
│
├── frontend/                          ← React Frontend
│   ├── package.json                   ← Dependencies
│   ├── vite.config.js                 ← Vite config
│   ├── vercel.json                    ← Vercel config
│   ├── index.html                     ← Entry HTML
│   ├── src/
│   │   ├── main.jsx                   ← React entry
│   │   ├── App.jsx                    ← Main component
│   │   ├── index.css                  ← Global styles
│   │   ├── api.js                     ← API calls
│   │   ├── components/                ← Reusable components
│   │   └── pages/                     ← Page components
│   │       ├── Dashboard.jsx          ← Main stats
│   │       ├── Predict.jsx            ← Prediction page
│   │       ├── Evaluasi.jsx           ← Model evaluation
│   │       ├── Metodologi.jsx         ← Research methodology
│   │       ├── Terdahulu.jsx          ← Related research
│   │       ├── VideoSentimen.jsx      ← Per-video stats
│   │       └── Tentang.jsx            ← About author
│   ├── public/                        ← Static assets
│   │   └── reno.jpg                   ← Author photo
│   └── node_modules/
│
└── .git/                              ← Git repository
```

---

## 📊 Metodologi Research

### **1. Data Collection (Scraping)**
- **Source:** YouTube API v3
- **Videos:** 11 viral videos (376-376 comments each)
- **Channels:** Metro TV, iNews, Kompas TV, tvOneNews, Tribun Jatim, ILC, Forum Keadilan, KOMPAS TV
- **Total:** 2,783 raw comments (Maret-April 2025)

### **2. Preprocessing**
- Case Folding → Stemming (PySastrawi) → Tokenization
- Stopword Removal → TF-IDF Vectorization (max 8K features)
- Result: 2,561 clean, labeled comments

### **3. Labeling (InSet Lexicon)**
- Automated: InSet Indonesian Sentiment Lexicon
- Manual Validation: 3 expert annotators
- **Agreement:** PA=92%, Fleiss' Kappa=0.8635 (Almost Perfect)
- **Distribution:** Negatif 1,711 | Positif 576 | Netral 274

### **4. Model Training**
- **Algorithm:** SVM with RBF Kernel
- **Train/Test:** 80/20 split (stratified, random_state=42)
- **Hyperparameter Tuning:** GridSearchCV 5-fold CV
- **Best Params:** C=10, gamma=0.1, kernel=rbf
- **Class Weight:** Balanced (for imbalanced data)

### **5. Evaluation**
- **Accuracy:** 75.24%
- **Precision:** 72.58%
- **Recall:** 75.24%
- **F1-Score:** 73.46%
- **CV F1-Score:** 68.21%

---

## 📚 Penelitian Terkait

| Peneliti | Metode | Akurasi | F1-Score | Tahun |
|----------|--------|---------|----------|------|
| **M. Reno Hidayat** ⭐ | SVM-RBF Baseline | 75.24% | 73.46% | 2025-2026 |
| Rahmadhani et al. | SVM + TF-IDF | 81.60% | 80.90% | 2025 |
| Putro & Hendrawan | SVM + TF-IDF | 83.00% | 82.00% | 2025 |
| Santoso et al. | SVM | 85.00% | 84.00% | 2024 |
| Saputra & Isnain | CNN | 91.00% | 90.00% | 2024 |

---

## 👨‍💻 Kontributor

### **Peneliti Utama**
- **M. Reno Hidayat**
  - ID: 220660121005
  - University: Universitas Sebelas April Sumedang
  - Email: hidayatreno085@gmail.com
  - GitHub: [@Renohidayat](https://github.com/Renohidayat)

### **Anotator Pakar**
- Annotator 1, 2, 3 (Universitas Sebelas April Sumedang)

---

## 📄 License

MIT License - Bebas digunakan untuk keperluan akademis dan komersial

---

## 🔗 Links

- **Live Application:** https://sentimen-ijazah.vercel.app
- **API Backend:** https://penilaian-sentimen-api-255173089522.asia-southeast1.run.app
- **GitHub Repository:** https://github.com/Renohidayat/sentimen-ijazah
- **Deployment Guide:** [DEPLOY.md](./DEPLOY.md)
- **Quick Reference:** [QUICK_REFERENCE.md](./QUICK_REFERENCE.md)

---

## 📞 Support & Issues

Jika ada pertanyaan atau bug:
1. **Check:** Existing issues di GitHub
2. **Create:** New issue dengan detail deskripsi
3. **Contact:** hidayatreno085@gmail.com

---

## 🎯 Roadmap

### ✅ Completed
- [x] Data collection & preprocessing
- [x] Model training & evaluation
- [x] API development (FastAPI)
- [x] Frontend dashboard (React)
- [x] Deployment (Cloud Run + Vercel)

### 🔄 In Progress
- [ ] Add more video data
- [ ] Implement deep learning models (LSTM, BERT)
- [ ] Multi-language support

### 📋 Planned
- [ ] Mobile app (React Native)
- [ ] Real-time streaming analysis
- [ ] User authentication & custom models
- [ ] Export/download reports

---

## 🙏 Acknowledgments

- **YouTube API** - Data source
- **scikit-learn** - ML framework
- **FastAPI** - Web framework
- **React** - Frontend library
- **Cloud Run & Vercel** - Hosting platforms

---

**Happy Analyzing! 🎉**

*Last Updated: June 9, 2026*
