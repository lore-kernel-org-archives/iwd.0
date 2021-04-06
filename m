Content-Type: multipart/mixed; boundary="===============2238367897991958818=="
MIME-Version: 1.0
From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: Re: Build broken with --enable-external-ell since version 1.13
Date: Tue, 06 Apr 2021 10:58:00 +0200
Message-ID: <CAPi7W81V7VobiP92gsj1y=PGSezz1xHiN+Jrsbdy8ZGV9P24jQ@mail.gmail.com>
In-Reply-To: <5DEE74C2-EAE0-4E84-B993-12B92DFE3598@holtmann.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2238367897991958818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Le mar. 6 avr. 2021 =C3=A0 10:38, Marcel Holtmann <marcel@holtmann.org> a=
 =C3=A9crit :
>
> Hi Fabrice,
>
> > Build is broken with --enable-external-ell since version 1.13 and commit
> > ed05585063f2e6d8f2fcd5f008b861062ac7a429:
> >
> > make[1]: Entering directory '/home/fabrice/buildroot/output/build/iwd-1=
.13'
> >  GEN      ell/shared
> > /bin/bash: line 5: ell/shared: No such file or directory
> >
> > Moreover, ell/useful.h is a private header of ELL so it shouldn't be
> > used by iwd.
>
> yes, it should be used. That is the intention for this header.
I'm not sure to fully understand your answer.
ell/useful.h is defined as a private header by ELL since
https://git.kernel.org/pub/scm/libs/ell/ell.git/commit/?id=3Dd7e2a556b8a53b=
f5704e822cd9d8d158dc765e22

So this header is not a part of the public API and, as a result, it is
not installed on the system.
However, it seems that ELL specifies that this header is "semi-private" in
https://git.kernel.org/pub/scm/libs/ell/ell.git/commit/?id=3D2a682421b06e41=
c45098217a686157f576847021

So, does your answer mean that ELL should be patched to install the
useful.h header (i.e. move useful.h from ell_libell_la_SOURCES to
pkginclude_HEADERS)?
>
> Regards
>
> Marcel
>
Best Regards,

Fabrice
--===============2238367897991958818==--

