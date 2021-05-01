Content-Type: multipart/mixed; boundary="===============0519690924708041322=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: Re: [PATCH] build: fix ell/shared build failure
Date: Sat, 01 May 2021 16:08:19 +0000
Message-ID: <9d2e32ee-b7bc-935e-cb29-ffc97cbcd406@bang-olufsen.dk>
In-Reply-To: <20210419114546.840331-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0519690924708041322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This is just a polite ping to the list in case this patch went unnoticed.

Perhaps I should have given some extra background on this. We are =

building iwd with Yocto/OE, and while bumping our recipe to iwd 1.13 - =

which uses the tarball on kernel.org - I noticed that the build was =

failing because of a missing ell/ directory.

With the standard Yocto tooling, --disable-dependency-tracking is passed =

by default to autotools builds[1]. Omitting this flag seems to solve the =

problem.

Marcel Holtmann already proposed this particular change on the list a =

few weeks ago as a fix for a similar issue when building with =

--enable-external-ell on Buildroot, but another solution was arrived at =

in that thread. At any rate, it also addresses the build failure I =

described above, so it seems to be a justifiable change. This is also =

common practice for other ell/* targets in iwd's Makefile.am anyway.

I am no autotools expert so I cannot really explain why =

--disable-dependency-tracking and other flags cause the build to fail in =

this way, but hopefully the above is a good enough justification for the =

patch.

Kind regards,
Alvin

[1] =

http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/meta/classes/autotools.=
bbclass#n76

On 4/19/21 1:45 PM, Alvin =C5=A0ipraga wrote:
> Fix the following build error:
> =

>    $ /path/to/iwd/configure --disable-dependency-tracking
>    $ make
>      GEN      ell/shared
>    /bin/sh: line 5: ell/shared: No such file or directory
>    make: *** [Makefile:3656: ell/shared] Error 1
> =

> The error can also arise if building with --enable-external-ell.
> =

> Fixes: ed05585063f2 ("build: Always link in the ell/useful.h header file")
> ---
>   Makefile.am | 1 +
>   1 file changed, 1 insertion(+)
> =

> diff --git a/Makefile.am b/Makefile.am
> index 644f3556..68035e46 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -625,6 +625,7 @@ unit/tls-settings.8021x: unit/cert-ca.pem unit/cert-c=
lient.pem unit/cert-client-
>   BUILT_SOURCES =3D $(ell_built_sources) src/builtin.h
>   =

>   ell/shared: Makefile
> +	$(AM_V_at)$(MKDIR_P) ell
>   	$(AM_V_GEN)for f in $(ell_shared) ; do \
>   		if [ ! -f $$f ] ; then \
>   			$(LN_S) -t ell -f $(abs_srcdir)/../ell/$$f ; \
>=20
--===============0519690924708041322==--

