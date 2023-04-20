# nov/09/2022 15:49:15 by RouterOS 7.6
# software id = 1ZF1-AQH0
#
# model = RB2011iL
# serial number = D52B0D323D67
/interface bridge
add admin-mac=08:55:31:D2:F8:DD auto-mac=no comment=defconf name=bridge
/interface ethernet
set [ find default-name=ether6 ] advertise=\
    100M-half,100M-full,1000M-half,1000M-full
set [ find default-name=ether7 ] advertise=\
    100M-half,100M-full,1000M-half,1000M-full
set [ find default-name=ether8 ] advertise=\
    100M-half,100M-full,1000M-half,1000M-full
set [ find default-name=ether9 ] advertise=\
    100M-half,100M-full,1000M-half,1000M-full
set [ find default-name=ether10 ] advertise=\
    100M-half,100M-full,1000M-half,1000M-full
/interface list
add comment=defconf name=WAN
add comment=defconf name=LAN
/interface lte apn
set [ find default=yes ] ip-type=ipv4 use-network-apn=no
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=default-dhcp ranges=192.168.88.10-192.168.88.254
/ip dhcp-server
add address-pool=default-dhcp interface=bridge name=defconf
/port
set 0 name=serial0
/interface bridge port
add bridge=bridge comment=defconf ingress-filtering=no interface=ether2
add bridge=bridge comment=defconf ingress-filtering=no interface=ether3
add bridge=bridge comment=defconf ingress-filtering=no interface=ether4
add bridge=bridge comment=defconf ingress-filtering=no interface=ether5
add bridge=bridge comment=defconf ingress-filtering=no interface=ether6
add bridge=bridge comment=defconf ingress-filtering=no interface=ether7
add bridge=bridge comment=defconf ingress-filtering=no interface=ether8
add bridge=bridge comment=defconf ingress-filtering=no interface=ether9
add bridge=bridge comment=defconf ingress-filtering=no interface=ether10
/ip neighbor discovery-settings
set discover-interface-list=LAN
/ip settings
set max-neighbor-entries=8192
/ipv6 settings
set disable-ipv6=yes max-neighbor-entries=8192
/interface list member
add comment=defconf interface=bridge list=LAN
add comment=defconf interface=ether1 list=WAN
/interface ovpn-server server
set auth=sha1,md5
/ip address
add address=192.168.88.1/24 comment=defconf interface=bridge network=\
    192.168.88.0
/ip dhcp-client
add comment=defconf interface=ether1
/ip dhcp-server network
add address=192.168.88.0/24 comment=defconf gateway=192.168.88.1
/ip dns
set allow-remote-requests=yes servers=1.1.1.1,8.8.8.8
/ip dns static
add address=192.168.88.1 comment=defconf name=router.lan
/ip firewall filter
add action=accept chain=input comment=\
    "defconf: accept established,related,untracked" connection-state=\
    established,related,untracked
add action=drop chain=input comment="defconf: drop invalid" connection-state=\
    invalid
add action=accept chain=input comment="defconf: accept ICMP" protocol=icmp
add action=accept chain=input comment=\
    "defconf: accept to local loopback (for CAPsMAN)" dst-address=127.0.0.1
add action=drop chain=input comment="defconf: drop all not coming from LAN" \
    in-interface-list=!LAN
add action=accept chain=forward comment="defconf: accept in ipsec policy" \
    ipsec-policy=in,ipsec
add action=accept chain=forward comment="defconf: accept out ipsec policy" \
    ipsec-policy=out,ipsec
add action=fasttrack-connection chain=forward comment="defconf: fasttrack" \
    connection-state=established,related hw-offload=yes
add action=accept chain=forward comment=\
    "defconf: accept established,related, untracked" connection-state=\
    established,related,untracked
add action=drop chain=forward comment="defconf: drop invalid" \
    connection-state=invalid
add action=drop chain=forward comment=\
    "defconf: drop all from WAN not DSTNATed" connection-nat-state=!dstnat \
    connection-state=new in-interface-list=WAN
/ip firewall nat
add action=masquerade chain=srcnat comment="defconf: masquerade" \
    ipsec-policy=out,none out-interface-list=WAN
/system clock
set time-zone-name=Europe/Kiev
/system identity
set name=fulcrum.rocks
/system ntp client
set enabled=yes
/system ntp client servers
add address=ntp2.time.in.ua
/tool mac-server
set allowed-interface-list=LAN
/tool mac-server mac-winbox
set allowed-interface-list=LAN
