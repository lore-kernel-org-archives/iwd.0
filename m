Content-Type: multipart/mixed; boundary="===============8663084114253776499=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 1/2] hwsim: allow concurrent radio creations
Date: Tue, 15 Feb 2022 11:16:49 -0800
Message-ID: <556a79f1b541f77dc4a7b147935b216170425b49.camel@gmail.com>
In-Reply-To: f90c8063-e741-cf8d-b83f-bb50b0e9687e@gmail.com

--===============8663084114253776499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> =

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else if (!rec)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return;
> =

> This part seems suspicious.=C2=A0 What if the radio is being created
> outside hwsim?

I guess this is changing behavior... Currently we would still create
the radio info object if the radio was created externally. Keeping this
behavior will end up requiring creating the radio here and in
CreateRadio(), nearly the same as what we had before.

I guess its up to you. Either we don't support external radio creation
for cleaner code, or we go back to the way it was (or some variant of
it).

> =

> > =C2=A0 =

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0l_genl_attr_init(&attr,=
 msg);
> > =C2=A0 =

> =

> Regards,
> -Denis


--===============8663084114253776499==--

