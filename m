Content-Type: multipart/mixed; boundary="===============3492605110830122251=="
MIME-Version: 1.0
From: Khem Raj <raj.khem@gmail.com>
Subject: Re: [PATCH] Use abs_top_srcdir in place of abs_srcdir
Date: Wed, 28 Apr 2021 18:54:11 -0700
Message-ID: <CAMKF1soNruMfETLYnfUavEP4TDv6WQA-4uJuBDRsXP0BeQctOQ@mail.gmail.com>
In-Reply-To: <20210405213344.3477582-1-raj.khem@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3492605110830122251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ping

On Mon, Apr 5, 2021 at 2:33 PM Khem Raj <raj.khem@gmail.com> wrote:
>
> this makes it build when build dir is outside of sources dir
> ---
>  Makefile.am | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index 644f3556..e3f79901 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -625,9 +625,10 @@ unit/tls-settings.8021x: unit/cert-ca.pem unit/cert-=
client.pem unit/cert-client-
>  BUILT_SOURCES =3D $(ell_built_sources) src/builtin.h
>
>  ell/shared: Makefile
> +       $(AM_V_at)$(MKDIR_P) ell
>         $(AM_V_GEN)for f in $(ell_shared) ; do \
>                 if [ ! -f $$f ] ; then \
> -                       $(LN_S) -t ell -f $(abs_srcdir)/../ell/$$f ; \
> +                       $(LN_S) -t ell -f $(abs_top_srcdir)/ell/$$f ; \
>                 fi \
>         done > $@
>
> @@ -635,7 +636,7 @@ ell/internal: Makefile
>         $(AM_V_at)$(MKDIR_P) ell
>         $(AM_V_GEN)for f in $(ell_headers) $(ell_sources) ; do \
>                 if [ ! -f $$f ] ; then \
> -                       $(LN_S) -t ell -f $(abs_srcdir)/../ell/$$f ; \
> +                       $(LN_S) -t ell -f $(abs_top_srcdir)/ell/$$f ; \
>                 fi \
>         done > $@
>
> --
> 2.31.1
>
--===============3492605110830122251==--

