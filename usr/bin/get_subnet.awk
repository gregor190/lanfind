# lanfind - LAN mapping ritual by Gregor
# Copyright (C) 2025 Gregor
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.

# -----------------------------------------------------------------------------
# get_subnet.awk — Extracts IPv4 subnet from `ip a` output
# -----------------------------------------------------------------------------

# Track current interface name
/^([0-9]+): ([^:]+):/ {
    iface = $2
    next
}

function ip2int(a, b, c, d) {
    return (a * 256 * 256 * 256) + (b * 256 * 256) + (c * 256) + d
}

function int2ip(n,   a, b, c, d) {
    a = int(n / (256 * 256 * 256)) % 256
    b = int(n / (256 * 256)) % 256
    c = int(n / 256) % 256
    d = n % 256
    return a "." b "." c "." d
}

function maskbits(masklen, i, mask) {
    mask = 0
    for (i = 0; i < masklen; i++) {
        mask += 2^(31 - i)
    }
    return mask
}

function bitwise_and(a, b, result, i) {
    result = 0
    for (i = 0; i < 32; i++) {
        if ((int(a / 2^i) % 2) && (int(b / 2^i) % 2)) {
            result += 2^i
        }
    }
    return result
}

/inet / && $2 ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+\// {
    split($2, ipmask, "/")
    ip = ipmask[1]
    if (iface == "lo" || ip ~ /^127\./ || ip ~ /^169\.254\./) next  # skip loopback and link-local
    split(ip, octets, ".")
    ipint = ip2int(octets[1], octets[2], octets[3], octets[4])
    masklen = ipmask[2] + 0
    mask = maskbits(masklen)
    net = bitwise_and(ipint, mask)
    print int2ip(net) "/" masklen
    exit
}
