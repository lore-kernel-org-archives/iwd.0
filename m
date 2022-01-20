Content-Type: multipart/mixed; boundary="===============6144685556223790230=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 02/12] dpp-util: add dpp_point_from_asn1()
Date: Thu, 20 Jan 2022 15:13:09 -0800
Message-ID: <93832ad490885f1f8e86c5c938936bb0ab606e20.camel@gmail.com>
In-Reply-To: bfbe6420-c777-a368-8bb2-1c7776bec48b@gmail.com

--===============6144685556223790230==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2022-01-20 at 14:10 -0600, Denis Kenzior wrote:
> Hi James,
> =

> On 1/18/22 15:25, James Prestwood wrote:
> > Given an ASN1 blob of the right form, parse and create
> > an l_ecc_point object. The form used is specific to DPP
> > hence why this isn't general purpose and put into dpp-util.
> > ---
> > =C2=A0 src/dpp-util.c | 69
> > ++++++++++++++++++++++++++++++++++++++++++++++++++
> > =C2=A0 src/dpp-util.h |=C2=A0 1 +
> > =C2=A0 2 files changed, 70 insertions(+)
> > =

> =

> <snip>
> =

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* BITSTRING */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0key_data =3D asn1_der_find_e=
lem(outer_seq, outer_len, 1,
> > &tag, &elen);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!key_data || tag !=3D AS=
N1_ID_BIT_STRING || elen < 34)
> =

> Why 34? Aren't you only concerned that elen >=3D 2?

Yes, thats right.

> =

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return NULL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0curve =3D l_ecc_curve_from_i=
ke_group(curve_num);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!curve)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return NULL;
> =

> Perhaps this check should be moved up?
> =

> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return l_ecc_point_from_data=
(curve, key_data[1],
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0key_data + 2, elen - 2);
> =

> Aren't you relying on ecc_point_from_data to validate the length?=C2=A0
> Hence the =

> unnecessary '34' magic number above?
> =

> Should ecc_point_from_data also validate that all of the data passed
> in was =

> consumed?=C2=A0 Or maybe return the number of bytes consumed so that we
> can validate =

> it here?

I think changing point_from_data to require a strict length is fine,
and probably the best route. Only other way would be to manually check
before calling it.

> =

> Regards,
> -Denis


--===============6144685556223790230==--

