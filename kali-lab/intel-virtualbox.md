# Kali Linux Lab Setup — **Intel** macOS + VirtualBox (Isolated Lab)

> **Are you on Apple Silicon (M1/M2/M3/M4)?** This guide is **not** for you —
> VirtualBox doesn't properly support ARM Macs. Use **[`README.md`](README.md)**
> (UTM) instead. This file is kept only for Intel Macs.


A reproducible, **self-contained** Kali Linux sandbox for coursework. The lab is
network-isolated: your Kali VM (and any target VMs you add) can talk to each
other but **cannot reach the internet or your home/campus network**. This is the
configuration most cybersecurity courses require before you run scanning or
attack tooling, and it keeps all practice legal and contained to machines you
own.

> **Scope & ethics.** Everything here is for learning on systems *you own or are
> explicitly authorized to test* — your own VMs inside this isolated lab, or a
> school-provided target range. Scanning, accessing, or attacking any system you
> don't own or have written permission to test is illegal in most places. Keep
> it in the lab.

---

## 0. Pick your path (this matters on Mac)

| Your Mac | Use | Why |
|----------|-----|-----|
| **Intel Mac** | **VirtualBox** (this guide) | Fully supported, stable, free. |
| **Apple Silicon** (M1/M2/M3/M4) | **UTM** (see `README.md`) | VirtualBox's ARM build is still an unstable developer preview. UTM is the reliable free option on Apple Silicon. The *lab concepts* (isolated network, snapshots, updating) are identical. |

Check which you have:  → Apple menu →  **About This Mac**. If it says "Apple M…",
follow `README.md`. If it says "Intel", continue below.

---

## 1. Install VirtualBox (Intel Mac)

1. Download VirtualBox for **macOS / Intel hosts** from the official site:
   <https://www.virtualbox.org/wiki/Downloads>
2. Install the `.dmg`. macOS will likely block the kernel extension the first
   time — open **System Settings → Privacy & Security**, scroll down, and click
   **Allow** for "Oracle", then reboot if prompted.
3. (Optional but recommended) install the matching **VirtualBox Extension Pack**
   from the same page for USB and better device support.

Verify from Terminal:

```bash
VBoxManage --version
```

---

## 2. Get Kali

Kali publishes a **prebuilt VirtualBox image** so you don't have to install from
an ISO — this is the fastest, least error-prone route for a class.

1. Go to <https://www.kali.org/get-kali/#kali-virtual-machines>
2. Download the **VirtualBox** image (an `.ova` / 7z-compressed VDI, ~3–4 GB).
3. Verify the download's checksum against the one listed on the page before
   importing — don't skip this; it's good security hygiene and often part of the
   coursework:

```bash
# Example — use the exact SHA256 shown on the Kali download page
shasum -a 256 ~/Downloads/kali-linux-*-virtualbox-amd64.7z
```

4. If it's a `.7z`, extract it (`brew install p7zip` then `7z x <file>`), which
   gives you an `.ova` (or a `.vbox` + `.vdi`).

---

## 3. Import into VirtualBox

- **If you got an `.ova`:** VirtualBox → **File → Import Appliance** → select the
  `.ova` → adjust RAM/CPU on the review screen → **Finish**.
- **If you got a `.vbox`/`.vdi` folder:** double-click the `.vbox`, or
  **Machine → Add**.

Suggested resources (tune to your Mac):

| Setting | Minimum | Comfortable |
|---------|---------|-------------|
| RAM     | 2048 MB | 4096 MB     |
| CPUs    | 2       | 2–4         |
| Disk    | 20 GB   | 40+ GB      |

Default Kali login for the prebuilt image: **`kali` / `kali`** — change it
immediately (step 6).

---

## 4. Make the lab isolated (the important part)

You want Kali on a private network with no route to the internet or your real
LAN. Two common ways — pick one:

### Option A — Host-Only network (Kali ⇄ your Mac only, recommended to start)

Create a host-only network once:

```bash
# Creates a vboxnetN interface on your Mac; Kali and your host can reach
# each other, but Kali has no path to the internet or your LAN.
VBoxManage hostonlyif create
VBoxManage list hostonlyifs          # note the name, e.g. vboxnet0
```

Attach Kali's adapter to it (VM must be powered off; replace the VM name and
interface as needed):

```bash
VBoxManage modifyvm "Kali Linux" --nic1 hostonly --hostonlyadapter1 vboxnet0
```

### Option B — Internal network (Kali ⇄ target VMs only, nothing else)

Best once you add vulnerable target VMs (e.g. a provided lab target) and want a
closed range that can't even see your Mac:

```bash
VBoxManage modifyvm "Kali Linux"   --nic1 intnet --intnet1 "cyberlab"
VBoxManage modifyvm "Target VM"    --nic1 intnet --intnet1 "cyberlab"
```

All VMs sharing the `intnet1` name ("cyberlab") form one isolated segment.

> You can keep **two adapters**: NIC1 isolated (Option A or B) for lab traffic,
> and NIC2 as NAT *only when you deliberately need to update tools* (step 7),
> then disable it again. Don't run attack practice with NAT enabled.

---

## 5. First boot

Start the VM, log in, and confirm it works. Then take a baseline snapshot (step 8).

---

## 6. Secure the VM

Inside Kali:

```bash
passwd                      # change the default kali password
sudo passwd root            # if you'll use root
```

---

## 7. Updating tools (temporary internet, then back to isolated)

When you need to pull updates, give Kali internet *briefly* via a NAT adapter,
update, then remove it:

```bash
# On your Mac, with the VM powered off — add a temporary NAT adapter:
VBoxManage modifyvm "Kali Linux" --nic2 nat
```

Boot Kali, then:

```bash
sudo apt update && sudo apt -y full-upgrade
```

Power off and remove internet again so the lab is isolated for practice:

```bash
VBoxManage modifyvm "Kali Linux" --nic2 none
```

Verify isolation after booting back up with `verify-isolation.sh` (see below).

---

## 8. Snapshots (save yourself hours)

Take a snapshot right after setup, and before anything risky:

```bash
VBoxManage snapshot "Kali Linux" take "clean-baseline" \
  --description "Fresh install, isolated network, updated tools"
```

Roll back anytime (VM powered off):

```bash
VBoxManage snapshot "Kali Linux" restore "clean-baseline"
```

---

## 9. Verify you're actually isolated

Copy `verify-isolation.sh` (in this folder) into the Kali VM and run it. It
confirms there's **no** route to the internet and shows your lab-only
addressing. See the script's header for usage.

---

## Troubleshooting

- **"Kernel driver not installed" / VM won't start:** the macOS extension was
  blocked — redo step 1's *Privacy & Security → Allow*, then reboot.
- **VT-x/virtualization errors:** Intel Macs support this natively; make sure no
  other hypervisor (e.g. Docker's, an old VMware) is holding it. Reboot.
- **On Apple Silicon and nothing works:** you're on the wrong guide — use
  `README.md` (VirtualBox doesn't properly support ARM Macs yet).
- **No internet even when you want it (step 7):** confirm the NAT adapter is
  attached *and* enabled, and that you removed any `--cableconnected1 off`.

## Where to learn the tools (official, class-friendly)

- Kali docs & training: <https://www.kali.org/docs/>
- Kali's own free course "Kali Linux Revealed": <https://www.kali.org/docs/introduction/>
- Practice *legally* against intentionally-vulnerable targets you run **inside
  this isolated lab** — e.g. OWASP Juice Shop, Metasploitable, DVWA — never
  against the live internet.
