# Building a Safe, Legal Practice Lab

The whole point of a lab is that you can break things freely because **you own
every machine in it**. Nothing leaves your control, so nothing you do is illegal.

## Option A — Hosted labs (easiest, zero setup)

These platforms give you *permission* to attack their machines. Start here if
you're new.

- **PortSwigger Web Security Academy** — free, best-in-class web app training.
  https://portswigger.net/web-security
- **TryHackMe** — guided rooms, beginner friendly. https://tryhackme.com/
- **Hack The Box** — boxes and the "Academy" track. https://www.hackthebox.com/
- **PicoCTF** — free CTF challenges, great for fundamentals. https://picoctf.org/

With these, you only need a browser and (often) a VPN client they provide. No
legal gray area: the scope is defined for you.

## Option B — Local lab on your own machine (full control)

Run intentionally-vulnerable targets inside VMs on an **isolated host-only /
NAT network** so nothing is exposed to the internet or your LAN.

### 1. Hypervisor
Install [VirtualBox](https://www.virtualbox.org/) (free) or VMware.

### 2. Attacker VM
Download **Kali Linux** or **Parrot OS** as a VM appliance and import it.
- Kali: https://www.kali.org/get-kali/
- Parrot: https://parrotsec.org/

### 3. Vulnerable target VMs (pick any)
- **OWASP Juice Shop** (modern web app):
  ```bash
  docker run --rm -p 127.0.0.1:3000:3000 bkimminich/juice-shop
  ```
- **DVWA** (classic web app): https://github.com/digininja/DVWA
- **Metasploitable 2/3** (vulnerable Linux host):
  https://sourceforge.net/projects/metasploitable/
- **VulnHub** images (boot-to-root challenges): https://www.vulnhub.com/

### 4. Network isolation (important)
In VirtualBox, set both the attacker and target adapters to the **same
Host-Only or Internal network**, not Bridged. This guarantees your traffic
cannot reach anything but your own lab machines.

```
[ Kali VM ] ──(host-only net 192.168.56.0/24)── [ Target VM ]
      │
      └── no route to the internet or your real LAN
```

### 5. Verify isolation before you start
```bash
# On the attacker VM — confirm you can see the target
ping -c1 <target-lab-ip>

# Confirm the target is on your private lab range, e.g. 192.168.56.x
ip a
```

## A note on tools like Hydra, nmap, sqlmap

These are legitimate, industry-standard tools. They are legal to **own and
run** — what matters is the *target*. Point them only at:

- a lab IP you set up above, or
- a hosted-lab box you've been given access to, or
- a system you have written authorization to test.

Never point them at an address you don't control. "I was just learning" is not
a legal defense for scanning or brute-forcing someone else's system.

## Next
Head to [`ROADMAP.md`](ROADMAP.md) for a structured learning path.
