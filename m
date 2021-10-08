Content-Type: multipart/mixed; boundary="===============0588533481728353551=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd access point mode
Date: Fri, 08 Oct 2021 09:45:14 -0500
Message-ID: <e5efb7a7-8c5d-2955-5e1c-441f4da5fbce@gmail.com>
In-Reply-To: CAOf5uwk5RkWEOuOsWTyFynQRsnWBHx8nByOzew283YHNanQQTg@mail.gmail.com

--===============0588533481728353551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 10/7/21 2:48 PM, Michael Nazzareno Trimarchi wrote:
> HI all
> =

> I'm playing with iwd. Looking at iwmon I can see virtual device
> discovered by iwd when they are created.
> =

> iw phy phy0 interface add wlan1 __ap
> =

> iwctl still report wlan0
> =


Right.  Since most people want to use iwd + hostapd for such tethering case=
s, we =

made the decision to simply ignore any new devices created outside iwd afte=
r a =

wiphy has been initialized.

You can get around this by creating the sta + ap devices first, then starti=
ng =

iwd.  You'll need to set UseDefaultInterface=3Dtrue in /etc/iwd/main.conf. =
 See =

'man 5 iwd.config' for more details.

>   I was able to create wifi connection and access point mode using
> wpa_supplicant and NetworkManager. My idea
> is was experimenting iwd
> =

> iwctl device list still report only wlan1. The idea behind is to
> control ap+sta interface. Any feedback?
> =


Teaching iwd to create STA + AP interfaces when it initializes an adapter i=
s on =

the TODO list.  We already do this with P2P, but not STA + AP.  This should=
 be =

fairly easy to do, but we have been busy with other tasks.  Patches are alw=
ays =

welcome!

Our (preliminary) thinking on this was to add a main.conf entry that tells =
iwd =

how it should manage wiphys by default.  Something like: "sta-only", "sta+p=
2p", =

"sta+ap".  Based on the configured setting, iwd would then create the inter=
faces =

automagically (assuming hardware/driver supports it,  falling back to "sta-=
only" =

if not).

Regards,
-Denis
--===============0588533481728353551==--

