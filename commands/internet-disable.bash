#!/bin/bash

set -e -u -o pipefail || exit 1

test "${#}" -eq 0

sudo iptables -t filter -F
sudo iptables -t filter -X
sudo iptables -t filter -Z

sudo iptables -t filter -P FORWARD DROP
sudo iptables -t filter -P INPUT DROP
sudo iptables -t filter -P OUTPUT DROP

sudo iptables -t filter -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -t filter -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

sudo iptables -t filter -A INPUT -i lo -m state --state NEW -j ACCEPT
sudo iptables -t filter -A OUTPUT -o lo -m state --state NEW -j ACCEPT

# Incoming SSH
sudo iptables -t filter -A INPUT -p tcp --dport 22 -m state --state NEW -j ACCEPT

# Outgoing LDAP
sudo iptables -t filter -A OUTPUT -p tcp --dport 389 -m state --state NEW -j ACCEPT
sudo iptables -t filter -A OUTPUT -p tcp --dport 636 -m state --state NEW -j ACCEPT

# Outgoing DNS
sudo iptables -t filter -A OUTPUT -p udp --dport 53 -m state --state NEW -j ACCEPT

echo ok

exit 0
