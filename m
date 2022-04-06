Content-Type: multipart/mixed; boundary="===============1686564341401593114=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: Re: segfault in parse_neighbor_report at src/station.c:1747
Date: Wed, 06 Apr 2022 17:44:59 +0200
Message-ID: <CAOq732LR9Lw3ED4DtgrpVfmZ3wvpn4O7NNCJdev+axia9aUiwg@mail.gmail.com>
In-Reply-To: 1e259b78-1dc7-36c4-6c6f-8efe28ee1050@gmail.com

--===============1686564341401593114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 5 Apr 2022 at 20:32, Denis Kenzior <denkenz(a)gmail.com> wrote:
> On 4/5/22 12:35, Leonard Lausen wrote:
> > % iwctl station wlan0 show
> > Station: wlan0
> > -----------------------------------------------------------------------=
---------
> > Settable Property Value
> > -----------------------------------------------------------------------=
---------
> > Scanning no
> > State disconnected
> >
>
> interesting that you have 'wlan0' here, but 'wlp58s0' in your NM configur=
ation.
>   I suspect NM isn't using iwd at all.
>
> Anyway, this confirms iwd thinks it is not connected, which means that...
>
> >> I'm confused why the AP is even sending this. Maybe the kernel crash y=
ou reported is confusing
> >> everything.
> >
> > The kernel crash should be unrelated. I rebooted and verified the iwctl=
 station
> > wlan0 show output remains the same. I'm using NetworkManager with iwd b=
ackend
> > and NetworkManager does show me as connected. Maybe that is related?
> >
>
> NM probably starts up wpa_s to manage the connection.
>
> > % sudo cat /etc/NetworkManager/conf.d/backend.conf
> > [device]
> > match-device=3Dwlp58s0
>
> I'm not sure this directive is actually supported by the iwd backend.

FTR this sounds right.  NM calls a "factory class" for each netdev on
the system.  This looks up the backend for that specific device name
("wlan0"), which would return empty and so fall back to
wpa_supplicant.  It would auto-activate wpa_supplicant and not
activate IWD.

But, if IWD is started by NM for another device on the system, or like
Leonard asserts is auto-activated by iwctl, IWD will try to manage all
wifi devices by default and will be trying to run autoconnect on
wlan0.

In theory "match-device=3D" could be used on a system with NM+IWD if IWD
is configured to not manage the remaining devices, that would also
prevent IWD from recreating the virtual interfaces (usually with a new
name) and confusing NM's lookups by name.  But generally there's
little point using "match-device=3D" with "wifi.backend=3D".

Best regards
--===============1686564341401593114==--

