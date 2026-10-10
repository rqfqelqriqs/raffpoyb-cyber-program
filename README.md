# Raffpoyb Cyber Program — Lab Environment

A personal cybersecurity/IT sandbox for coursework: a Kali Linux VM plus safe,
intentionally-vulnerable targets to practice on. Everything is built to run on an
**Apple Silicon Mac (M-series)** and to stay **isolated and legal**.

> **Ethics & scope:** every tool and target here is for learning on machines you
> own or are explicitly authorized to test — your own lab VMs, or authorized
> ranges (TryHackMe, Hack The Box). Never use these against systems or people you
> don't have written permission to test.

## 📂 What's in here

### `kali-lab/` — set up Kali Linux on your Mac
Start here. Gets Kali running in **UTM** on Apple Silicon with internet + DNS
working.
- **`README.md`** — the main step-by-step guide (Apple Silicon / M4).
- `verify-network.sh` — run inside Kali to prove internet + DNS work.
- `toggle-network.sh` — switch Kali between internet-on and fully isolated.
- `intel-virtualbox.md` — the VirtualBox version, for Intel Macs only.

### `cyber-lab-targets/` — things to practice on (double-click and go)
Once Kali is up, this gives you vulnerable apps to attack.
- **`start-lab.sh`** — double-click inside Kali to launch OWASP Juice Shop
  (`:3000`) and DVWA (`:8080`). Handles Docker setup for you.
- `stop-lab.sh` — shut them down.
- `README.md` — simple how-to.

## 🚀 Quick start

1. **`kali-lab/README.md`** → install UTM, download Kali (ARM64), boot it.
2. Inside Kali, run **`kali-lab/verify-network.sh`** → confirm DNS/internet.
3. Copy **`cyber-lab-targets/`** into Kali, double-click **`start-lab.sh`**.
4. Open <http://localhost:3000> and <http://localhost:8080> in Kali — start learning.
