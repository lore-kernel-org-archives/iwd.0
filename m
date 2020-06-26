Content-Type: multipart/mixed; boundary="===============7857764163910924070=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: iwd core dump
Date: Fri, 26 Jun 2020 10:34:07 -0500
Message-ID: <8b6e62da-c44c-ed0e-a200-e70e494017c4@gmail.com>
In-Reply-To: <CAG17S_Pb+3DgdButoT70norbsxKHJNTSBYzHVjTRuuoiddBv-A@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7857764163910924070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

On 6/25/20 5:34 PM, KeithG wrote:
> This is on an Rpi B3+ runint aarch64. I have noticed that, periodically I=
 get =

> disconnected and it doe snot reconnect. I am using connman to manage the =
iwd =

> connection. This is the first time I have seen the crash in the log. It h=
as been =

> crashing and not recovering.
> =

> It gets a Deauth event (I've seen this quite a bit) and usually, it will =
not =

> reconnect until I reboot it and my router. How can I best diagnose this?
> =

> It is iwd 1.7 and connman 1.38. potentially useful excerpts from my journ=
al:
> =

> Jun 17 23:26:58 rune64 kernel: Booting Linux on physical CPU 0x0000000000 =

> [0x410fd034]
> Jun 17 23:26:58 rune64 kernel: Linux version 5.4.44-1-ARCH (alarm(a)build=
rune64) =

> (gcc version 9.3.0 (GCC)) #1 SMP PREEMPT Mon Jun 22 15:13:50 CDT 2020
> Jun 17 23:26:58 rune64 kernel: Machine model: Raspberry Pi 3 Model B Plus=
 Rev 1.3
> ...
> Jun 17 23:26:58 rune64 kernel: raspberrypi-firmware soc:firmware: Attache=
d to =

> firmware from 2020-06-10 17:52, variant start_cd
> Jun 17 23:26:58 rune64 kernel: raspberrypi-firmware soc:firmware: Firmwar=
e hash =

> is e46bba1638cca2708b31b9daf4636770ef981735
> ...
> Jun 17 23:26:59 rune64 kernel: brcmfmac: F1 signature read @0x18000000=3D=
0x15264345
> Jun 17 23:26:59 rune64 kernel: brcmfmac: brcmf_fw_alloc_request: using =

> brcm/brcmfmac43455-sdio for chip BCM4345/6
> Jun 17 23:26:59 rune64 kernel: usbcore: registered new interface driver b=
rcmfmac
> ...
> Jun 17 23:27:00 rune64 kernel: brcmfmac: brcmf_fw_alloc_request: using =

> brcm/brcmfmac43455-sdio for chip BCM4345/6
> Jun 17 23:27:00 rune64 kernel: brcmfmac: brcmf_c_preinit_dcmds: Firmware: =

> BCM4345/6 wl0: Feb 27 2018 03:15:32 version 7.45.154 (r684107 CY) FWID 01=
-4fbe0b04
> ...
> Jun 24 22:28:10 rune64 iwd[261]: Wireless daemon version 1.7
> Jun 24 22:28:10 rune64 iwd[261]: Loaded configuration from /etc/iwd/main.=
conf
> Jun 24 22:28:10 rune64 systemd[1]: Started Wireless service.
> Jun 24 22:28:10 rune64 iwd[261]: netconfig: Network configuration is disa=
bled.
> Jun 24 22:28:10 rune64 iwd[261]: Wiphy: 0, Name: phy0
> Jun 24 22:28:10 rune64 iwd[261]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 Permanent Ad=
dress: b8:27:eb:52:cc:d0
> Jun 24 22:28:10 rune64 iwd[261]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 Bands: 2.4 G=
Hz 5 GHz
> Jun 24 22:28:10 rune64 iwd[261]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ciphers: CCM=
P TKIP BIP
> Jun 24 22:28:10 rune64 iwd[261]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 Supported if=
types: ad-hoc station ap =

> p2p-client p2p-go p2p-device
> Jun 24 22:28:10 rune64 iwd[261]: Wiphy phy0 will only use the default int=
erface
> Jun 24 22:28:11 rune64 iwd[261]: hardware_rekey not supported
> Jun 25 13:40:14 rune64 iwd[261]: Received Deauthentication event, reason:=
 2, =

> from_ap: false

Hmm, this implies the firmware tried to roam.  Does your network have multi=
ple =

APs in the same SSID?

Can you run iwmon and get a trace of this happening?  See =

https://iwd.wiki.kernel.org/debugging for details.

> Jun 25 13:40:14 rune64 iwd[261]: Received error during CMD_TRIGGER_SCAN: =

> Resource temporarily unavailable (11)

Hmm, I suspect we fixed this particular crash in iwd 1.8.  Can you try that?

Regards,
-Denis
--===============7857764163910924070==--

