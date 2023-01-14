# sep/24/2022 12:02:06 by RouterOS 7.5
# software id = M5Y4-QJSY
#
# model = RBcAPGi-5acD2nD
# serial number = E2810E00230F
/interface bridge
add name=bridge1
/interface wireless
# managed by CAPsMAN
# channel: 2472/20/gn(18dBm), SSID: root, CAPsMAN forwarding
set [ find default-name=wlan1 ] ssid=MikroTik
# managed by CAPsMAN
# channel: 5240/20-Ceee/ac/DP(17dBm), SSID: 1519, CAPsMAN forwarding
set [ find default-name=wlan2 ] ssid=MikroTik
/interface list
add name=WAN
add name=LAN
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/interface bridge port
add bridge=bridge1 interface=ether1
add bridge=bridge1 interface=ether2
add bridge=bridge1 interface=wlan1
add bridge=bridge1 interface=wlan2
/interface list member
add interface=ether1 list=WAN
add interface=ether2 list=LAN
add interface=wlan2 list=LAN
add interface=wlan1 list=LAN
/interface wireless cap
# 
set bridge=bridge1 caps-man-addresses=172.18.2.50 enabled=yes interfaces=\
    wlan1,wlan2
/ip address
add address=172.18.2.30/24 interface=ether1 network=172.18.2.0
/ip dns
set servers=172.18.2.50
/ip route
add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=172.18.2.50 \
    pref-src="" routing-table=main suppress-hw-offload=no
/system clock
set time-zone-name=Europe/Kiev
/system identity
set name=CAP3
/system ntp client
set enabled=yes
