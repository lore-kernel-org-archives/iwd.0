Content-Type: multipart/mixed; boundary="===============8047855231652552848=="
MIME-Version: 1.0
From: 58e33db1-f428-4823-8cc3-d962d0fb8aa8 at slmail.me
To: iwd at lists.01.org
Subject: iwd 1.18 doesn't connect to network on boot
Date: Thu, 23 Sep 2021 11:04:32 +0000
Message-ID: <163239507223.7.15396824044509805482.14044955@slmail.me>

--===============8047855231652552848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I'm on Arch Linux and after recent iwd upgrade to version 1.18 I'm no longe=
r connected to my home network when booting. Previous version works just fi=
ne. I've managed to workaround the issue simply by going to iwctl and manua=
lly doing disconnect/connect every time I boot the computer.

Before doing this iwctl reports 'connecting' state indefinitely. Network co=
verage is always good. I have the laptop sitting on a table very close to t=
he router and AFAIK, it didn't receive any firmware upgrade recently.

A little bit more of context in case it helps:

/etc/iwd/main.conf
[General]
EnableNetworkConfiguration=3Dtrue
AddressRandomization=3Dnetwork

[Network]
NameResolvingService=3Dresolvconf

iwevent
Waiting for Wireless Events from interfaces...
10:10:55.646290 wlan0 Scan request completed
10:10:57.801675 wlan0 Scan request completed
10:10:58.106493 wlan0 New Access Point/Cell address:Not-Associated =3D> thi=
s is the disconnect
10:11:31.786703 wlan0 Scan request completed
10:11:31.871341 wlan0 Association Request IEs:xxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxx
10:11:31.871401 wlan0 Association Response IEs:xxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxx
10:11:31.871436 wlan0 New Access Point/Cell address:xx:xx:xx:xx:xx:xx

Distro mantainers just upgraded to latest upstream release, without any oth=
er modification on PKGBUILD.

https://github.com/archlinux/svntogit-community/blob/9b59977cbb8eb2ffe42ab6=
13b033efa21c36c053/trunk/PKGBUILD


Thanks for helping!
--
Jason


--===============8047855231652552848==--

