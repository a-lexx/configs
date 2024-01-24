# 2024-01-15 10:30:08 by RouterOS 7.13.1
# software id = FE3U-D84W
#
# model = RBD52G-5HacD2HnD-TCr2
# serial number = 939208928B82
/caps-man channel
add band=2ghz-g/n control-channel-width=20mhz extension-channel=disabled \
    frequency=2462,2472,2442,2452 name=root reselect-interval=1d tx-power=20
add band=5ghz-a/n/ac frequency=5200,5220,5320,5500,5640,5765 name=1519 \
    reselect-interval=1d save-selected=yes skip-dfs-channels=no tx-power=20
/interface bridge
add name=bridge1 port-cost-mode=short
/interface wireless
# managed by CAPsMAN
# channel: 2472/20/gn(17dBm), SSID: 1519_2, CAPsMAN forwarding
set [ find default-name=wlan1 ] country=ukraine mode=ap-bridge ssid=root \
    wireless-protocol=802.11
# managed by CAPsMAN
# channel: 5640/20-eeeC/ac/DP(17dBm), SSID: 1519, CAPsMAN forwarding
set [ find default-name=wlan2 ] country=ukraine frequency=5240 mode=ap-bridge \
    ssid=1519 wireless-protocol=802.11
/interface ethernet
set [ find default-name=ether1 ] comment=isp
set [ find default-name=ether2 ] comment=aquarium
set [ find default-name=ether3 ] comment=cap2
set [ find default-name=ether4 ] comment=reserv
set [ find default-name=ether5 ] comment=cap3
/interface wireguard
add listen-port=51820 mtu=1420 name=wireguard1
/caps-man datapath
add bridge=bridge1 client-to-client-forwarding=yes local-forwarding=no name=\
    datapath1
/caps-man security
add authentication-types=wpa2-psk comment="My family password" encryption=\
    aes-ccm group-encryption=aes-ccm name=security1
add authentication-types=wpa2-psk comment=2.4hz_password encryption=aes-ccm \
    name=easy
/caps-man configuration
add channel=1519 channel.skip-dfs-channels=no country=ukraine datapath=\
    datapath1 distance=indoors installation=indoor mode=ap name=cfg_5G \
    rx-chains=0,1,2 security=security1 ssid=1519 tx-chains=0,1,2
add channel=root country=ukraine datapath=datapath1 installation=indoor mode=\
    ap name=cfg_2.4G rx-chains=0,1 security=easy ssid=1519_2 tx-chains=0,1,2
/caps-man interface
add configuration=cfg_2.4G disabled=no l2mtu=1600 mac-address=\
    2C:C8:1B:59:A6:18 master-interface=none name=cap1 radio-mac=\
    2C:C8:1B:59:A6:18 radio-name=2CC81B59A618
add configuration=cfg_5G disabled=no l2mtu=1600 mac-address=2C:C8:1B:59:A6:19 \
    master-interface=none name=cap2 radio-mac=2C:C8:1B:59:A6:19 radio-name=\
    2CC81B59A619
/interface list
add name=WAN
add name=LAN
/interface wireless security-profiles
set [ find default=yes ] authentication-types=wpa-psk,wpa2-psk mode=\
    dynamic-keys supplicant-identity=MikroTik
/ip pool
add name=dhcp ranges=172.18.2.100-172.18.2.120
/ip dhcp-server
add address-pool=dhcp interface=bridge1 lease-time=10m name=dhcp1
/caps-man manager
set enabled=yes
/caps-man provisioning
add action=create-dynamic-enabled hw-supported-modes=b,gn \
    master-configuration=cfg_2.4G
add action=create-dynamic-enabled hw-supported-modes=an,ac \
    master-configuration=cfg_5G
