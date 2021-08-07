Content-Type: multipart/mixed; boundary="===============0562314338125649928=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Nat now fails to work
Date: Sat, 07 Aug 2021 15:48:47 -0500
Message-ID: <CAG17S_O9rP8FqOJdOc6U3rD=w6NN3Bon-jZ2JTBqozMkDD5RUQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0562314338125649928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Group,

I used this page Denis made:
https://iwd.wiki.kernel.org/ap_mode

This is on a RPI3B, but I have seen it on a rpi1 with a dongle. I
really do not think it is iwd, but I cannot figure out why it will not
NAT. When I connect my phone or laptop, it always says 'connected, no
internet'

My /etc/iwd/main.conf
[General]
UseDefaultInterface=3Dtrue
EnableNetworkConfiguration=3Dtrue
[IPv4]
APAddressPool=3D192.168.5.0/24

My /var/lib/iwd/ap/ssid.ap
[Security]
Passphrase=3DRuneAudio
[IPv4]
Address=3D192.168.5.1
Gateway=3D192.168.5.1
Netmask=3D255.255.255.0
DNSList=3D192.168.5.1

To NAT, I execute:
iptables -t nat -A POSTROUTING -s 192.168.5.0/24 -j MASQUERADE
sysctl net.ipv4.ip_forward=3D1

and it appears forwarding is enabled:
# cat /proc/sys/net/ipv4/ip_forward
1
# iptables -t nat -L -n -v
Chain PREROUTING (policy ACCEPT 1426 packets, 151K bytes)
 pkts bytes target     prot opt in     out     source               destina=
tion

Chain INPUT (policy ACCEPT 1192 packets, 139K bytes)
 pkts bytes target     prot opt in     out     source               destina=
tion

Chain OUTPUT (policy ACCEPT 4060 packets, 1606K bytes)
 pkts bytes target     prot opt in     out     source               destina=
tion

Chain POSTROUTING (policy ACCEPT 4031 packets, 1600K bytes)
 pkts bytes target     prot opt in     out     source               destina=
tion
   29  5599 MASQUERADE  all  --  *      *       192.168.5.0/24       0.0.0.=
0/0

When I connect to it from my laptop, windows sees this:
Wireless LAN adapter Wi-Fi:

   Connection-specific DNS Suffix  . :
   Description . . . . . . . . . . . : Intel(R) Wireless-AC 9560 160MHz
   Physical Address. . . . . . . . . : 60-F2-62-AE-70-FE
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes
   Link-local IPv6 Address . . . . . : fe80::dc8d:27f1:52c2:5b0f%10(Preferr=
ed)
   IPv4 Address. . . . . . . . . . . : 192.168.5.3(Preferred)
   Subnet Mask . . . . . . . . . . . : 255.255.255.0
   Lease Obtained. . . . . . . . . . : Saturday, August 7, 2021 3:42:53 PM
   Lease Expires . . . . . . . . . . : Saturday, August 7, 2021 11:42:53 PM
   Default Gateway . . . . . . . . . : 192.168.5.1
   DHCP Server . . . . . . . . . . . : 192.168.5.1
   DHCPv6 IAID . . . . . . . . . . . : 90239586
   DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-25-7E-CD-22-34-48-ED-06-=
F5-9A
   DNS Servers . . . . . . . . . . . : 192.168.5.1
   NetBIOS over Tcpip. . . . . . . . : Enabled

but also no internet

What am I missing?
--===============0562314338125649928==--

