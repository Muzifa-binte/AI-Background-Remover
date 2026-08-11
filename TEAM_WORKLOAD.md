# Team Workload & Build Status

> **Commander:** QuantumLogics Labs
> **Last updated:** 2026-08-03
> **Current phase:** Solo build (Commander) — teams filling in progressively

---

## Team Roster

| Team | Members | Focus Area | Repo |
|------|---------|-----------|------|
| **Web Team** | TBD | React UI + FastAPI backend | `frontend` + `backend` |
| **AI Team** | TBD | Inference pipeline integration | `AI-Background-Remover-AI` |
| **ML Team** | TBD | Model research, training, benchmarking | `AI-Background-Remover-AI/research/` |

---

## Overall Progress

```
Frontend   ████████████░░░░  75% — core flow done, auth + extras pending
Backend    █████████████░░░  80% — all routes done, auth + queue pending
AI Module  ████████████░░░░  75% — 3 backends working, BiRefNet/RMBG pending
ML         ░░░░░░░░░░░░░░░░   0% — research folder not started yet
```

---

## File-by-File Ownership & Status

### Frontend (`AI-Background-Remover-frontend`)

| File / Folder | Owner | Status | Notes |
|---------------|-------|--------|-------|
| `package.json` | Commander | Done | All deps pinned |
| `vite.config.ts` | Commander | Done | /api proxy to :8000 |
| `index.html` | Commander | Done | Google Fonts loaded |
| `tailwind.config.ts` | Commander | Done | Full token mapping |
| `src/theme/tokens.css` | Commander | Done | Light + dark mode tokens |
| `src/main.tsx` | Commander | Done | Entry point |
| `src/App.tsx` | Commander | Done | Router + 2 routes |
| `src/components/Navbar.tsx` | Commander | Done | Routing + theme toggle |
| `src/components/ThemeToggle.tsx` | Commander | Done | Persists to localStorage |
| `src/components/UploadZone.tsx` | Commander | Done | Drag-drop + validation |
| `src/components/ImageCanvas.tsx` | Commander | Done | Result/original/compare slider |
| `src/components/DownloadButton.tsx` | Commander | Done | — |
| `src/components/HistoryCard.tsx` | Commander | Done | — |
| `src/hooks/useUpload.ts` | Commander | Done | State machine + axios |
| `src/hooks/useHistory.ts` | Commander | Done | Fetch + delete |
| `src/pages/HomePage.tsx` | Commander | Done | Full upload→result flow |
| `src/pages/HistoryPage.tsx` | Commander | Done | Grid + all states |
| `src/pages/LoginPage.tsx` | **Web Team** | Not started | Auth UI |
| `src/pages/RegisterPage.tsx` | **Web Team** | Not started | Auth UI |
| `src/components/BackgroundPanel.tsx` | **Web Team** | Not started | Color/image replacement |
| `src/components/BatchUpload.tsx` | **Web Team** | Not started | Multiple files |
| `src/components/Toast.tsx` | **Web Team** | Not started | Notification system |
| `src/hooks/useAuth.ts` | **Web Team** | Not started | JWT login/logout |

---

### Backend (`AI-Background-Remover-backend`)

| File / Folder | Owner | Status | Notes |
|---------------|-------|--------|-------|
| `app.py` | Commander | Done | CORS + lifespan DB hooks + all routers |
| `routes/remove_bg.py` | Commander | Done | Upload, AI call, MongoDB write |
| `routes/download.py` | Commander | Done | Safe file serve |
| `routes/history.py` | Commander | Done | Real MongoDB query |
| `routes/images.py` | Commander | Done | Delete disk + DB |
| `services/bg_removal.py` | Commander | Done | Async thread-pool wrapper |
| `services/database.py` | Commander | Done | Motor connection helpers |
| `routes/auth.py` | **Web Team** | Not started | JWT login, register, refresh |
| `services/auth.py` | **Web Team** | Not started | Token generation, password hash |
| `routes/batch.py` | **Web Team** | Not started | Batch upload endpoint |
| `tests/test_remove_bg.py` | **Web Team** | Not started | pytest + httpx |
| `tests/test_history.py` | **Web Team** | Not started | pytest + httpx |

---

### AI Module (`AI-Background-Remover-AI`)

| File / Folder | Owner | Status | Notes |
|---------------|-------|--------|-------|
| `preprocessing.py` | Commander | Done | Load, resize, normalize, tensorize |
| `postprocessing.py` | Commander | Done | Upsample, binarise, refine, alpha |
| `inference.py` — rembg backend | Commander | Done | Working out of the box |
| `inference.py` — ONNX backend | Commander | Done | Needs `.onnx` weights file |
| `inference.py` — PyTorch backend | Commander | Done | Needs `.pth` weights file |
| `inference.py` — BiRefNet backend | **AI Team** | Not started | Add `_run_birefnet()` function |
| `inference.py` — RMBG-2.0 backend | **AI Team** | Not started | Add `_run_rmbg2()` function |
| Model caching (load once on startup) | **AI Team** | Not started | Avoid reloading per request |
| `models/` | **ML Team** | Pending | Weight files go here (not committed) |
| `research/` | **ML Team** | Not started | Create this folder |
| `research/notebooks/` | **ML Team** | Not started | Experiment notebooks |
| `research/evaluate.py` | **ML Team** | Not started | Benchmark IoU / speed |
| `research/export_onnx.py` | **ML Team** | Not started | Export trained model |
| `research/RESULTS.md` | **ML Team** | Not started | Benchmark results table |

---

## What Needs to Happen Next (Priority Order)

### Immediate (unblock the rest)
| # | Task | Team | Effort |
|---|------|------|--------|
| 1 | Model caching — load model once on startup, not per request | AI Team | Small |
| 2 | Add BiRefNet backend to inference.py | AI Team | Medium |
| 3 | Benchmark rembg baseline (speed + accuracy) | ML Team | Medium |

### Short term
| # | Task | Team | Effort |
|---|------|------|--------|
| 4 | JWT auth — backend routes + frontend pages | Web Team | Large |
| 5 | Toast notification component | Web Team | Small |
| 6 | Loading skeleton components | Web Team | Small |
| 7 | Unit tests for all backend routes | Web Team | Medium |
| 8 | Evaluate BiRefNet vs rembg on P3M dataset | ML Team | Large |

### Medium term
| # | Task | Team | Effort |
|---|------|------|--------|
| 9 | Background replacement panel (color + custom image) | Web Team | Large |
| 10 | Batch upload — frontend + backend | Web Team | Medium |
| 11 | Export best model to ONNX | ML Team | Medium |
| 12 | Background task queue for slow inference | Web Team (API) | Large |

---

## How to Pick Up a Task

1. Check the table above — find a task marked "Not started" in your team's area.
2. Read the README for your repo to understand the codebase.
3. Create a branch following the naming rules in [CONTRIBUTING.md](./CONTRIBUTING.md).
4. Implement the task.
5. Open a PR against your submodule repo's `main`.
6. Update this file — change the status to "In progress" or "Done" and add your name as owner.

---

## Status Key

| Status | Meaning |
|--------|---------|
| Done | Implemented and working |
| In progress | Someone is actively building it |
| Not started | Available to pick up |
| Pending | Blocked on something else |
| Needs review | PR open, awaiting review |
