# Raffpoyb Cyber Program — Offensive Security Learning Lab

A personal, **legal** learning environment for studying offensive security
(penetration testing / ethical hacking). The goal here is to build real skills
the right way: against systems you own or are explicitly authorized to test.

> ⚖️ **Golden rule:** Only attack machines you own or have **written
> permission** to test. Scanning, brute-forcing, or exploiting systems you do
> not control is illegal in most of the world (e.g. the US Computer Fraud and
> Abuse Act, the UK Computer Misuse Act) regardless of intent. Everything in
> this repo is built around that rule.

## What's in here

| Path | What it is |
|------|------------|
| [`docs/LAB_SETUP.md`](docs/LAB_SETUP.md) | How to stand up a safe, legal practice lab |
| [`docs/ROADMAP.md`](docs/ROADMAP.md) | A step-by-step learning path from beginner onward |
| [`docs/TOOLS.md`](docs/TOOLS.md) | Core tools and how to use them legally |
| [`scripts/setup_pentestgpt.sh`](scripts/setup_pentestgpt.sh) | Installs PentestGPT (an AI pentest study assistant) reproducibly |
| [`scripts/lab_check.py`](scripts/lab_check.py) | Prints the banner and a quick environment check |

## Legal practice targets (attack these, nothing else)

You never need a real-world victim to learn. These are built to be hacked:

- **Local, on your own machine:** [DVWA](https://github.com/digininja/DVWA),
  [OWASP Juice Shop](https://owasp.org/www-project-juice-shop/),
  [Metasploitable](https://sourceforge.net/projects/metasploitable/),
  [VulnHub](https://www.vulnhub.com/) images.
- **Hosted labs (their infra, their permission):**
  [TryHackMe](https://tryhackme.com/), [Hack The Box](https://www.hackthebox.com/),
  [PortSwigger Web Security Academy](https://portswigger.net/web-security) (free),
  [PicoCTF](https://picoctf.org/).

## Quick start

```bash
# 1. Verify your environment
python3 scripts/lab_check.py

# 2. (Optional) Install PentestGPT as a study assistant
bash scripts/setup_pentestgpt.sh

# 3. Read the lab guide and roadmap, then spin up a legal target
#    (e.g. OWASP Juice Shop) and start learning.
```

## Ethics

This repository is for education and **authorized** testing only. Use it to
learn how attacks work so you can perform sanctioned penetration tests, compete
in CTFs, and build better defenses. Do not use these skills or tools against
people or systems without explicit permission.
