Content-Type: multipart/mixed; boundary="===============4903217781436493467=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: Re: EAP server tried method 25 while client was configured for method
 26
Date: Thu, 12 May 2022 23:27:27 +0200
Message-ID: <CAOq732L19f1Ci9KzpO0i1iM2uLrCHKSkSb8DzjFVdvDT_t5erw@mail.gmail.com>
In-Reply-To: 0fa43dec-26d2-6515-1b42-8db3bce19bdc@gmail.com

--===============4903217781436493467==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 12 May 2022 at 22:25, Denis Kenzior <denkenz(a)gmail.com> wrote:
> On 5/12/22 06:43, Axel Kittenberger wrote:
> > [Security]
> > EAP-Method=3DPEAP
> > EAP-PEAP-Phase2-Method=3DMSCHAPV2
> > EAP-PEAP-Phase2-Identity=3Dxxx
> > EAP-PEAP-Phase2-Password=3Dxxx
> >
>
> This configuration looks pretty typical for a PEAP+MSCHAPv2.
>
> > produces following iwd output (started on console)
> > ""
> > Wiphy: 0, Name: phy0
> >          Permanent Address: 64:6c:80:ed:91:b9
> >          Bands: 2.4 GHz 5 GHz
> >          Ciphers: CCMP TKIP BIP
> >          Supported iftypes: ad-hoc station ap p2p-client p2p-go p2p-dev=
ice
> > EAP server tried method 25 while client was configured for method 26
>
> This is very strange.  We're configured for MSCHAPv2 (method=3D26) inside=
 the PEAP
> tunnel.  It seems that the server is sending us EAP-PEAP (method=3D25) pa=
ckets
> within the tunnel, which doesn't make sense from what I remember of the p=
rotocol.

I think the Eduroam authenticator is known for non-standard behaviour
when your configuration is not exactly what it expects, and it varies
from site to site.  I notice your config has no phase 1 (outer)
identity, maybe that's confusing it.
https://wiki.archlinux.org/title/Iwd#eduroam has a config example that
worked for some people.

Best regards
--===============4903217781436493467==--

