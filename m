Content-Type: multipart/mixed; boundary="===============5794978861522274862=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 02/12] dpp-util: add dpp_point_from_asn1()
Date: Thu, 20 Jan 2022 14:10:32 -0600
Message-ID: <bfbe6420-c777-a368-8bb2-1c7776bec48b@gmail.com>
In-Reply-To: 20220118212512.2017977-2-prestwoj@gmail.com

--===============5794978861522274862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/18/22 15:25, James Prestwood wrote:
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
> +	if (!key_data || tag !=3D ASN1_ID_BIT_STRING || elen < 34)

Why 34? Aren't you only concerned that elen >=3D 2?

> +		return NULL;
> +
> +	curve =3D l_ecc_curve_from_ike_group(curve_num);
> +	if (!curve)
> +		return NULL;

Perhaps this check should be moved up?

> +
> +	return l_ecc_point_from_data(curve, key_data[1],
> +					key_data + 2, elen - 2);

Aren't you relying on ecc_point_from_data to validate the length?  Hence th=
e =

unnecessary '34' magic number above?

Should ecc_point_from_data also validate that all of the data passed in was =

consumed?  Or maybe return the number of bytes consumed so that we can vali=
date =

it here?

Regards,
-Denis
--===============5794978861522274862==--

