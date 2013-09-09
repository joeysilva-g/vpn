# vpn

## Instructions

### Android VPN Client
Build and deploy the Android project.

### VPN Server
1. Create and configure a TUN virtual as outlined in vpn_server.cc
    * Use `server/create_tunnel.sh` to do this.
        
2. Build and run vpn_server:
    * `./vpn_server <tunN> <port> <secret> options...`
    * Options:
        + `-m <MTU>` for the maximum transmission unit
        + `-a <address> <prefix-length>` for the private address
        + `-r <address> <prefix-length>` for the forwarding route
        + `-d <address>` for the domain name server
        + `-s <domain>` for the search domain
    * Example: `./vpn_server tun0 8000 test -m 1400 -a 10.0.0.2 32 -d 8.8.8.8 -r 0.0.0.0 0`
