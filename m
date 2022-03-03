Content-Type: multipart/mixed; boundary="===============7722265159110149552=="
MIME-Version: 1.0
From: Diederik de Haas <didi.debian at cknow.org>
To: iwd at lists.01.org
Subject: Re: [PATCH] knownnetworks: update known frequencies maximum to 7115
Date: Thu, 03 Mar 2022 18:59:53 +0100
Message-ID: <7452861.j3UhPhjJgs@bagend>
In-Reply-To: 20220303172234.3447411-1-prestwoj@gmail.com

--===============7722265159110149552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thursday, 3 March 2022 18:22:34 CET James Prestwood wrote:
> -               if (unlikely(errno =3D=3D ERANGE || !t || t > 6000))
> +               if (unlikely(errno =3D=3D ERANGE || !t || t > 7115))

Sorry if this is a dumb comment, but why use a 'magic number' [1] (which =

meaning can be derived from the git commit comment, but not when just looki=
ng =

at the source)?

1) https://en.wikipedia.org/wiki/Magic_number_(programming)

--===============7722265159110149552==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlIVUVBQllJQUIwV0lRVDFzVVBCWXN5R21p
NHVzeS9YYmx2T2VIN2JiZ1VDWWlFQ0dRQUtDUkRYYmx2T2VIN2IKYm1ycUFRRE4wZWdXVUZpZzhX
dHNqcUxac2JzWkFWaUg1eGp1MjNPd1VNaXZwcGVBalFEN0JxNmlpQllYbDRnVQpWWGhwdVdjYUdC
aVgvb3NaZGF2SjhTZkUxa3NzSkF3PQo9M045OAotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============7722265159110149552==--

