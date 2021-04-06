Content-Type: multipart/mixed; boundary="===============5711946641885757197=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Build broken with --enable-external-ell since version 1.13
Date: Tue, 06 Apr 2021 11:02:45 +0200
Message-ID: <CF2B2F74-37AB-4BA6-B1B5-6E71D898A0C3@holtmann.org>
In-Reply-To: <CAPi7W81V7VobiP92gsj1y=PGSezz1xHiN+Jrsbdy8ZGV9P24jQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5711946641885757197==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fabrice,

>>> Build is broken with --enable-external-ell since version 1.13 and commit
>>> ed05585063f2e6d8f2fcd5f008b861062ac7a429:
>>> =

>>> make[1]: Entering directory '/home/fabrice/buildroot/output/build/iwd-1=
.13'
>>> GEN      ell/shared
>>> /bin/bash: line 5: ell/shared: No such file or directory
>>> =

>>> Moreover, ell/useful.h is a private header of ELL so it shouldn't be
>>> used by iwd.
>> =

>> yes, it should be used. That is the intention for this header.
> I'm not sure to fully understand your answer.
> ell/useful.h is defined as a private header by ELL since
> https://git.kernel.org/pub/scm/libs/ell/ell.git/commit/?id=3Dd7e2a556b8a5=
3bf5704e822cd9d8d158dc765e22
> =

> So this header is not a part of the public API and, as a result, it is
> not installed on the system.
> However, it seems that ELL specifies that this header is "semi-private" in
> https://git.kernel.org/pub/scm/libs/ell/ell.git/commit/?id=3D2a682421b06e=
41c45098217a686157f576847021
> =

> So, does your answer mean that ELL should be patched to install the
> useful.h header (i.e. move useful.h from ell_libell_la_SOURCES to
> pkginclude_HEADERS)?

it is not a header that is meant to be installed, it is shared header that =
is suppose to be used by ELL and iwd. There however is a bug when using ext=
ernal ELL. I think this should fix it:

diff --git a/Makefile.am b/Makefile.am
index 644f3556b43b..68035e46dc80 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -625,6 +625,7 @@ unit/tls-settings.8021x: unit/cert-ca.pem unit/cert-cli=
ent.pem unit/cert-client-
 BUILT_SOURCES =3D $(ell_built_sources) src/builtin.h
 =

 ell/shared: Makefile
+       $(AM_V_at)$(MKDIR_P) ell
        $(AM_V_GEN)for f in $(ell_shared) ; do \
                if [ ! -f $$f ] ; then \
                        $(LN_S) -t ell -f $(abs_srcdir)/../ell/$$f ; \

Regards

Marcel

--===============5711946641885757197==--

