# Offensive Security Learning Roadmap

A practical path from "curious" to "can do an authorized pentest." Go in order;
each stage builds on the last. Everything is practiced against the **legal
targets** in [`LAB_SETUP.md`](LAB_SETUP.md).

## Stage 0 — Foundations (don't skip)
- **Networking:** TCP/IP, ports, DNS, HTTP(S), NAT. (Professor Messer's Network+ is free.)
- **Linux:** shell navigation, permissions, processes, package managers.
- **A scripting language:** Python or Bash — enough to automate and read exploits.
- **How the web works:** requests/responses, cookies, sessions, same-origin.

## Stage 1 — The methodology
Learn the phases every real engagement follows:
1. **Scope & authorization** — what you're allowed to touch, in writing.
2. **Reconnaissance** — passive and active information gathering.
3. **Scanning & enumeration** — services, versions, misconfigurations.
4. **Exploitation** — turning a finding into access (in your lab).
5. **Post-exploitation** — what an attacker could do next; impact.
6. **Reporting** — the actual deliverable: findings, risk, remediation.

Frameworks worth reading: **PTES**, **OWASP Testing Guide**, **MITRE ATT&CK**.

## Stage 2 — Web application security
The most common real-world attack surface. Work through **PortSwigger Web
Security Academy** (free) and practice on **OWASP Juice Shop**:
- Injection (SQLi, command injection)
- Broken authentication & session management
- XSS, CSRF
- Access control / IDOR
- SSRF, file upload, deserialization

## Stage 3 — Network & host exploitation
Against **Metasploitable** / **VulnHub** boxes:
- Service enumeration with `nmap`
- Finding and using public exploits (Exploit-DB, Metasploit) responsibly
- Credential attacks **against your own lab accounts** (how `hydra`/`john` work,
  why weak/reused passwords fail, and how to defend with rate-limiting + MFA)
- Privilege escalation (Linux/Windows) — `linpeas`, `winpeas`

## Stage 4 — Put it together
- Full **boot-to-root** VulnHub/HTB machines end to end.
- Write a short **report** for each: what you found, impact, how to fix it.
  Reporting is the skill that makes you employable.

## Stage 5 — Formalize (optional)
Certifications that prove hands-on skill:
- **eJPT** (entry level), **PNPT**, **OSCP** (the well-known hard one), **CEH**.

## Using PentestGPT as you learn
[PentestGPT](https://github.com/GreyDGL/PentestGPT) is an AI assistant that
suggests next steps and explains tool output during an engagement. Use it as a
**tutor against your lab targets** — paste scan results, ask it to explain a
vulnerability, have it quiz you on methodology. Install it with
[`../scripts/setup_pentestgpt.sh`](../scripts/setup_pentestgpt.sh). It still
requires you to understand what you're running — treat its suggestions as
starting points to verify, not commands to blindly execute.

## Defensive counterpart
For every attack you learn, learn the fix. Understanding offense makes you a far
better defender — hardening, detection engineering, and incident response are
where most of this knowledge gets applied professionally and legally.
