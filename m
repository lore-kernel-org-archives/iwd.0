Content-Type: multipart/mixed; boundary="===============8763036325845478833=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 7/7] doc: document access point scanning
Date: Wed, 23 Feb 2022 12:18:37 -0800
Message-ID: <0a7e98fa25f2cd087ccb36c53980dc6c195a29f3.camel@gmail.com>
In-Reply-To: db615d8d-a416-e3d2-ec7f-80ffdc5d1ead@gmail.com

--===============8763036325845478833==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2022-02-23 at 12:43 -0600, Denis Kenzior wrote:
> Hi James,
> =

> On 2/22/22 16:57, James Prestwood wrote:
> > ---
> > =C2=A0 doc/access-point-api.txt | 27 +++++++++++++++++++++++++++
> > =C2=A0 1 file changed, 27 insertions(+)
> > =

> =

> <snip>
> =

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0array(dict) GetOrderedNetworks()
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Gets t=
he list of networks found after
> > scanning sorted
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0based =
on signal strength. Each item in the
> > array is a
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dictio=
nary containing the network Name,
> > SignalStrength,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0and Se=
curity.
> =

> Security -> Type to be consistent with KnownNetwork / Network
> interface naming =

> of the properties.
> =

> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0This l=
ist will expire similarly to station,
> > and since
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0access=
 points do not do periodic scans the
> > list may
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0become=
 empty after some time and requires
> > scanning
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0again.
> =

> I'm not sure what this is about?=C2=A0 Scan results don't actually expire
> in Station =

> in the sense that you can keep calling GetOrderedNetworks() forever
> and get the =

> same results, as long as scanning hasn't been performed.=C2=A0 Essentially
> if =

> Scanning hasn't changed, GetOrderedNetworks() results shouldn't
> change either.

You're right, I was mis-remembering how the expiration works. Since
station does periodic scan the BSS's get thrown out for each scan which
is what I was somewhat trying to mirror here. But as far as
GetOrderedNetworks goes it just takes the current list, however old it
is.

> =

> I would expect the same behavior here?

Sure I can remove the expiration stuff from the core patch and leave it
up to the caller to make sure they get the networks promptly after
scanning is finished.

> =

> Regards,
> -Denis


--===============8763036325845478833==--

