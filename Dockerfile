FROM python:3.11-slim

WORKDIR /app

# System dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copy application and bundled checkpoints (ckpt_N10000 and ckpt_N10000_extreme)
COPY . .

ENV HOST=0.0.0.0
ENV PORT=8080
ENV PYTHONUNBUFFERED=1

EXPOSE 8080

HEALTHCHECK --interval=15s --timeout=5s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:${PORT:-8080}/healthz || exit 1

CMD ["sh", "-c", "uvicorn app:app --host 0.0.0.0 --port ${PORT:-8080} --workers 1 --timeout-keep-alive 120"]
