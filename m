Content-Type: multipart/mixed; boundary="===============5697915869433503097=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 2/4] scan: validate OWE transition operating
 class/channel
Date: Wed, 22 Sep 2021 14:42:31 -0500
Message-ID: <8250a82c-8807-1993-0cc9-83ef0421eebb@gmail.com>
In-Reply-To: 20210922193418.13072-2-prestwoj@gmail.com

--===============5697915869433503097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/22/21 2:34 PM, James Prestwood wrote:
> If the IE's operating class and channel doesn't validate don't bother
> storing the IE at all.
> ---
>   src/scan.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> =

> diff --git a/src/scan.c b/src/scan.c
> index 54a7bc84..3f36ea3e 100644
> --- a/src/scan.c
> +++ b/src/scan.c
> @@ -1063,11 +1063,19 @@ static void scan_parse_vendor_specific(struct sca=
n_bss *bss, const void *data,
>   		bss->owe_trans =3D l_new(struct ie_owe_transition_info, 1);
>   =

>   		if (ie_parse_owe_transition(data - 2, len + 2,
> -						bss->owe_trans) < 0) {
> -			l_free(bss->owe_trans);
> -			bss->owe_trans =3D NULL;
> -		}
> +						bss->owe_trans) < 0)
> +			goto free_owe_trans;
> +
> +		if (bss->owe_trans->oper_class && oci_to_frequency(
> +						bss->owe_trans->oper_class,
> +						bss->owe_trans->channel) < 0)
> +			goto free_owe_trans;
> +
> +		return;
>   =

> +free_owe_trans:
> +		l_free(bss->owe_trans);
> +		bss->owe_trans =3D NULL;
>   		return;

I simplified the logic here slightly through the use of _auto_ and l_steal_=
ptr.

>   	}
>   =

> =


Patches 2-4 applied, thanks.

Regards,
-Denis
--===============5697915869433503097==--

