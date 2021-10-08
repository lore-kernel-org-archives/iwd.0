Content-Type: multipart/mixed; boundary="===============4773310137110971479=="
MIME-Version: 1.0
From: Michael Nazzareno Trimarchi <michael at amarulasolutions.com>
To: iwd at lists.01.org
Subject: Re: iwd access point mode
Date: Fri, 08 Oct 2021 17:23:12 +0200
Message-ID: <CAOf5uwnuGdxHVriSBEeS=UMOSRf_4RksbqbMKLoM8cOP5fUObw@mail.gmail.com>
In-Reply-To: e5efb7a7-8c5d-2955-5e1c-441f4da5fbce@gmail.com

--===============4773310137110971479==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Oct 8, 2021 at 4:58 PM Denis Kenzior <denkenz(a)gmail.com> wrote:
>
> Hi Michael,
>
> On 10/7/21 2:48 PM, Michael Nazzareno Trimarchi wrote:
> > HI all
> >
> > I'm playing with iwd. Looking at iwmon I can see virtual device
> > discovered by iwd when they are created.
> >
> > iw phy phy0 interface add wlan1 __ap
> >
> > iwctl still report wlan0
> >
>
> Right.  Since most people want to use iwd + hostapd for such tethering ca=
ses, we
> made the decision to simply ignore any new devices created outside iwd af=
ter a
> wiphy has been initialized.

Ok, I think that iwd as interface is more easy to use then hostapd and havi=
ng
one service is much more easy to work with.

>
> You can get around this by creating the sta + ap devices first, then star=
ting
> iwd.  You'll need to set UseDefaultInterface=3Dtrue in /etc/iwd/main.conf=
.  See
> 'man 5 iwd.config' for more details.

Very good

>
> >   I was able to create wifi connection and access point mode using
> > wpa_supplicant and NetworkManager. My idea
> > is was experimenting iwd
> >
> > iwctl device list still report only wlan1. The idea behind is to
> > control ap+sta interface. Any feedback?
> >
>
> Teaching iwd to create STA + AP interfaces when it initializes an adapter=
 is on
> the TODO list.  We already do this with P2P, but not STA + AP.  This shou=
ld be
> fairly easy to do, but we have been busy with other tasks.  Patches are a=
lways
> welcome!
>
> Our (preliminary) thinking on this was to add a main.conf entry that tell=
s iwd
> how it should manage wiphys by default.  Something like: "sta-only", "sta=
+p2p",
> "sta+ap".  Based on the configured setting, iwd would then create the int=
erfaces

I think that this the best is to extend the mode and add Mode =3D sta+ap

> automagically (assuming hardware/driver supports it,  falling back to "st=
a-only"
> if not).

Some hardware has the limitation to use only one channel
in this configuration. The idea is to able to decide to go on not go
in this configuration using dbus

Michael

>
> Regards,
> -Denis



-- =

Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael(a)amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info(a)amarulasolutions.com
www.amarulasolutions.com
--===============4773310137110971479==--

