# ============================================================
# AI Background Remover – Docker image
# Builds the FastAPI backend with all AI dependencies.
# ============================================================

# ---- Base image ------------------------------------------------
# Use the official slim Python image to keep the layer small.
# Swap "cpu" tag for "cu121" build args when deploying on GPU.
FROM python:3.11-slim

# ---- System dependencies ---------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
        libgl1 \
        libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# ---- Working directory -----------------------------------------
WORKDIR /app

# ---- Python dependencies ---------------------------------------
# Copy only requirements first to leverage Docker layer caching.
COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt

# ---- Application source ----------------------------------------
COPY backend/           ./backend/
COPY AI-Background-Remover-AI/ ./AI-Background-Remover-AI/

# ---- Runtime directories (uploads & output persist via volume) --
RUN mkdir -p backend/uploads backend/output

# ---- Environment defaults --------------------------------------
# Override these at runtime with -e flags or docker-compose env vars.
ENV MODEL_BACKEND=rembg \
    ONNX_MODEL_PATH=AI-Background-Remover-AI/models/model.onnx \
    TORCH_MODEL_PATH=AI-Background-Remover-AI/models/model.pth \
    MONGO_URI=mongodb://mongo:27017 \
    MONGO_DB_NAME=ai_bg_remover \
    ACCESS_TOKEN_EXPIRE_MINUTES=60 \
    REFRESH_TOKEN_EXPIRE_DAYS=30 \
    COOKIE_SECURE=true \
    COOKIE_SAMESITE=none \
    DAILY_QUOTA_LIMIT=100 \
    FILE_MAX_AGE_HOURS=24 \
    CLEANUP_INTERVAL_MINS=60 \
    PORT=8000

# ---- Expose API port -------------------------------------------
EXPOSE 8000

# ---- Start server ----------------------------------------------
# Run from the repo root so relative imports in ai/ resolve correctly.
CMD ["uvicorn", "backend.app:app", "--host", "0.0.0.0", "--port", "8000"]
