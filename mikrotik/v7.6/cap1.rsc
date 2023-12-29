# dec/24/2022 15:27:31 by RouterOS 7.6
# software id = FE3U-D84W
#
# model = RBD52G-5HacD2HnD-TCr2
# serial number = 939208928B82
/caps-man channel
add band=2ghz-g/n control-channel-width=20mhz extension-channel=disabled \
    frequency=2462,2472,2412 name=root reselect-interval=1d tx-power=20
add band=5ghz-a/n/ac frequency=5180,5220,5240,5765 name=1519 \
    reselect-interval=1d save-selected=yes skip-dfs-channels=yes tx-power=20
/interface bridge
add name=bridge1
/interface ethernet
set [ find default-name=ether1 ] comment=isp
set [ find default-name=ether2 ] comment=aquarium
set [ find default-name=ether3 ] comment=cap2
set [ find default-name=ether4 ] comment=reserv
set [ find default-name=ether5 ] comment=cap3
/interface wireless
# managed by CAPsMAN
# channel: 2412/20/gn(17dBm), SSID: root, CAPsMAN forwarding
set [ find default-name=wlan1 ] country=ukraine mode=ap-bridge ssid=root \
    wireless-protocol=802.11
# managed by CAPsMAN
# channel: 5240/20-Ceee/ac/DP(17dBm), SSID: 1519, CAPsMAN forwarding
set [ find default-name=wlan2 ] country=ukraine frequency=5240 mode=ap-bridge \
    ssid=1519 wireless-protocol=802.11
/caps-man datapath
add bridge=bridge1 client-to-client-forwarding=yes local-forwarding=no name=\
    datapath1
/caps-man security
add authentication-types=wpa2-psk encryption=aes-ccm group-encryption=aes-ccm \
    name=security1
/caps-man configuration
add channel=1519 channel.skip-dfs-channels=no country=ukraine datapath=\
    datapath1 distance=indoors installation=indoor mode=ap name=cfg_5G \
    rx-chains=0,1,2 security=security1 ssid=1519 tx-chains=0,1,2
add channel=root country=ukraine datapath=datapath1 mode=ap name=cfg_2.4G \
    rx-chains=0,1 security=security1 ssid=root tx-chains=0,1,2
/caps-man interface
add configuration=cfg_2.4G disabled=no l2mtu=1600 mac-address=\
    2C:C8:1B:59:A6:18 master-interface=none mtu=0 name=cap1 radio-mac=\
    2C:C8:1B:59:A6:18 radio-name=2CC81B59A618
add configuration=cfg_5G disabled=no l2mtu=1600 mac-address=2C:C8:1B:59:A6:19 \
    master-interface=none mtu=0 name=cap2 radio-mac=2C:C8:1B:59:A6:19 \
    radio-name=2CC81B59A619
/interface list
add name=WAN
add name=LAN
/interface wireless security-profiles
set [ find default=yes ] authentication-types=wpa-psk,wpa2-psk mode=\
    dynamic-keys supplicant-identity=MikroTik
/ip pool
add name=dhcp ranges=172.18.2.100-172.18.2.120
/ip dhcp-server
add address-pool=dhcp interface=bridge1 name=dhcp1
/caps-man manager
set enabled=yes
/caps-man provisioning
add action=create-dynamic-enabled hw-supported-modes=an,ac \
    master-configuration=cfg_5G
add action=create-dynamic-enabled hw-supported-modes=b,gn \
    master-configuration=cfg_2.4G
/interface bridge port
add bridge=bridge1 interface=ether2
add bridge=bridge1 interface=ether3
add bridge=bridge1 interface=ether4
add bridge=bridge1 interface=ether5
/ip neighbor discovery-settings
set discover-interface-list=LAN
/interface list member
add interface=ether1 list=WAN
add interface=bridge1 list=LAN
/interface wireless cap
#
set bridge=bridge1 caps-man-addresses=127.0.0.1 enabled=yes interfaces=\
    wlan1,wlan2
/ip address
add address=172.18.2.50/24 interface=bridge1 network=172.18.2.0
/ip dhcp-client
add interface=ether1
/ip dhcp-server network
add address=0.0.0.0/24 gateway=0.0.0.0 netmask=24
add address=172.18.2.0/24 gateway=172.18.2.50 netmask=24
/ip dns
set allow-remote-requests=yes servers=8.8.8.8,1.1.1.1
/ip firewall filter
add action=accept chain=output port=5246,5247 protocol=udp
add action=accept chain=input port=5246,5247 protocol=udp
add action=accept chain=input comment="accept established,related,untracked" \
    connection-state=established,related,untracked
add action=drop chain=input comment="drop invalid" connection-state=invalid
add action=drop chain=input comment="drop all not coming from LAN" \
    in-interface-list=!LAN
/ip firewall nat
add action=masquerade chain=srcnat out-interface-list=WAN
/ip firewall service-port
set ftp disabled=yes
set tftp disabled=yes
set sip disabled=yes
set pptp disabled=yes
/system clock
set time-zone-name=Europe/Kiev
/system identity
set name=CAP1
/system ntp client
set enabled=yes
/system ntp client servers
add address=ntp.time.in.ua
/tool mac-server
set allowed-interface-list=LAN
/tool mac-server mac-winbox
set allowed-interface-list=LAN
