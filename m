Content-Type: multipart/mixed; boundary="===============4622476002852918240=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Restart of iwd.service necessary after boot
Date: Mon, 23 Dec 2019 12:22:19 -0600
Message-ID: <d3cc7c38-e2b7-1c64-b126-873f81a2cbcb@gmail.com>
In-Reply-To: <5922fd21-d5d1-12ff-faec-ba5627b809aa@metacode.biz>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4622476002852918240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Wiktor,

On 12/22/19 3:09 PM, Wiktor Kwapisiewicz wrote:
> Hello,
> =

> I'm using iwd on ArchLinux as a systemd service with conjunction with =

> systemd-networkd and generally it works very well (iwctl live updates =

> are impressive) with a minor annoyance that the service requires restart =

> after each boot to function.
> =


Glad you like it!

> This issue have been reported by others on ArchLinux site:
> https://bugs.archlinux.org/task/63912
> =

> In the service logs the only significant line seems to be "NEW_INTERFACE =

> failed: Device or resource busy":
> =

> $ journalctl -u iwd
>  =C2=A0 Starting Wireless service...
>  =C2=A0 Wireless daemon version 1.4
>  =C2=A0 Started Wireless service.
>  =C2=A0 netconfig: Network configuration is disabled.
>  =C2=A0 Wiphy: 0, Name: phy0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Permanent Address: 30:5=
2:cb:84:72:ff
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bands: 2.4 GHz 5 GHz
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ciphers: CCMP TKIP BIP
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Supported iftypes: ad-h=
oc station ap p2p-client p2p-go p2p-device
>  =C2=A0 NEW_INTERFACE failed: Device or resource busy
> =


Curious how you get here without a DEL_INTERFACE also failing.  Any =

chance you can run iwmon (start it prior to iwd) and give us a trace of =

the output?  See [0] for details.

I'm not a systemd user, but maybe someone here can give you hints on how =

to accomplish this.

> networkctl reports "configuring" but nothing ever happens:
> =

> $ networkctl
> IDX LINK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TYPE=C2=A0=C2=A0=C2=A0=
=C2=A0 OPERATIONAL SETUP
>  =C2=A0 1 lo=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loopba=
ck carrier=C2=A0=C2=A0=C2=A0=C2=A0 unmanaged
>  =C2=A0 2 wlan0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wlan=C2=A0=C2=A0=C2=
=A0=C2=A0 no-carrier=C2=A0 configuring
>  =C2=A0 3 enp10s0u2u4 ether=C2=A0=C2=A0=C2=A0 no-carrier=C2=A0 configuring
>  =C2=A0 4 enp9s0u1u2=C2=A0 ether=C2=A0=C2=A0=C2=A0 no-carrier=C2=A0 confi=
guring
> =


Given the above error, this is expected.

> After service restart it does complain about "unknown error" but =

> everything works as normal:
> =

>  =C2=A0 Wireless daemon version 1.4
>  =C2=A0 Started Wireless service.
>  =C2=A0 netconfig: Network configuration is disabled.
>  =C2=A0 Wiphy: 0, Name: phy0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Permanent Address: 30:52:cb:8=
4:72:ff
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bands: 2.4 GHz 5 GHz
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ciphers: CCMP TKIP BIP
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Supported iftypes: ad-hoc sta=
tion ap p2p-client p2p-go p2p-device
>  =C2=A0 DEL_INTERFACE failed: Unknown error 524

So this is -ENOTSUPP.  What is a little strange is that you don't get =

this error at startup unless you put in a sleep as you mention below.

>  =C2=A0 hardware_rekey not supported
> =

> And it is routable in networkctl:
> =

> $ networkctl
> IDX LINK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TYPE=C2=A0=C2=A0=C2=A0=
=C2=A0 OPERATIONAL SETUP
>  =C2=A0 1 lo=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loopba=
ck carrier=C2=A0=C2=A0=C2=A0=C2=A0 unmanaged
>  =C2=A0 2 wlan0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wlan=C2=A0=C2=A0=C2=
=A0=C2=A0 routable=C2=A0=C2=A0=C2=A0 configured
>  =C2=A0 3 enp10s0u2u4 ether=C2=A0=C2=A0=C2=A0 no-carrier=C2=A0 configuring
>  =C2=A0 4 enp9s0u1u2=C2=A0 ether=C2=A0=C2=A0=C2=A0 no-carrier=C2=A0 confi=
guring
> =

> Interestingly one of ArchLinux users [0] reported that adding sleep in =

> "ExecStartPre" of the systemd service makes the problem disappear and =

> yes, this workaround also works on my end.
> =

> I did not have this problem when using old wpa_supplicant. I'm using XPS =

> 13 (9350, Broadcom BCM4350). I had the problem since I installed iwd and =

> it's still here in version 1.4

wpa_supplicant doesn't use these operations for the most part.  As a =

consequence, the kernel folks only tested them via the 'iw' command line =

utility and some drivers might not even implement this properly.  See =

[1] for details of what iwd does.

> =

> Is there a way to debug this issue further?
> =


For now, try this simple workaround:

diff --git a/src/manager.c b/src/manager.c
index 47874e1129b8..ac2af7889a3c 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -79,6 +79,7 @@ static const char *default_if_driver_list[] =3D {
         "rtl87*",
         "rtl88*",
         "rtw_*",
+       "brcmfmac",

         NULL,
  };

Or alternatively set
UseDefaultInterface=3Dtrue in main.conf.  See man iwd.config for details.

[0] https://iwd.wiki.kernel.org/debugging
[1] https://iwd.wiki.kernel.org/interface_lifecycle

Regards,
-Denis
--===============4622476002852918240==--

