#!/bin/bash

set -e -u -o pipefail || exit 1

test "${#}" -eq 0

sudo iptables -t filter -F
sudo iptables -t filter -X
sudo iptables -t filter -Z

sudo iptables -t filter -P FORWARD ACCEPT
sudo iptables -t filter -P INPUT ACCEPT
sudo iptables -t filter -P OUTPUT ACCEPT

echo ok

exit 0
