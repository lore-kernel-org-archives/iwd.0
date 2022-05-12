Content-Type: multipart/mixed; boundary="===============2025145165096889069=="
MIME-Version: 1.0
From: Axel Kittenberger <axel.kittenberger at univie.ac.at>
To: iwd at lists.01.org
Subject: EAP server tried method 25 while client was configured for method 26
Date: Thu, 12 May 2022 13:43:52 +0200
Message-ID: <6fc4a1a0c9cea52a46c5645cc33c2036@univie.ac.at>

--===============2025145165096889069==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello, I can't get iwd to connect to a 802.1x (university) network.

$ cat /var/lib/iwd/eduroam.8021x
[Security]
EAP-Method=3DPEAP
EAP-PEAP-Phase2-Method=3DMSCHAPV2
EAP-PEAP-Phase2-Identity=3Dxxx
EAP-PEAP-Phase2-Password=3Dxxx

produces following iwd output (started on console)
""
Wiphy: 0, Name: phy0
         Permanent Address: 64:6c:80:ed:91:b9
         Bands: 2.4 GHz 5 GHz
         Ciphers: CCMP TKIP BIP
         Supported iftypes: ad-hoc station ap p2p-client p2p-go =

p2p-device
EAP server tried method 25 while client was configured for method 26
PEAP: Tunnel has disconnected with alert: close_notify
""

I'm out of idead what method 25 vs. method 26 is, both are MS something, =

and it really should be PEAP/MSCHAPV2 at least thats what always works =

on all other configurations.

Network Manager in background, debian bullseye,

cat /proc/version
Linux version 5.10.0-14-amd64 (debian-kernel(a)lists.debian.org) (gcc-10 =

(Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) =

2.35.2) #1 SMP Debian 5.10.113-1 (2022-04-29)

/usr/libexec/iwd --version
1.14

Kind regards, Axel

--===============2025145165096889069==--

