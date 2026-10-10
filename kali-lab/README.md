# Kali Linux Lab — Apple Silicon Mac (M1/M2/M3/M4) with UTM

A reproducible Kali Linux lab that **actually works error-free on Apple Silicon**.
It uses **UTM** (free, built on Apple's native Virtualization framework) instead
of VirtualBox — VirtualBox's ARM build is an unstable developer preview and will
fail on an M-series Mac.

Tested target setup: **Mac mini / MacBook with Apple M-series, 16 GB RAM.**
Kali runs as an **ARM64** guest, with **internet and DNS working out of the box**.

> **Scope & ethics.** This lab is for learning on systems *you own or are
> explicitly authorized to test* — your own VMs, or a school-provided target
> range. Scanning or attacking anything on the public internet or any network
> you don't own is illegal in most places. With internet enabled (below), use it
> for **updating tools and reading docs** — point your actual tool practice at
> vulnerable VMs you run **inside this lab**, never at live external hosts.

---

## What you'll end up with

- Kali Linux (ARM64) running natively-fast on your M4 via UTM.
- Working **internet + DNS** inside Kali (UTM "Shared Network" = NAT with DNS).
- A clean baseline **snapshot** so you can always reset.
- Optional one-command **isolation toggle** for when a class needs an offline range.

---

## 1. Install UTM (free)

1. Download the free `.dmg` directly from the developer:
   **<https://mac.getutm.app/>** → click **Download**.
   *(The Mac App Store version is the exact same app, just a paid convenience —
   the free `.dmg` is fully featured. Either is fine.)*
2. Open the `.dmg` and drag **UTM** into `/Applications`.
3. Launch it once. No kernel extensions and no Privacy-&-Security approval
   dance are needed — this is why UTM "just works" on Apple Silicon.

Verify it opened without errors, then quit.

---

## 2. Download Kali for Apple Silicon (ARM64)

Go to the official Kali downloads page:
**<https://www.kali.org/get-kali/>**

You have two good options — **Option A (prebuilt) is the easiest and what I
recommend**:

### Option A — Prebuilt Apple Silicon VM (recommended, least error-prone)
- On the downloads page choose **Virtual Machines → Apple Silicon**
  (this is a prebuilt image packaged for Apple-Silicon virtualization / UTM).
- You'll get a compressed image (e.g. `.7z`). Install `p7zip` and extract:
  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"  # if you don't have Homebrew
  brew install p7zip
  cd ~/Downloads
  7z x kali-linux-*-apple-silicon*.7z
  ```
- **Verify the download** against the SHA256 shown on the Kali page (good habit,
  often required for class):
  ```bash
  shasum -a 256 ~/Downloads/kali-linux-*-apple-silicon*.7z
  ```

### Option B — Installer ISO (if no prebuilt image is offered for your version)
- Choose **Installer Images → ARM64** (the `.iso` ending in `-arm64.iso`).
- You'll install Kali into a fresh UTM VM yourself (step 3B). Takes ~20 min.

> ⚠️ **Must be ARM64 / Apple Silicon.** Do **not** download the `amd64`/x86
> images — they won't virtualize on an M4 and will error out. If a build in the
> dropdown doesn't list an Apple-Silicon or ARM64 option, pick the most recent
> release that does.

---

## 3. Create the VM in UTM

### Path A — Import the prebuilt image
1. Many prebuilt bundles come as a `.utm` package — if so, just **double-click
   it**, and it appears in UTM. Skip to step 4.
2. If it's a raw disk image instead, in UTM click **＋ → Virtualize → Linux**,
   then on the boot-image screen point it at the extracted disk / follow the
   README included in the download.

### Path B — Install from the ARM64 ISO
1. UTM → **＋ → Virtualize** (not Emulate — virtualize is the fast, native path)
   → **Linux**.
2. **Boot ISO Image** → Browse → select the `-arm64.iso` you downloaded.
3. Hardware (good values for a 16 GB Mac):
   - **Memory:** `4096` MB (you can go 6144; leave plenty for macOS)
   - **CPU Cores:** `4`
   - Leave **Enable hardware OpenGL acceleration** on.
4. **Storage:** `40` GB.
5. **Shared Directory:** optional, skip for now.
6. Name it `Kali-Lab`, **Save**, then **▶︎ Start** and run through the Kali
   graphical installer (accept defaults; create your user; install GRUB to the
   virtual disk). When it reboots, **remove the ISO** from the VM's drive in
   UTM settings so it boots from disk.

---

## 4. Network: internet + DNS on by default (your choice)

UTM's default network mode is **Shared Network**, which is NAT with a built-in
DNS resolver — so Kali gets internet and name resolution **automatically**, no
configuration. To confirm/set it:

- Select the VM → **Edit (⚙︎) → Network → Network Mode = Shared Network** → Save.

That's it — DNS works out of the box. You'll verify in step 6.

> **Later, when a class needs an isolated range:** switch **Network Mode** to
> **Host Only** (Kali ⇄ your Mac only) or add target VMs on the same Host-Only
> network for a closed lab. The helper script `toggle-network.sh` in this folder
> does this from the Mac command line — see its header.

---

## 5. First boot & secure it

Log in to Kali. Default creds on prebuilt images are **`kali` / `kali`** — change
immediately:

```bash
passwd
```

Update everything (internet is already working):

```bash
sudo apt update && sudo apt -y full-upgrade
```

If `apt update` resolves and downloads, your **DNS and internet are confirmed
working**. 🎉

---

## 6. Verify DNS & connectivity

Copy `verify-network.sh` (in this folder) into Kali and run it — it checks the
default route, DNS resolution, and HTTPS reachability, and prints a clear
pass/fail for each:

```bash
chmod +x verify-network.sh
./verify-network.sh
```

Quick manual check if you prefer:

```bash
ip route            # should show a default route (e.g. via 192.168.64.1)
getent hosts kali.org   # DNS resolves a name -> IP
ping -c 3 kali.org  # ICMP may be filtered; DNS resolving is the real signal
curl -I https://kali.org   # expect HTTP/2 200 or 301
```

---

## 7. Snapshot (do this now — saves you hours)

In UTM, with the VM selected: **right-click the VM → … or** use the drive
settings. UTM's snapshot support depends on the disk being a qcow2 image
(the default for virtualized Linux VMs). To snapshot from Terminal via QEMU's
tooling bundled in UTM:

```bash
# Find the VM's qcow2 disk inside the .utm bundle (adjust the VM name):
DISK=$(find ~/Library/Containers/com.utmapp.UTM/Data/Documents/Kali-Lab.utm \
  -name '*.qcow2' | head -n1)

# Take a clean baseline snapshot:
/Applications/UTM.app/Contents/MacOS/qemu-img snapshot -c clean-baseline "$DISK"

# List snapshots:
/Applications/UTM.app/Contents/MacOS/qemu-img snapshot -l "$DISK"

# Restore the baseline later (VM powered off):
/Applications/UTM.app/Contents/MacOS/qemu-img snapshot -a clean-baseline "$DISK"
```

> Simplest alternative: with the VM **powered off**, right-click it in UTM →
> **Clone**, and keep the clone as your pristine backup.

---

## 8. Practice legally, inside the lab

Point your tools at intentionally-vulnerable targets **you run yourself**:

- **OWASP Juice Shop**, **DVWA**, **Metasploitable 2/3** — run as separate VMs
  (or Docker inside Kali) on a Host-Only network with Kali.
- Free structured practice ranges: **TryHackMe**, **Hack The Box** — these are
  authorized targets you connect to over VPN, so internet-on is expected and
  legal there.

---

## Troubleshooting (Apple Silicon)

| Symptom | Fix |
|---------|-----|
| Downloaded Kali won't boot / "unsupported" | You grabbed the **amd64** image. Re-download the **ARM64 / Apple Silicon** one. |
| No internet / DNS fails in Kali | VM → Edit → **Network Mode = Shared Network**; inside Kali `sudo systemctl restart NetworkManager`; check `cat /etc/resolv.conf` has a nameserver. |
| VM is extremely slow | Make sure you chose **Virtualize**, not **Emulate**, when creating it. |
| UTM won't install an x86 tool | Some tools ship x86-only; on ARM Kali use ARM-native packages, or emulate that one tool — don't emulate the whole VM. |
| Black screen after install | Remove the ISO from the VM's drive (UTM → Edit → remove boot ISO) so it boots from disk. |

## Learn the tools (official)

- Kali docs: <https://www.kali.org/docs/>
- Free "Kali Linux Revealed" course: <https://www.kali.org/docs/introduction/>
- UTM docs: <https://docs.getutm.app/>

---

*Intel Mac? See [`intel-virtualbox.md`](intel-virtualbox.md) instead.*
