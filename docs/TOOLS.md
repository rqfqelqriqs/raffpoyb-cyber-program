# Core Tools (and how to use them legally)

Every tool below is standard, legitimate security software. The only thing that
makes usage legal or illegal is the **target**. Rule of thumb: if you can't
point to written authorization or a lab machine you own, don't run it.

## Reconnaissance & scanning
- **nmap** — host discovery, port/service/version scanning.
  ```bash
  nmap -sV -sC 192.168.56.101      # your lab target only
  ```
- **whois / dig / amass** — passive info gathering on domains you own or are scoped to.

## Web application testing
- **Burp Suite (Community)** — intercepting proxy; the core web-pentest tool.
- **OWASP ZAP** — open-source alternative to Burp.
- **sqlmap** — automated SQL injection **against lab apps like DVWA/Juice Shop**.
  ```bash
  sqlmap -u "http://localhost:3000/rest/products/search?q=test" --batch
  ```
- **ffuf / gobuster** — content/directory discovery on your lab web servers.

## Exploitation frameworks
- **Metasploit Framework** — exploit delivery and post-exploitation in the lab.
- **searchsploit / Exploit-DB** — find public PoCs; read and understand before running.

## Credential & hash tooling (lab accounts only)
These demonstrate *why weak passwords fail* so you can defend against it.
- **hydra** — online login testing. Only ever against **accounts you created on
  your own lab host.** Pair this lesson with the defense: rate-limiting,
  account lockout, and MFA.
- **john / hashcat** — offline cracking of hashes **from your own lab**, to show
  why slow hashing (bcrypt/argon2) + salts matter.

## Privilege escalation helpers
- **linpeas / winpeas**, **pspy** — enumerate a box you've already gained lab
  access to, to find escalation paths.

## AI study assistant
- **PentestGPT** — explains tool output and suggests methodology steps. Install
  via `scripts/setup_pentestgpt.sh`. Needs your own OpenAI API key. Use it to
  learn, not to auto-run commands you don't understand.

---

### The one thing to remember
Owning and running these tools is fine. Running them against a system you don't
own and aren't authorized to test is a crime in most jurisdictions. Keep a copy
of your authorization (or the hosted-lab's terms) for anything that isn't your
own VM.
