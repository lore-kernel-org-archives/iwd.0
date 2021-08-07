Content-Type: multipart/mixed; boundary="===============2574559805769525320=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH] test-runner: Drop unused parameter
Date: Fri, 06 Aug 2021 19:45:38 -0700
Message-ID: <11b428f8f83524d45f5abf5bda179fcd8a9f4b23.camel@gmail.com>
In-Reply-To: <20210807015101.311834-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2574559805769525320==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Sat, 2021-08-07 at 03:51 +0200, Andrew Zaborowski wrote:
> ---
> =C2=A0tools/test-runner | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/tools/test-runner b/tools/test-runner
> index 75e46444..f5ab7c58 100755
> --- a/tools/test-runner
> +++ b/tools/test-runner
> @@ -164,7 +164,7 @@ class Process:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0case.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0'''
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0def __init__(self, args, =
wait=3DFalse, env=3DNone, ctx=3DNone,
> check=3DFalse,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0outfile=3DNone, namespace=3DNone,
> need_out=3DFalse, cleanup=3DNone):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0outfile=3DNone, namespace=3DNone,
> cleanup=3DNone):

This is fine, but we also need to remove the use in hostapd.py for
list_sta/send_bss_transition.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0self.killed =3D False
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0self.args =3D args
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0self.wait =3D wait

Thanks,
James


--===============2574559805769525320==--

