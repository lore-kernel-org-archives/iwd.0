Content-Type: multipart/mixed; boundary="===============7009763458492331120=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 01/10] dpp-util: add dpp_point_from_asn1()
Date: Fri, 21 Jan 2022 10:55:14 -0600
Message-ID: <0cc5b18a-c456-14f7-1c39-8d5f9e3f6e05@gmail.com>
In-Reply-To: 20220120234415.2469451-1-prestwoj@gmail.com

--===============7009763458492331120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/20/22 17:44, James Prestwood wrote:
> Given an ASN1 blob of the right form, parse and create
> an l_ecc_point object. The form used is specific to DPP
> hence why this isn't general purpose and put into dpp-util.
> ---
>   src/dpp-util.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/dpp-util.h |  1 +
>   2 files changed, 70 insertions(+)
> =


<snip>

> +	/* BITSTRING */
> +	key_data =3D asn1_der_find_elem(outer_seq, outer_len, 1, &tag, &elen);
> +	if (!key_data || tag !=3D ASN1_ID_BIT_STRING || elen > 2)

< 2?

also you have a line > 80 chars in this patch.

Regards,
-Denis
--===============7009763458492331120==--