/interface bridge port
add bridge=bridge1 interface=ether2 internal-path-cost=10 path-cost=10
add bridge=bridge1 interface=ether3 internal-path-cost=10 path-cost=10
add bridge=bridge1 interface=ether4 internal-path-cost=10 path-cost=10
add bridge=bridge1 interface=ether5 internal-path-cost=10 path-cost=10
/ip neighbor discovery-settings
set discover-interface-list=LAN
/interface list member
add interface=ether1 list=WAN
add interface=bridge1 list=LAN
/interface wireguard peers
add allowed-address=10.9.8.2/32 endpoint-port=1 interface=wireguard1 \
    persistent-keepalive=25s preshared-key=\
    "05+3AiavJWE7z+ngoLGxLRKleCJQujIE+CU/QWMWNOE=" public-key=\
    "2lb6COdenp2hU3ha2Ab+6RR0wpoEaAPBOcCLYHq/uEc="
/interface wireless cap
#
set bridge=bridge1 caps-man-addresses=127.0.0.1 enabled=yes interfaces=\
    wlan1,wlan2
/ip address
add address=172.18.2.50/24 interface=bridge1 network=172.18.2.0
add address=10.9.8.50/24 interface=wireguard1 network=10.9.8.0
/ip dhcp-client
add interface=ether1 use-peer-dns=no
/ip dhcp-server lease
add address=172.18.2.15 client-id=\
    ff:3e:89:64:18:0:1:0:1:27:ba:5c:d1:0:16:3e:5:4e:89 mac-address=\
    00:16:3E:89:64:18 server=dhcp1
/ip dhcp-server network
add address=0.0.0.0/24 gateway=0.0.0.0 netmask=24
add address=172.18.2.0/24 dns-server=172.18.2.10,172.18.2.15 gateway=\
    172.18.2.50 netmask=24
/ip dns
set allow-remote-requests=yes servers=8.8.8.8,1.1.1.1
/ip firewall filter
add action=accept chain=output port=5246,5247 protocol=udp
add action=accept chain=input dst-port=51820 in-interface-list=WAN protocol=\
    udp
add action=accept chain=input port=5246,5247 protocol=udp
add action=accept chain=input comment="accept established,related,untracked" \
    connection-state=established,related,untracked
add action=drop chain=input comment="drop invalid" connection-state=invalid
add action=drop chain=input comment="drop all not coming from LAN" \
    in-interface-list=!LAN
/ip firewall nat
add action=src-nat chain=srcnat out-interface-list=WAN to-addresses=\
    159.224.176.54
add action=masquerade chain=srcnat disabled=yes out-interface-list=WAN
add action=dst-nat chain=dstnat dst-port=22 in-interface=ether1 protocol=tcp \
    to-addresses=172.18.2.15 to-ports=22
add action=dst-nat chain=dstnat comment=centurion-ssh-access dst-port=39901 \
    in-interface-list=WAN protocol=tcp to-addresses=172.18.2.10 to-ports=22
add action=dst-nat chain=dstnat dst-port=80 in-interface-list=WAN protocol=\
    tcp to-addresses=172.18.2.10 to-ports=80
add action=dst-nat chain=dstnat dst-port=443 in-interface-list=WAN protocol=\
    tcp to-addresses=172.18.2.10 to-ports=443
add action=dst-nat chain=dstnat dst-port=53 in-interface-list=WAN protocol=\
    udp to-addresses=172.18.2.10 to-ports=53
add action=dst-nat chain=dstnat disabled=yes dst-address=159.224.176.54 \
    dst-port=443 in-interface-list=LAN protocol=tcp src-address=172.18.2.0/24 \
    to-addresses=172.18.2.15 to-ports=443
add action=masquerade chain=srcnat out-interface=wireguard1
/ip firewall service-port
set ftp disabled=yes
set tftp disabled=yes
set sip disabled=yes
set pptp disabled=yes
/ip route
add comment=lxc disabled=no distance=1 dst-address=10.0.3.0/24 gateway=\
    172.18.2.115 pref-src="" routing-table=main suppress-hw-offload=no
/system clock
set time-zone-name=Europe/Kyiv
/system identity
set name=cap1.home
/system note
set show-at-login=no
/system ntp client
set enabled=yes
/system ntp client servers
add address=ntp.time.in.ua
/tool e-mail
set from=mikrotik server=10.0.3.10 tls=starttls
/tool mac-server
set allowed-interface-list=LAN
/tool mac-server mac-winbox
set allowed-interface-list=LAN
