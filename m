Content-Type: multipart/mixed; boundary="===============7908887469263428553=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 4/6] ie: parse operating class/channel for
 ie_owe_transition_info
Date: Wed, 22 Sep 2021 12:08:05 -0700
Message-ID: <4236308a55e6d1eaf2b9e30f573abda4ba807f9c.camel@gmail.com>
In-Reply-To: b5378eac-f303-71d7-7581-61cfaae88efc@gmail.com

--===============7908887469263428553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-09-22 at 14:01 -0500, Denis Kenzior wrote:
> Hi James,
> =

> On 9/22/21 1:26 PM, James Prestwood wrote:
> > This operating class/channel is also verified while parsing and
> > parsing will fail if band_oci_frequency fails.
> > =

> > This does put a requirement on anything that uses ie.c to also
> > include band.c. Makefile has been updated.
> > ---
> > =C2=A0 Makefile.am | 16 ++++++++++------
> > =C2=A0 src/ie.c=C2=A0=C2=A0=C2=A0 | 31 ++++++++++++++++++++-----------
> > =C2=A0 src/ie.h=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> > =C2=A0 3 files changed, 32 insertions(+), 17 deletions(-)
> > =

> =

> Can we avoid invoking band_* functions in ie.c?=C2=A0 I'm not sure I want
> to make =

> them dependent on each other since band carries some data structures
> that =

> closely mirror nl80211.
> =

> <snip>
> =

> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (len =3D=3D slen + 15) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0oper_class =3D l_get_u8(ie + 13 + slen);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0channel =3D l_get_u8(ie + 14 + slen);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (oci_to_frequency(oper_class, channel) < 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 -ENOMSG;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =

> Maybe make station or scan itself validate this info?

Ok we can do it in scan when parsing the IE. I wanted to avoid doing it
when scanning (scan_owe_hidden) because it makes the failure logic
annoying, but doing it when parsing the BSS's is fine too.

> =

> Regards,
> -Denis


--===============7908887469263428553==--

