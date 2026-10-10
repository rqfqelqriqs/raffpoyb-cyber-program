#!/usr/bin/env bash
#
# start-lab.sh — start the practice targets inside Kali. Double-click me
# (or run ./start-lab.sh) from inside the Kali VM.
#
# Safe to run repeatedly. First run downloads the images (a few minutes);
# after that it's instant.

set -u
cd "$(dirname "$0")" || exit 1

line() { printf '\n\033[36m==> %s\033[0m\n' "$1"; }
ok()   { printf '\033[32m%s\033[0m\n' "$1"; }
warn() { printf '\033[33m%s\033[0m\n' "$1"; }
err()  { printf '\033[31m%s\033[0m\n' "$1"; }

line "Cyber Lab — starting practice targets"

# 1. Make sure Docker is installed.
if ! command -v docker >/dev/null 2>&1; then
    warn "Docker isn't installed yet. Installing it (needs your sudo password)..."
    sudo apt update && sudo apt -y install docker.io docker-compose-v2 || {
        err "Could not install Docker automatically."
        err "Run this once, then double-click me again:"
        err "   sudo apt update && sudo apt -y install docker.io docker-compose-v2"
        read -rp "Press Enter to close..."
        exit 1
    }
fi

# 2. Make sure the Docker service is running.
if ! sudo docker info >/dev/null 2>&1; then
    line "Starting the Docker service"
    sudo systemctl enable --now docker 2>/dev/null || sudo service docker start 2>/dev/null || true
fi

# 3. Pick the compose command (plugin 'docker compose' or legacy 'docker-compose').
if docker compose version >/dev/null 2>&1; then
    COMPOSE="sudo docker compose"
elif command -v docker-compose >/dev/null 2>&1; then
    COMPOSE="sudo docker-compose"
else
    warn "Compose plugin missing; installing docker-compose-v2..."
    sudo apt -y install docker-compose-v2 >/dev/null 2>&1 || true
    COMPOSE="sudo docker compose"
fi

# 4. Bring the targets up.
line "Downloading (first time only) and starting the targets"
if ! $COMPOSE up -d; then
    err "Startup failed. Check your internet connection (DNS must work) and try again."
    read -rp "Press Enter to close..."
    exit 1
fi

# 5. Wait briefly and show status + URLs.
sleep 4
line "Running containers"
sudo docker ps --filter "name=lab_" --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'

cat <<'EOF'

----------------------------------------------------------------
  YOUR PRACTICE TARGETS ARE UP. Open these in Kali's browser:

    OWASP Juice Shop   ->  http://localhost:3000
    DVWA               ->  http://localhost:8080
         DVWA login:  admin / password
         (after logging in, click "Create / Reset Database" once)

  These are SAFE, intentionally-vulnerable apps meant for you to
  attack as practice. They only listen on this VM (127.0.0.1).

  To stop them later: double-click  stop-lab.sh
----------------------------------------------------------------
EOF

ok "Done."
# Keep the window open when launched by double-click.
read -rp "Press Enter to close this window..."
