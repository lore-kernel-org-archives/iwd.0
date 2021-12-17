Content-Type: multipart/mixed; boundary="===============2868032264374374840=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v5 2/4] dpp: add DPP authentication protocol
Date: Fri, 17 Dec 2021 13:18:27 -0800
Message-ID: <6ea1aebc624f897449727625746a8b5f709f43cf.camel@gmail.com>
In-Reply-To: a2bfc724-dfb8-8c75-7f05-1ee6523b48ad@gmail.com

--===============2868032264374374840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-12-17 at 14:19 -0600, Denis Kenzior wrote:
> Hi James,
> =

> On 12/17/21 13:14, James Prestwood wrote:
> > This implements the DPP protocol used to authenticate to a
> > DPP configurator.
> > =

> > Note this is not a full implementation of the protocol and
> > there are a few missing features which will be added as
> > needed:
> > =

> > =C2=A0 - Mutual authentication (needed for BLE bootstrapping)
> > =C2=A0 - Configurator support
> > =C2=A0 - Initiator role
> > ---
> > =C2=A0 src/dpp.c | 491
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > =C2=A0 1 file changed, 491 insertions(+)
> > =

> > v5:
> > =C2=A0 * Updated use of wrap/unwrap APIs.
> > =C2=A0 * Better commented how AAD is used with wrapping/unwrapping
> > =

> =

> <snip>
> =

> > +static void dpp_free_auth_data(struct dpp_sm *dpp)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (dpp->proto_public) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0l_ecc_point_free(dpp->proto_public);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0dpp->proto_public =3D NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (dpp->proto_private) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0l_ecc_scalar_free(dpp->proto_private);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0dpp->proto_private =3D NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (dpp->i_proto_public) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0l_ecc_point_free(dpp->i_proto_public);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0dpp->i_proto_public =3D NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =

> Should we be paranoid and explicit_bzero the nonces and keys?

Yes, for keys/nonces we can do this. I'm thinking we should also add
explicit_bzero to the l_ecc_point_free, as well as for scalars.

> =

> Applied, thanks.
> =

> Regards,
> -Denis


--===============2868032264374374840==--

