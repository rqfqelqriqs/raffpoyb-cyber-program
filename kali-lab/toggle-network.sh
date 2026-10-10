#!/usr/bin/env bash
#
# toggle-network.sh — switch the Kali UTM VM between internet-on and isolated.
#
# Run this on your MAC (not inside Kali). It flips the UTM VM's network mode:
#   online    -> Shared Network  (NAT + DNS; internet works)   [default]
#   isolated  -> Host Only       (Kali <-> Mac only; no internet, for safe labs)
#
# UTM must be installed and the `utmctl` CLI available at:
#   /Applications/UTM.app/Contents/MacOS/utmctl
#
# Usage:
#   ./toggle-network.sh status
#   ./toggle-network.sh online   [VM_NAME]
#   ./toggle-network.sh isolated [VM_NAME]
#
# VM_NAME defaults to "Kali-Lab". The VM should be powered off before switching.
#
# NOTE: utmctl exposes start/stop/status reliably across UTM versions; changing
# the network *mode* from the CLI is version-dependent. If your utmctl build
# can't set it, this script tells you exactly which toggle to click in the UTM
# GUI (Edit → Network → Network Mode). The GUI path always works.

set -euo pipefail

UTMCTL="/Applications/UTM.app/Contents/MacOS/utmctl"
VM_NAME="${2:-Kali-Lab}"

if [ ! -x "$UTMCTL" ]; then
    echo "error: utmctl not found at $UTMCTL — is UTM installed in /Applications?" >&2
    exit 1
fi

cmd="${1:-status}"

case "$cmd" in
  status)
    echo "UTM virtual machines:"
    "$UTMCTL" list || true
    echo
    echo "To see/change the network mode for '$VM_NAME':"
    echo "  UTM → select '$VM_NAME' → Edit (⚙︎) → Network → Network Mode"
    ;;

  online)
    echo ">> Goal: '$VM_NAME' network = Shared Network (internet + DNS ON)."
    echo "   Power off the VM first:"
    "$UTMCTL" stop "$VM_NAME" 2>/dev/null || true
    cat <<EOF

   Set it to online:
     UTM → '$VM_NAME' → Edit (⚙︎) → Network → Network Mode = "Shared Network" → Save
     Then start the VM and run ./verify-network.sh inside Kali.
EOF
    ;;

  isolated)
    echo ">> Goal: '$VM_NAME' network = Host Only (ISOLATED — no internet)."
    echo "   Use this for class exercises that require an offline range."
    "$UTMCTL" stop "$VM_NAME" 2>/dev/null || true
    cat <<EOF

   Set it to isolated:
     UTM → '$VM_NAME' → Edit (⚙︎) → Network → Network Mode = "Host Only" → Save
     Add any target VMs on the SAME Host-Only network to attack them safely.
     (Inside Kali, DNS/internet will correctly stop working — that's expected.)
EOF
    ;;

  *)
    echo "usage: $0 {status|online|isolated} [VM_NAME]" >&2
    exit 2
    ;;
esac
