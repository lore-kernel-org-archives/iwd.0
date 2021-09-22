Content-Type: multipart/mixed; boundary="===============3800060519583277537=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 4/6] ie: parse operating class/channel for
 ie_owe_transition_info
Date: Wed, 22 Sep 2021 14:01:56 -0500
Message-ID: <b5378eac-f303-71d7-7581-61cfaae88efc@gmail.com>
In-Reply-To: 20210922182655.46220-4-prestwoj@gmail.com

--===============3800060519583277537==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/22/21 1:26 PM, James Prestwood wrote:
> This operating class/channel is also verified while parsing and
> parsing will fail if band_oci_frequency fails.
> =

> This does put a requirement on anything that uses ie.c to also
> include band.c. Makefile has been updated.
> ---
>   Makefile.am | 16 ++++++++++------
>   src/ie.c    | 31 ++++++++++++++++++++-----------
>   src/ie.h    |  2 ++
>   3 files changed, 32 insertions(+), 17 deletions(-)
> =


Can we avoid invoking band_* functions in ie.c?  I'm not sure I want to mak=
e =

them dependent on each other since band carries some data structures that =

closely mirror nl80211.

<snip>

> +
> +	if (len =3D=3D slen + 15) {
> +		oper_class =3D l_get_u8(ie + 13 + slen);
> +		channel =3D l_get_u8(ie + 14 + slen);
> +
> +		if (oci_to_frequency(oper_class, channel) < 0)
> +			return -ENOMSG;
> +	}

Maybe make station or scan itself validate this info?

Regards,
-Denis
--===============3800060519583277537==--

