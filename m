Content-Type: multipart/mixed; boundary="===============3278005359139325782=="
MIME-Version: 1.0
From: Patrick =?unknown-8bit?q?H=C3=A4cker?= <pat_h@web.de>
Subject: Re: iwd not connecting on Raspberry Pi with Raspbian
Date: Sun, 30 Aug 2020 15:38:11 +0200
Message-ID: <6679878.YKXMNv7jBj@mmm>
In-Reply-To: <7c63237c-ebea-7df2-f792-c589266046e9@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3278005359139325782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

thanks for the answer!

> This is a brcmfmac card right?  We have seen some weirdness with brcmfmac
> where it simply refuses to perform the handshake (which is what is
> happening in your case).  The handshake times out (reason: 15 =3D
> MMPDU_REASON_CODE_4WAY_HANDSHAKE_TIMEOUT).
> =

> The strange part is that it does work in other setups and it seems to be a
> combination of AP or some other weird factor that screws this up.  Have y=
ou
> tried different brcmfmac firmware versions?
Yes, it's a brcmfmac card. I speculate, that it had some state, which iwd d=
id =

not expect due to booting up with wpa_supplicant and only switching to iwd =

afterwards (it worked after I removed wpa_supplicant and rebooted).

Therefore I did not try different brcmfmac firmware versions. I am probably =

using this firmware:
> brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43455-sdio for chip
>     BCM4345/6=00
> brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0: Mar 23 2020
>     02:19:54 version 7.45.206 (r725000 CY) FWID 01-88ee44ea=00

> >> src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
> >> src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for
> >> =

> >>      (global) is DE
> =

> Seems like the kernel is switching the regulatory domain here, right after
> we try to connect.  I wonder if you can use iw to set this prior to
> triggering the connection with iwd.  Does anything change?
Actually, the reg domain is set before to the correct value (DE in my case,=
 I =

have double-checked that, when I saw the message in the logs). I am not sur=
e =

why it's switching.  I am on channel 13, so with an US/default reg domain I =

couldn't access the 2-GHz-Wi-Fi.

> >> src/netdev.c:netdev_link_notify() event 16 on ifindex 3
> >> src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
> >> src/netdev.c:netdev_disconnect_event()
> >> Received Deauthentication event, reason: 2, from_ap: false
> =

> And here we see the firmware using an incorrect password somehow and
> triggering a disconnect by itself, without iwd's input.  I think James had
> the exact same issue on RPI4, and we determined that the firmware/driver
> was just borked...
The provided password was definitely correct, as it's provided by a file an=
d =

working now without being changed in between. But it might be, that the =

firmware/driver ended up with a wrong authentication somehow, although the =

correct password was provided.

> >> src/station.c:station_disconnect_event() 3
> >> src/station.c:station_disassociated() 3
> >> src/station.c:station_enter_state() Old State: connecting, new state:
> >> disconnected >
> > =

> > I could imagine, that there is still a kernel module missing, but this =
is
> > just guessing. Any hints how to continue debugging?
> =

> This is a driver / firmware problem.  You say that wpa_s works correctly. =

> Can you capture iwmon traces of both wpa_s and iwd trying to connect to t=
he
> same AP and share that with us?
I wanted to use iwmon already before. Unfortunately, it does not work on th=
is =

system:
> Wireless monitor ver 1.8
> Failed to create monitor interface nlmon: Unknown error -95=00
There is (to me) no obvious error in its strace, but I am omitting it here,=
 as =

it is probably a separate issue and I=E2=80=82am not sure if anyone is inte=
rested in =

solving that problem.

So where to go from here on? The principle issue (iwd in Raspbian) is solve=
d. =

But if someone is interested to find and fix the root cause to avoid the =

removing/rebooting procedure on the Raspberry Pi in the future, I can assis=
t =

with this (although my time is limited mostly to weekends).
My gut feeling is, that we need to fix that issue before suggesting to have=
 iwd =

as default on a Raspberry.

Kind regards
Patrick

--===============3278005359139325782==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSXpCQUFCQ2dBZEZpRUU4Sm9qVkkrY0ZY
MWsxRTdZSEdndTErVEpCZUFGQWw5THE4TUFDZ2tRSEdndTErVEoKQmVBNmFCQUFnbzFJcDZncHpv
R2NSbS9kUjdTZHZiTFFvVWVuNXYvRFB4eFNnaXpsb1lSY2ZlbTllQ0taQk5OSgpiMk9LUUhEN3Jn
ellBdVE3UktGdysrZGVUU1lxb0ZVZjVRalFzZ3BrWExpRFo5OWlHd1pyVlRTTXJhU2JnbjlrClZr
Z3FmSE9FNkwzazhlZlJ6eGREUG10RUk0cmpJTG5JSlFLNGVTbkZBMEpFVlZXbVppeHYxc1VlTkl5
WkdIdWsKVXVZczE0N0NDTGpkZTI3eS93NXR5aHk0RC9QczcrQ3hwcXNjMUkwQXhFeVRvYncyT2xt
RDVBVnIvQzZYOXF4TwpjWjlEK2xCUmd4Y0lCSUFNcXl2V21wSHIyZkdvVEJ4ZERtUUZhNnhqZXJR
UExXSUdnWnFrVVNWYmo3Uk41Y1hnClJNQlk4QmN1N053NzBKbVRMWVAvaG5vMjFTSUxrZmdPc25L
OGUzeUcycGp0T1ZvdmRFQ1BGUUdFc05DdTV3d1gKcUIwNExUTElWalllVGdJTlY1ZWhJWW1QZGRG
aTdCNlZEWlNWV3lUS055b3FNVXNGR1Q3QVo1dm5MbmFpQ1V5QQpXcHpWWFJibGRWVGFUUlNXWjNk
Z1ZlUUFtZnc3aHBjeTd2TzVZaFZZQkkzNHorcUxubTRjbzVnMTVtTDBmUkpTCjVrdVJMbzhkV2J6
K1NueUU4REdRK3BreTM4ZWxVZ05PUFIxcFAzNVVZenVIbWFrbWhKTW1OZ1RGOGtCcmhpYlUKYldk
elVvMGhtUnZnelYyakREU1FwMUpXZjUxWU4wNmtOWGQwM0dCSG5kbXMvWjFtR0huaWZIcGE5SlBG
SkpTSApxbk5oTENtdFRRdWo2L3dIaHpROS9DeGx0aFI3cGNVSFROY2pCVTFnWnNPZ2hydnMzYkU9
Cj1HY3M2Ci0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--===============3278005359139325782==--

