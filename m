Content-Type: multipart/mixed; boundary="===============1630485836253770167=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 07/11] network: add 6GHz restrictions to
 network_can_connect_bss
Date: Fri, 25 Feb 2022 13:24:25 -0600
Message-ID: <89149ea1-9603-220a-0306-f4c75605f5df@gmail.com>
In-Reply-To: 20220225175810.2914413-7-prestwoj@gmail.com

--===============1630485836253770167==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/25/22 11:58, James Prestwood wrote:
> The 802.11ax standards adds some restrictions for the 6GHz band. In short
> stations must use SAE, OWE, or 8021x on this band and frame protection is
> required.
> ---
>   src/network.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> =


<snip>

> @@ -852,6 +864,31 @@ int network_can_connect_bss(struct network *network,=
 const struct scan_bss *bss)
>   	}
>   =

>   no_transition_disable:
> +	/* 802.11ax Section 12.12.2 */
> +	if (band =3D=3D BAND_FREQ_6_GHZ) {
> +		/* STA shall not use the following cipher suite selectors */
> +		rsn.pairwise_ciphers &=3D ~IE_RSN_CIPHER_SUITE_USE_GROUP_CIPHER;
> +		rsn.pairwise_ciphers &=3D ~IE_RSN_CIPHER_SUITE_TKIP;
> +
> +		/* STA shall not use the following AKM suite selectors */
> +		rsn.akm_suites &=3D ~IE_RSN_AKM_SUITE_PSK;
> +		rsn.akm_suites &=3D ~IE_RSN_AKM_SUITE_PSK_SHA256;
> +		rsn.akm_suites &=3D ~IE_RSN_AKM_SUITE_FT_USING_PSK;
> +
> +		/* Basically the STA must use OWE, SAE, or 8021x */
> +		if (!(rsn.akm_suites & (IE_RSN_AKM_SUITE_8021X |
> +					IE_RSN_AKM_SUITE_FT_OVER_8021X |
> +					IE_RSN_AKM_SUITE_8021X_SHA256 |
> +					IE_RSN_AKM_SUITE_SAE_SHA256 |
> +					IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256 |
> +					IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384 |
> +					IE_RSN_AKM_SUITE_OWE)))

I wonder if it is better to use IE_AKM_IS_SAE, IE_AKM_IS_FILS(8021x) and =

IE_AKM_IS_OWE instead.

> +			return -EPERM;
> +
> +		/* STA shall use management frame protection */
> +		rsn.mfpr =3D true;

This isn't actually how we enforce MFP.  Not sure we ever set MFPR to true =

unless it is for testing purposes.

> +	}
> +
>   	if (!wiphy_select_cipher(wiphy, rsn.pairwise_ciphers))
>   		return -ENOTSUP;
>   =

> =


Regards,
-Denis
--===============1630485836253770167==--

