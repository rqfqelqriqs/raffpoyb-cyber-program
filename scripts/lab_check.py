#!/usr/bin/env python3
"""
lab_check.py — print the project banner and do a quick, read-only check of your
learning environment. This does NOT scan, attack, or touch any network target;
it just tells you which common tools are installed so you know what to set up.
"""

import shutil
import sys
import time

BANNER = r"""
 ____        __  __                  _       ____      _
|  _ \ __ _ / _|/ _|_ __   ___  _   _| |__   / ___|   _| |__   ___ _ __
| |_) / _` | |_| |_| '_ \ / _ \| | | | '_ \ | |  | | | | '_ \ / _ \ '__|
|  _ < (_| |  _|  _| |_) | (_) | |_| | |_) || |__| |_| | |_) |  __/ |
|_| \_\__,_|_| |_| | .__/ \___/ \__, |_.__/  \____\__, |_.__/ \___|_|
                   |_|          |___/             |___/
         Offensive Security LEARNING lab — legal targets only
"""

# Standard, legitimate security tooling. Presence check only.
TOOLS = {
    "nmap": "network/port scanning",
    "sqlmap": "web SQL-injection practice (lab apps)",
    "hydra": "login-testing demos (your own lab accounts)",
    "john": "offline hash cracking (your own lab hashes)",
    "hashcat": "offline hash cracking (your own lab hashes)",
    "ffuf": "web content discovery (lab web servers)",
    "gobuster": "web content discovery (lab web servers)",
    "msfconsole": "Metasploit exploitation framework",
    "docker": "running vulnerable target containers (Juice Shop, etc.)",
}


def main() -> None:
    print(BANNER)
    print(f"Local time: {time.strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"Python:     {sys.version.split()[0]}\n")

    print("Tool availability (not installing anything, just checking):")
    for tool, purpose in TOOLS.items():
        found = shutil.which(tool)
        mark = "OK " if found else "-- "
        where = found if found else "not installed"
        print(f"  [{mark}] {tool:<11} {purpose}")
        _ = where  # kept for clarity; path available if you want to print it

    print(
        "\nReminder: only ever point these at machines you own or are\n"
        "explicitly authorized to test. See docs/LAB_SETUP.md to build a\n"
        "safe, isolated lab, and docs/ROADMAP.md for where to start."
    )


if __name__ == "__main__":
    main()
