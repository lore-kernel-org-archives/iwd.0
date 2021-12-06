Content-Type: multipart/mixed; boundary="===============0360904317168058084=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 4/4] unit: add unit test for DPP crypto operations
Date: Mon, 06 Dec 2021 16:37:43 -0600
Message-ID: <12a63363-93db-46db-813a-b9f91353d86e@gmail.com>
In-Reply-To: 20211206210356.1204046-4-prestwoj@gmail.com

--===============0360904317168058084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 12/6/21 3:03 PM, James Prestwood wrote:
> ---
>   Makefile.am     |   7 ++-
>   unit/test-dpp.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 153 insertions(+), 1 deletion(-)
>   create mode 100644 unit/test-dpp.c
> =


<snip>

> @@ -547,6 +548,10 @@ unit_test_p2p_SOURCES =3D unit/test-p2p.c src/wscuti=
l.h src/wscutil.c \
>   				src/band.h src/band.c
>   unit_test_p2p_LDADD =3D $(ell_ldadd)
>   =

> +unit_test_dpp_SOURCES =3D unit/test-dpp.c src/dpp-util.h src/dpp-util.c \
> +				src/util.h src/util.c src/crypto.h src/crypto.c

I had to add src/band.[ch] here

> +unit_test_dpp_LDADD =3D $(ell_ldadd)
> +
>   TESTS =3D $(unit_tests)
>   =

>   EXTRA_DIST =3D src/genbuiltin src/iwd.service.in src/net.connman.iwd.se=
rvice \

<snip>

> +const char *i_proto_public_bytes =3D "50a532ae2a07207276418d2fa630295d45=
569be425aa634f02014d00a7d1f61a";

I changed some of these data lines to be 80 char / line compliant.

Applied, but I'm seeing this:

TEST: DPP test key derivation

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D17289=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 536 byte(s) in 7 object(s) allocated from:
     #0 0x7f88cc96d0f8 in __interceptor_malloc =

(/usr/lib/gcc/x86_64-pc-linux-gnu/9.4.0/libasan.so.5+0x10c0f8)
     #1 0x4199d2 in l_malloc ell/util.c:62

SUMMARY: AddressSanitizer: 536 byte(s) leaked in 7 allocation(s).

Regards,
-Denis
--===============0360904317168058084==--

