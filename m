Content-Type: multipart/mixed; boundary="===============5313978776534845026=="
MIME-Version: 1.0
From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: Re: Build broken with --enable-external-ell since version 1.13
Date: Tue, 06 Apr 2021 13:06:43 +0200
Message-ID: <CAPi7W827v=7rZ-L=pNyAYVtyxERsvW=uLtFxNP=UPmHpKEMZvA@mail.gmail.com>
In-Reply-To: <43BBA82B-F9E0-45D3-B355-E7FBE0D04231@holtmann.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5313978776534845026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le mar. 6 avr. 2021 =C3=A0 12:28, Marcel Holtmann <marcel@holtmann.org> a=
 =C3=A9crit :
>
> Hi Fabrice,
>
> >>>>> Build is broken with --enable-external-ell since version 1.13 and c=
ommit
> >>>>> ed05585063f2e6d8f2fcd5f008b861062ac7a429:
> >>>>>
> >>>>> make[1]: Entering directory '/home/fabrice/buildroot/output/build/i=
wd-1.13'
> >>>>> GEN      ell/shared
> >>>>> /bin/bash: line 5: ell/shared: No such file or directory
> >>>>>
> >>>>> Moreover, ell/useful.h is a private header of ELL so it shouldn't be
> >>>>> used by iwd.
> >>>>
> >>>> yes, it should be used. That is the intention for this header.
> >>> I'm not sure to fully understand your answer.
> >>> ell/useful.h is defined as a private header by ELL since
> >>> https://git.kernel.org/pub/scm/libs/ell/ell.git/commit/?id=3Dd7e2a556=
b8a53bf5704e822cd9d8d158dc765e22
> >>>
> >>> So this header is not a part of the public API and, as a result, it is
> >>> not installed on the system.
> >>> However, it seems that ELL specifies that this header is "semi-privat=
e" in
> >>> https://git.kernel.org/pub/scm/libs/ell/ell.git/commit/?id=3D2a682421=
b06e41c45098217a686157f576847021
> >>>
> >>> So, does your answer mean that ELL should be patched to install the
> >>> useful.h header (i.e. move useful.h from ell_libell_la_SOURCES to
> >>> pkginclude_HEADERS)?
> >>
> >> it is not a header that is meant to be installed, it is shared header =
that is suppose to be used by ELL and iwd. There however is a bug when usin=
g external ELL. I think this should fix it:
> >>
> >> diff --git a/Makefile.am b/Makefile.am
> >> index 644f3556b43b..68035e46dc80 100644
> >> --- a/Makefile.am
> >> +++ b/Makefile.am
> >> @@ -625,6 +625,7 @@ unit/tls-settings.8021x: unit/cert-ca.pem unit/cer=
t-client.pem unit/cert-client-
> >> BUILT_SOURCES =3D $(ell_built_sources) src/builtin.h
> >>
> >> ell/shared: Makefile
> >> +       $(AM_V_at)$(MKDIR_P) ell
> >>        $(AM_V_GEN)for f in $(ell_shared) ; do \
> >>                if [ ! -f $$f ] ; then \
> >>                        $(LN_S) -t ell -f $(abs_srcdir)/../ell/$$f ; \
> > Thanks for your help, this would fix it if iwd would ship the ell
> > directory however, on buildroot side, we're retrieving iwd through git
> > and as a result, there is no ell directory.
> > The README specifies that you provide tarballs with the ELL directory.
> > Could you tell me what is the official link to retrieve them so I
> > could update buildroot?
>
> the iwd tarballs contain the ELL sources and also ell/useful.h. They are =
available on kernel.org.
Thanks for your help, everything is building perfectly fine with the
official tarball, the above patch is not needed.
>
> Regards
>
> Marcel
>
Best Regards,

Fabrice
--===============5313978776534845026==--

