Content-Type: multipart/mixed; boundary="===============6042205419293856396=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 4/9] ft: netdev: store FT-over-DS target RSNE/WPA
Date: Tue, 28 Sep 2021 16:59:27 -0500
Message-ID: <73db0e7b-f2fe-fe91-898b-b3ae5d0f5017@gmail.com>
In-Reply-To: 20210928212744.717276-4-prestwoj@gmail.com

--===============6042205419293856396==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/28/21 4:27 PM, James Prestwood wrote:
> Keep track of the target BSS's authenticator IE for verification.
> It should not be assumed that the target BSS and original RSNE/WPA
> IE matches.
> ---
>   src/ft.c     |  3 +++
>   src/ft.h     |  1 +
>   src/netdev.c | 10 ++++++++++
>   3 files changed, 14 insertions(+)
> =


<snip>

> @@ -4392,6 +4393,15 @@ int netdev_fast_transition_over_ds_action(struct n=
etdev *netdev,
>   	memcpy(info->super.spa, hs->spa, ETH_ALEN);
>   	memcpy(info->super.aa, target_bss->addr, ETH_ALEN);
>   	memcpy(info->super.mde, target_bss->mde, sizeof(info->super.mde));
> +
> +	if (target_bss->rsne)
> +		ap_ie =3D target_bss->rsne;
> +	else if (target_bss->wpa)
> +		ap_ie =3D target_bss->wpa;
> +
> +	if (ap_ie)
> +		info->super.authenticator_ie =3D l_memdup(ap_ie, ap_ie[1] + 2);
> +
>   	l_getrandom(info->super.snonce, 32);
>   	info->super.free =3D netdev_ft_ds_info_free;
>   =

> =


There's no FT in WPA, so the only way we get here is with RSNE or possibly =
Open. =

  So I simplified this slightly.

Patches 1-4 applied, thanks.

Regards,
-Denis
--===============6042205419293856396==--

