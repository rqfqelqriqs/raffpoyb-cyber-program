#!/usr/bin/env bash
#
# stop-lab.sh — stop the practice targets. Double-click me from inside Kali.
# Your progress in the apps is discarded (that's usually what you want for
# a clean next session). Images stay cached so the next start is fast.

set -u
cd "$(dirname "$0")" || exit 1

printf '\n\033[36m==> Stopping practice targets...\033[0m\n'

if docker compose version >/dev/null 2>&1; then
    sudo docker compose down
elif command -v docker-compose >/dev/null 2>&1; then
    sudo docker-compose down
else
    sudo docker rm -f lab_juice_shop lab_dvwa 2>/dev/null || true
fi

printf '\033[32mStopped. Double-click start-lab.sh whenever you want them back.\033[0m\n'
read -rp "Press Enter to close this window..."
