Content-Type: multipart/mixed; boundary="===============2306516580921968371=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] knownnetworks: update known frequencies maximum to 7115
Date: Thu, 03 Mar 2022 12:23:07 -0800
Message-ID: <95e6332cce4340c0db255465ad6b43c513de44ed.camel@gmail.com>
In-Reply-To: 7452861.j3UhPhjJgs@bagend

--===============2306516580921968371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2022-03-03 at 18:59 +0100, Diederik de Haas wrote:
> On Thursday, 3 March 2022 18:22:34 CET James Prestwood wrote:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (unlikely(errno =3D=3D ERANGE || !t || t > 6000))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (unlikely(errno =3D=3D ERANGE || !t || t > 7115))
> =

> Sorry if this is a dumb comment, but why use a 'magic number' [1]
> (which =

> meaning can be derived from the git commit comment, but not when just
> looking =

> at the source)?

I'm not sure if we have a style/rule about this but I think generally
if the value is only used once, and its clear what it is, a macro may
not be required.

*waits for angry mob*

Denis' recommendation solves a few potential issues in addition to just
updating, including the hard coded value.

> =

> 1) https://en.wikipedia.org/wiki/Magic_number_(programming)


--===============2306516580921968371==--

