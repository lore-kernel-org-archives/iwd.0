Content-Type: multipart/mixed; boundary="===============5224183909940919944=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] src/sae.c: Use realloc(3) instead of reallocarray(3)
Date: Sun, 19 Sep 2021 12:54:39 -0500
Message-ID: <a79af225-e17c-7207-9f2c-024ea3dca56f@gmail.com>
In-Reply-To: 20210919085710.1805075-1-fontaine.fabrice@gmail.com

--===============5224183909940919944==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fabrice,

On 9/19/21 3:57 AM, Fabrice Fontaine wrote:
> reallocarray(3) has been added to glibc relatively recently (version
> 2.26, from 2017) and apparently not all users run new enough glibc.
> Moreover, reallocarray is not available with uclibc-ng. Just use
> realloc(3) for now since in this case there's no real risk of overflow.
> This will avoid the following build failure since commit
> 891b78e9e892a3bcd800eb3a298e6380e9a15dd1:
> =

> /home/giuliobenetti/autobuild/run/instance-3/output-1/host/lib/gcc/xtensa=
-buildroot-linux-uclibc/10.3.0/../../../../xtensa-buildroot-linux-uclibc/bi=
n/ld: src/sae.o: in function `sae_rx_authenticate':
> sae.c:(.text+0xd74): undefined reference to `reallocarray'
> =

> Fixes:
>   - http://autobuild.buildroot.org/results/c6d3f86282c44645b4f1c61882dc63=
ccfc8eb35a
> =

> Signed-off-by: Fabrice Fontaine <fontaine.fabrice(a)gmail.com>

No S-o-b tags please.

> ---
>   src/sae.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> =

> diff --git a/src/sae.c b/src/sae.c
> index 7e6377f5..d04891e7 100644
> --- a/src/sae.c
> +++ b/src/sae.c
> @@ -104,7 +104,7 @@ static void sae_rejected_groups_append(struct sae_sm =
*sm, uint16_t group)
>   	uint16_t i;
>   =

>   	if (!sm->rejected_groups) {
> -		sm->rejected_groups =3D reallocarray(NULL, 2, sizeof(uint16_t));
> +		sm->rejected_groups =3D realloc(NULL, 2 * sizeof(uint16_t));
>   		sm->rejected_groups[0] =3D 1;
>   		sm->rejected_groups[1] =3D group;
>   		return;
> @@ -114,8 +114,8 @@ static void sae_rejected_groups_append(struct sae_sm =
*sm, uint16_t group)
>   		if (sm->rejected_groups[i] =3D=3D group)
>   			return;
>   =

> -	sm->rejected_groups =3D reallocarray(sm->rejected_groups,
> -						i + 1, sizeof(uint16_t));
> +	sm->rejected_groups =3D realloc(sm->rejected_groups,
> +					(i + 1) * sizeof(uint16_t));

Can we add this to missing.h instead?  The reallocarray version is more cle=
ar / =

preferable to open-coded version.

>   	sm->rejected_groups[0] +=3D 1;
>   	sm->rejected_groups[i] =3D group;
>   }
> =


Regards,
-Denis
--===============5224183909940919944==--

