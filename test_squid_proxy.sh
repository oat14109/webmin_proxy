#!/bin/bash

# === Config ===
PROXY_HOST="localhost"
PROXY_PORT="3128"
LOG_PATH="./logs/access.log"
TARGET_HTTP="http://example.com"
TARGET_HTTPS="https://www.google.com"
TARGET_FILE="http://speedtest.tele2.net/10MB.zip"

echo "🌐 [1] Testing HTTP via Squid Proxy..."
curl -x http://$PROXY_HOST:$PROXY_PORT $TARGET_HTTP -L -s -o /dev/null -w "→ HTTP Status: %{http_code}\n"

echo "🔐 [2] Testing HTTPS via Squid Proxy (CONNECT)..."
curl -x http://$PROXY_HOST:$PROXY_PORT $TARGET_HTTPS -L -s -o /dev/null -w "→ HTTPS Status: %{http_code}\n"

echo "📦 [3] Testing Rate Limit via large file download (should be slow)..."
START_TIME=$(date +%s)
curl -x http://$PROXY_HOST:$PROXY_PORT $TARGET_FILE -o /dev/null -s -w "→ Downloaded in %{time_total}s\n"
END_TIME=$(date +%s)
TOTAL_TIME=$((END_TIME - START_TIME))
echo "⏱️ Total Time: $TOTAL_TIME seconds (Rate limit expected ~100KB/s)"

echo "🪵 [4] Showing last 10 lines of Squid log..."
if [[ -f "$LOG_PATH" ]]; then
    tail -n 10 "$LOG_PATH"
else
    echo "🚫 Log file not found at $LOG_PATH"
fi
