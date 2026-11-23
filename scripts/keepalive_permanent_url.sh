#!/usr/bin/env bash
set -euo pipefail

WEB_DIR="/Users/smyan/Desktop/Research/Research_Projects/University_of_Cape_Town/UCT-RDP/recomb-model/gt-transformer/web"
LOG_DIR="/Users/smyan/Library/Logs/GTTransformer"
mkdir -p "$LOG_DIR"

SERVER_LOG="$LOG_DIR/uvicorn.log"
TUNNEL_LOG="$LOG_DIR/cloudflared.log"

cd "$WEB_DIR"

# 1. Ensure FastAPI uvicorn server on port 8080 is running
if ! curl -fsS http://127.0.0.1:8080/healthz >/dev/null 2>&1; then
  pkill -f "uvicorn app:app --host 127.0.0.1 --port 8080" >/dev/null 2>&1 || true
  nohup "$WEB_DIR/../.venv/bin/python" -m uvicorn app:app --host 127.0.0.1 --port 8080 --workers 1 --timeout-keep-alive 120 >>"$SERVER_LOG" 2>&1 &
  for _ in {1..20}; do
    if curl -fsS http://127.0.0.1:8080/healthz >/dev/null 2>&1; then
      break
    fi
    sleep 1
  done
fi

# 2. Ensure cloudflared tunnel is running and extract its URL
CURRENT_URL=""
if pgrep -f "cloudflared tunnel --url http://127.0.0.1:8080" >/dev/null 2>&1; then
  if [ -f "$TUNNEL_LOG" ]; then
    CURRENT_URL=$(grep -Eo "https://[a-z0-9-]+\.trycloudflare\.com" "$TUNNEL_LOG" | tail -n 1 || true)
  fi
  if [ -z "$CURRENT_URL" ] && [ -f "$WEB_DIR/index.html" ]; then
    CURRENT_URL=$(grep -Eo "https://[a-z0-9-]+\.trycloudflare\.com" "$WEB_DIR/index.html" | head -n 1 || true)
  fi
fi

# Test if CURRENT_URL is reachable
NEED_NEW_TUNNEL=0
if [ -z "$CURRENT_URL" ]; then
  NEED_NEW_TUNNEL=1
else
  HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$CURRENT_URL/healthz" || echo "000")
  if [ "$HTTP_CODE" != "200" ]; then
    NEED_NEW_TUNNEL=1
  fi
fi

if [ "$NEED_NEW_TUNNEL" -eq 1 ]; then
  pkill -f "cloudflared tunnel --url http://127.0.0.1:8080" >/dev/null 2>&1 || true
  : > "$TUNNEL_LOG"
  nohup /opt/homebrew/bin/cloudflared tunnel --url http://127.0.0.1:8080 >>"$TUNNEL_LOG" 2>&1 &
  for _ in {1..20}; do
    CURRENT_URL=$(grep -Eo "https://[a-z0-9-]+\.trycloudflare\.com" "$TUNNEL_LOG" | tail -n 1 || true)
    if [ -n "$CURRENT_URL" ]; then
      break
    fi
    sleep 1
  done
fi

# 3. Sync permanent GitHub Pages redirect index.html if the tunnel URL changed
if [ -n "$CURRENT_URL" ]; then
  OLD_URL=$(grep -Eo "https://[a-z0-9-]+\.trycloudflare\.com" "$WEB_DIR/index.html" | head -n 1 || true)
  if [ "$CURRENT_URL" != "$OLD_URL" ]; then
    sed -i '' "s|https://[a-z0-9-]*\.trycloudflare\.com|$CURRENT_URL|g" "$WEB_DIR/index.html"
    git add index.html
    git commit -m "Auto-update live workbench gateway target to $CURRENT_URL" >/dev/null 2>&1 || true
    git push origin main >/dev/null 2>&1 || true
  fi
fi
