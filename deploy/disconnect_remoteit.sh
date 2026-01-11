#!/usr/bin/env bash
set -euo pipefail

SSH_SERVICE_ID=90:00:00:00:00:2A:D4:1E
remoteit connection disconnect --id ${SSH_SERVICE_ID}

INTERVAL=5
TIMEOUT=60
ELAPSED=0

while true; do
  if remoteit status -j | jq -e '
    .data.connections[]
    | select(.addressHost=="ssh.at.remote.it"
             and .addressPort==30001
             and .state==2)
  ' > /dev/null; then
    echo "✅ Connection ssh.at.remote.it:30001 is DISCONNECTED (state=2)"
    break
  fi

  if [ "$ELAPSED" -ge "$TIMEOUT" ]; then
    echo "❌ Timeout after ${TIMEOUT}s waiting for disconnection"
    exit 1
  fi

  sleep "$INTERVAL"
  ELAPSED=$((ELAPSED + INTERVAL))
done
sleep 2
remoteit connection remove --id ${SSH_SERVICE_ID}
echo "✅ Connection ssh.at.remote.it:30001 has been removed"