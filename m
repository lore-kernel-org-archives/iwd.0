Content-Type: multipart/mixed; boundary="===============0066873377292297658=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: iwd problems on Arch Linux
Date: Thu, 15 Oct 2020 14:58:04 -0500
Message-ID: <00f42112-bad0-9140-9d33-f94f309fa910@gmail.com>
In-Reply-To: <CAG17S_Ma_2HBuY=yfGi6dyc+yk=ei9hDurgVEOt02ks-=1OFXA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0066873377292297658==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

> These logs contain an SSID off/on and a reconnect event (as desired) then =

> followed immediately with an SSID off/on and a no-reconnect event. I grab=
bed the =

> journal log from iwd and connman and also the pcap in case any/all may be =

> useful. I was able to see content that scrolled by on the screen in the p=
cap =

> with 'iwmon -F 0x17 -r no_reconnect.pcap' (I think you mentioned this pre=
viously).

As I've said before, connman is invoking Station.Disconnect which prevents =
iwd =

from reconnecting autonomously.  There's really nothing we can do about tha=
t. =

Any issues are likely in connman.git/plugins/iwd.c

Can you provide me logs of this scenario without connman (with systemd-netw=
orkd =

or iwd with EnableNetworkConfiguration=3Dtrue).  That I might be able to he=
lp with.

Regards,
-Denis
--===============0066873377292297658==--

