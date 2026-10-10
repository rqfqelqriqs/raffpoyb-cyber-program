# Cyber Lab Targets — double-click and go 🎯

Ready-to-attack practice apps that run **inside your Kali VM**. Nothing to
configure — download, double-click, start hacking (legally, on these apps that
exist to be hacked).

| Target | Opens at | What it's for |
|--------|----------|---------------|
| **OWASP Juice Shop** | <http://localhost:3000> | Modern web app; the OWASP Top 10, challenges, XSS, injection |
| **DVWA** | <http://localhost:8080> | Classic drills: SQLi, brute force, file upload, CSRF (login `admin` / `password`) |

Both only listen on `127.0.0.1` inside the VM, so they can't leak onto a real
network. They are **meant to be vulnerable** — that's the point of the exercise.

---

## One-time setup (30 seconds)

1. Copy this whole `cyber-lab-targets` folder into your Kali **Home** folder, so
   it lives at `~/cyber-lab-targets`.
   *(Easiest ways to get it there: clone the repo in Kali, or drag the folder in
   via a UTM shared folder, or just download the repo zip inside Kali.)*
2. Make the scripts runnable (one time). Open a terminal in the folder and run:
   ```bash
   chmod +x start-lab.sh stop-lab.sh
   ```

That's it.

---

## Every time you want to practice

**Just double-click `start-lab.sh`.**

- In Kali's file manager, double-click it → choose **Execute** / **Run in
  Terminal** if asked.
- Or double-click the **`Start Cyber Lab`** desktop launcher (copy it to your
  Desktop first; it expects the folder at `~/cyber-lab-targets`).
- Or from a terminal: `./start-lab.sh`

The first run downloads the apps (a few minutes — your internet/DNS needs to be
working; that's what `kali-lab/verify-network.sh` confirms). After that it's
instant. When it's done it prints the two URLs — open them in Kali's browser.

**To stop:** double-click **`stop-lab.sh`**.

---

## What the scripts handle for you

`start-lab.sh` automatically:
- installs Docker if it isn't there yet (asks for your sudo password),
- starts the Docker service,
- downloads and launches both targets,
- prints the URLs and login.

You don't touch any Docker commands yourself.

---

## First steps in each app

- **Juice Shop:** open <http://localhost:3000> and look for the "Score Board"
  challenge — it guides you through everything else.
- **DVWA:** open <http://localhost:8080>, log in `admin` / `password`, click
  **Create / Reset Database**, then set **DVWA Security** to *Low* to start and
  raise it as you improve.

---

## Stay legal

These apps are safe because they're yours and isolated. Practice your Kali tools
(`nmap`, `sqlmap`, `hydra`, Burp, etc.) **against these targets only**, or
against authorized ranges like TryHackMe / Hack The Box. Never point them at
websites or systems you don't own or have written permission to test.

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| "Cannot connect to the Docker daemon" | Run `sudo systemctl enable --now docker`, then start again. |
| Download fails / hangs | Internet or DNS isn't working. Run `../kali-lab/verify-network.sh`. |
| Port already in use | Something else uses 3000/8080. Run `stop-lab.sh`, then start again. |
| DVWA image won't pull | Edit `docker-compose.yml` and change the dvwa image to `vulnerables/web-dvwa:latest`, then start again. |
| Double-click opens it in a text editor | Right-click → **Open With → Run in Terminal**, or run `./start-lab.sh` from a terminal. |
