#!/bin/bash

# Script to create a tunnel for use by the VPN server.

usage(){
  echo "Usage: $0 options
OPTIONS:
  -h: Show this message
  -t: Tunnel interface name (default tun0)
  -n: NAT range, specified as <IP prefix>/<prefix length in bits>.
      Must include tunnel source and destination addresses (default 10.0.0.0/8)
  -s: Tunnel source address (default 10.0.0.1)
  -d: Tunnel destination address (default 10.0.0.2)"
}

TUN=tun0
NAT=10.0.0.0/8
SRC=10.0.0.1
DEST=10.0.0.2
while getopts "ht:n:s:d" OPTION
do
  case $OPTION in
    h)
      usage
      exit 1
      ;;
    t)
      TUN=$OPTARG
      ;;
    n)
      NAT=$OPTARG
      ;;
    s)
      SRC=$OPTARG
      ;;
    d)
      DEST=$OPTARG
      ;;
    ?)
      usage
      exit
      ;;
  esac
done

# Enable IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward;

# Perform NAT over eth0 on a range of addresses
iptables -t nat -A POSTROUTING -s $NAT -o eth0 -j MASQUERADE;

# Create TUN interface
ip tuntap add dev $TUN mode tun;

# Set the addresses and bring up the interface
ifconfig $TUN $SRC dstaddr $DEST up;
