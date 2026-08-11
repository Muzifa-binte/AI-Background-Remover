# AI Background Remover

> **Commander:** QuantumLogics Labs  
> **Organization:** [github.com/QuantumLogicsLabs](https://github.com/QuantumLogicsLabs)  
> **Status:** Active development — Commander is building solo until teams are filled.

---

## What This Project Is

A full-stack AI web application that removes image backgrounds automatically.  
A user uploads a photo, the AI isolates the subject, and the app returns a transparent PNG — no manual masking needed.

**Who it is for:** photographers, designers, e-commerce sellers, content creators.

---

## Repository Structure

This is the **parent repository**. It does not contain application code itself — it ties together three independent submodule repositories and holds shared configuration.

```
AI-Background-Remover/          ← you are here (parent repo)
│
├── frontend/                   ← submodule → AI-Background-Remover-frontend
│   React + TypeScript + Tailwind + Vite
│   Owned by: Web Team (UI)
│
├── backend/                    ← submodule → AI-Background-Remover-backend
│   Python + FastAPI + MongoDB
│   Owned by: Web Team (API)
│
├── AI-Background-Remover-AI/   ← submodule → AI-Background-Remover-AI
│   PyTorch + ONNX + OpenCV + rembg
│   Owned by: AI Team + ML Team
│
├── .gitmodules                 ← submodule URL declarations
├── .gitattributes              ← line-ending rules (LF everywhere)
├── requirements.txt            ← Python deps for backend + AI combined
├── Dockerfile                  ← containerises backend + AI together
├── .env.example                ← all environment variables documented
├── CONTRIBUTING.md             ← git workflow, branch rules, PR process
└── TEAM_WORKLOAD.md            ← who owns what, current build status
```

---

## Three Teams, One Product

| Team | Repo | What They Build |
|------|------|-----------------|
| **Web Team** | `frontend` | React UI — upload, preview, compare, download, history |
| **Web Team** | `backend` | FastAPI — REST endpoints, file storage, MongoDB integration |
| **AI Team** | `AI-Background-Remover-AI` | Inference pipeline — preprocessing, model run, postprocessing |
| **ML Team** | `AI-Background-Remover-AI` | Model research — evaluate U²-Net, BiRefNet, RMBG-2.0, train/export |

> **AI Team vs ML Team distinction:**  
> - AI Team wires models into the pipeline (code, integration, optimization).  
> - ML Team researches, trains, evaluates, and exports the actual model weights.  
> Both work inside the same `AI-Background-Remover-AI` submodule but in separate folders — `pipeline/` vs `research/`.

---

## How Submodules Work

Each submodule is a fully independent Git repository with its own history, branches, and pull requests. The parent repo just records *which commit* of each submodule to point to.

**Cloning the full project (all submodules):**
```bash
git clone --recurse-submodules https://github.com/QuantumLogicsLabs/AI-Background-Remover.git
```

**If you already cloned without submodules:**
```bash
git submodule update --init --recursive
```

**After a teammate pushes to a submodule and you want the parent to track the new commit:**
```bash
# Inside the submodule folder
git pull origin main

# Back in the parent repo
cd ..
git add frontend          # or backend / AI-Background-Remover-AI
git commit -m "chore: update frontend submodule pointer"
git push
```

> Team members work directly inside the submodule repos. They never touch the parent repo unless they are updating a submodule pointer.

---

## Full Tech Stack

| Layer | Technology |
|-------|-----------|
| UI Framework | React 18 + TypeScript |
| Styling | Tailwind CSS 3 + CSS custom properties |
| Build Tool | Vite 5 |
| HTTP Client | Axios |
| File Upload | react-dropzone |
| Routing | react-router-dom v6 |
| API Framework | FastAPI 0.115 |
| ASGI Server | Uvicorn |
| Database | MongoDB (async via Motor) |
| AI Runtime | PyTorch + ONNX Runtime |
| Image Processing | OpenCV + Pillow + NumPy |
| Segmentation Models | U²-Net / BiRefNet / RMBG-2.0 |
| Quick Prototype | rembg (U²-Net wrapper) |
| Deployment | Vercel (frontend) + Docker (backend+AI) |

---

## Local Setup (Full Stack)

### Prerequisites
- Python 3.11+
- Node.js 20+
- MongoDB running locally on port 27017

### Step 1 — Clone with submodules
```bash
git clone --recurse-submodules https://github.com/QuantumLogicsLabs/AI-Background-Remover.git
cd AI-Background-Remover
```

### Step 2 — Backend + AI environment
```bash
# Create and activate a virtual environment
python -m venv .venv
.venv\Scripts\activate          # Windows
# source .venv/bin/activate     # Mac/Linux

pip install -r requirements.txt

# Copy environment files for each submodule
cp backend/.env.example backend/.env
cp AI-Background-Remover-AI/.env.example AI-Background-Remover-AI/.env

# backend/.env  → set MONGO_URI if MongoDB is not on localhost
# AI/.env       → MODEL_BACKEND=rembg is the default (no model file needed)
```

### Step 3 — Run the backend
```bash
cd backend
uvicorn app:app --reload --port 8000
```

API docs available at: `http://localhost:8000/docs`

### Step 4 — Frontend
```bash
cd frontend
npm install
npm run dev
```

App available at: `http://localhost:5173`

---

## API Endpoints (Summary)

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/api/remove-background` | Upload image, get transparent PNG |
| `GET` | `/api/download/{filename}` | Download a processed image |
| `GET` | `/api/history` | Get processing history (last 50) |
| `DELETE` | `/api/image/{id}` | Delete image from storage + history |
| `GET` | `/` | Health check |

Full interactive docs at `http://localhost:8000/docs` when the backend is running.

---

## AI Pipeline (Summary)

```
User uploads image
        │
        ▼
  [Backend] Validate + save to uploads/
        │
        ▼
  [AI] Preprocess — resize to 1024×1024, ImageNet normalize
        │
        ▼
  [AI] Inference — run segmentation model (ONNX / PyTorch / rembg)
        │
        ▼
  [AI] Postprocess — upsample mask, binarise, refine edges
        │
        ▼
  [AI] Apply alpha channel → transparent PNG saved to output/
        │
        ▼
  [Backend] Return download URL to frontend
        │
        ▼
  [Frontend] Show result, comparison slider, download button
```

---

## Environment Variables

All variables are documented in `.env.example` at the root.  
Copy it to `.env` before running the backend.

---

## Deployment

| Service | What it hosts |
|---------|--------------|
| Vercel | `frontend/` — auto-deploy on push to `main` |
| Docker | `backend/` + `AI-Background-Remover-AI/` together |

```bash
# Build and run with Docker
docker build -t ai-bg-remover .
docker run -p 8000:8000 --env-file .env ai-bg-remover
```

---

## Project Roadmap

- [x] AI inference pipeline (ONNX / PyTorch / rembg backends)
- [x] FastAPI backend with all routes
- [x] MongoDB history storage
- [x] React frontend — upload, result, compare, download
- [x] History page
- [x] Dark mode
- [ ] User authentication (JWT)
- [ ] Background color / image replacement
- [ ] Batch processing
- [ ] Video background removal
- [ ] Mobile app

---

## Links

| Resource | URL |
|----------|-----|
| Parent repo | github.com/QuantumLogicsLabs/AI-Background-Remover |
| Frontend repo | github.com/QuantumLogicsLabs/AI-Background-Remover-frontend |
| Backend repo | github.com/QuantumLogicsLabs/AI-Background-Remover-backend |
| AI repo | github.com/QuantumLogicsLabs/AI-Background-Remover-AI |
| Contribution guide | [CONTRIBUTING.md](./CONTRIBUTING.md) |
| Team workload | [TEAM_WORKLOAD.md](./TEAM_WORKLOAD.md) |
