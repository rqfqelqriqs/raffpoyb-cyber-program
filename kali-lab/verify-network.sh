#!/usr/bin/env bash
#
# verify-network.sh — run this INSIDE the Kali VM to confirm internet + DNS work.
#
# Usage (inside Kali):
#   chmod +x verify-network.sh
#   ./verify-network.sh
#
# Exit code 0 = all core checks passed. Non-zero = something to fix (see the
# troubleshooting table in README.md). ICMP ping is informational only, since
# many networks filter it; DNS + HTTPS are the checks that actually matter.

set -u

pass=0
fail=0

ok()   { printf '  \033[32m[ PASS ]\033[0m %s\n' "$1"; pass=$((pass+1)); }
no()   { printf '  \033[31m[ FAIL ]\033[0m %s\n' "$1"; fail=$((fail+1)); }
info() { printf '  \033[33m[ INFO ]\033[0m %s\n' "$1"; }

echo
echo "Kali lab network check"
echo "======================"

# 1. Default route present?
echo
echo "1) Default route"
if ip route 2>/dev/null | grep -q '^default'; then
    gw=$(ip route 2>/dev/null | awk '/^default/{print $3; exit}')
    ok "default route via ${gw}"
else
    no "no default route (NetworkManager down, or Network Mode not 'Shared')"
fi

# 2. A nameserver is configured?
echo
echo "2) DNS configuration"
if grep -qE '^\s*nameserver\s+[0-9a-fA-F:.]+' /etc/resolv.conf 2>/dev/null; then
    ns=$(awk '/^nameserver/{print $2; exit}' /etc/resolv.conf)
    ok "nameserver configured: ${ns}"
else
    no "no nameserver in /etc/resolv.conf"
fi

# 3. DNS actually resolves a name?
echo
echo "3) DNS resolution"
if getent hosts kali.org >/dev/null 2>&1; then
    ip=$(getent hosts kali.org | awk '{print $1; exit}')
    ok "resolved kali.org -> ${ip}"
elif command -v host >/dev/null 2>&1 && host -W 5 kali.org >/dev/null 2>&1; then
    ok "resolved kali.org (via host)"
else
    no "could not resolve kali.org — DNS not working"
fi

# 4. HTTPS reachability (the real 'internet works' test)
echo
echo "4) Internet (HTTPS)"
if command -v curl >/dev/null 2>&1; then
    if curl -4 -s -o /dev/null -m 15 -w '%{http_code}' https://kali.org 2>/dev/null \
         | grep -qE '^(200|301|302)$'; then
        ok "HTTPS to kali.org succeeded"
    else
        no "HTTPS to kali.org failed"
    fi
else
    info "curl not installed; skipping (install with: sudo apt install -y curl)"
fi

# 5. ICMP (informational only)
echo
echo "5) ICMP ping (informational)"
if ping -c 2 -W 3 1.1.1.1 >/dev/null 2>&1; then
    info "ping to 1.1.1.1 succeeded"
else
    info "ping blocked/failed — fine as long as DNS + HTTPS passed above"
fi

echo
echo "----------------------------------------"
printf 'Result: %d passed, %d failed\n' "$pass" "$fail"
if [ "$fail" -eq 0 ]; then
    echo "Internet + DNS look good. You're ready."
    exit 0
else
    echo "Some checks failed — see the Troubleshooting table in README.md."
    echo "Common fix: VM → Edit → Network Mode = Shared Network, then inside Kali:"
    echo "  sudo systemctl restart NetworkManager"
    exit 1
fi
