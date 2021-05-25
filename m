Content-Type: multipart/mixed; boundary="===============1161085306888116203=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: How to NAT when using iwd ap mode?
Date: Tue, 25 May 2021 12:21:36 -0500
Message-ID: <CAG17S_N4pXpMTj+HKGXV9HGc99fYbUDP7_27_Qv4wKBbW6Vm_w@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1161085306888116203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I have been trying to get ap mode to NAT and am unsuccessful. Is this possi=
ble?

I can get AP mode to work with this in /etc/iwd/main.conf

and I can get an IP address associated and I can connect to the
computer running iwd in ap mode. What I cannot do is NAT the wifi
connected device to the eth0 which has a valid connection.

[General]
UseDefaultInterface=3Dtrue
EnableNetworkConfiguration=3Dtrue
APRanges=3D192.168.5.0/24

After I get my AP running and connect, I tried to run these commands
to enable NAT:

# sysctl net.ipv4.ip_forward=3D1
# iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
# iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
# iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT

When I try this, I get no 'internet' traffic from eth0.

Is this due to dns? Do I need to use iptables to NAT this?

When I run connman in tether mode it works. I can connect and I get
internet traffic over wlan connected devices. When I have iwd running
in AP mode, though, I cannot figure out how to share the eth0
connection to the wifi connected device(s).

Is there a guide on how to use the ap.iwd provisioning file? I am not
clear on how to use it. I created a file: /etc/iwd/ap.iwd and it does
not seem to use it. Where do you set the hostname?

Keith
--===============1161085306888116203==--

