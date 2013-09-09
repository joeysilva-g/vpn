vpn
===

Instructions
------------

### Android VPN Client
Build and deploy the Android project.

### VPN Server
1. Create and configure a TUN virtual as outlined in vpn_server.cc:
    1. Enable IP forwarding:
    
        `echo 1 > /proc/sys/net/ipv4/ip_forward`
        
    2. Perform NAT over eth0 on a range of addresses, e.g. `10.0.0.0/8`:
    
        `iptables -t nat -A POSTROUTING -s 10.0.0.0/8 -o eth0 -j MASQUERADE`
        
    3. Create TUN interface, e.g. `tun0`:
    
        `ip tuntap add dev tun0 mode tun`
        
    4. Set the addresses and bring up the interface, e.g. `10.0.0.1` and `10.0.0.2`:
    
        `ifconfig tun0 10.0.0.1 dstaddr 10.0.0.2 up`
        
2. Build and run vpn_server:
    
    + `./vpn_server <tunN> <port> <secret> options...`

    + Options:
        * `-m <MTU>` for the maximum transmission unit
        * `-a <address> <prefix-length>` for the private address
        * `-r <address> <prefix-length>` for the forwarding route
        * `-d <address>` for the domain name server
        * `-s <domain>` for the search domain
            
    + Example: `./vpn_server tun0 8000 test -m 1400 -a 10.0.0.2 32 -d 8.8.8.8 -r 0.0.0.0 0`
 