Content-Type: multipart/mixed; boundary="===============4631126479668320974=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 5/7] network: add 6GHz restrictions to
 network_can_connect_bss
Date: Fri, 25 Feb 2022 18:04:06 -0600
Message-ID: <1725484b-54d9-9e87-4978-86522c0355cc@gmail.com>
In-Reply-To: 20220225233251.2958102-5-prestwoj@gmail.com

--===============4631126479668320974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/25/22 17:32, James Prestwood wrote:
> The 802.11ax standards adds some restrictions for the 6GHz band. In short
> stations must use SAE, OWE, or 8021x on this band and frame protection is
> required.
> ---
>   src/network.c | 58 +++++++++++++++++++++++++++++++++++++++------------
>   1 file changed, 45 insertions(+), 13 deletions(-)
> =

> v3:
>   * Combined some of the WPA3 checks with 6GHz that duplicated
>   * Used macros rather than checking all valid AKMs
> =


<snip>

> +	/* 802.11ax Section 12.12.2 */
> +	if (band =3D=3D BAND_FREQ_6_GHZ) {
> +		/* STA shall not use the following cipher suite selectors */
> +		rsn.pairwise_ciphers &=3D ~IE_RSN_CIPHER_SUITE_USE_GROUP_CIPHER;
> +
> +		/* Basically the STA must use OWE, SAE, or 8021x */
> +		if (!IE_AKM_IS_SAE(rsn.akm_suites &&

This looks like it is missing a ')'

> +				!IE_AKM_IS_8021X(rsn.akm_suites) &&
> +				(!(rsn.akm_suites | IE_RSN_AKM_SUITE_OWE))))

!(rsn.akm_suites & IE_RSN_AKM_SUITE_OWE) ?

> +			return -EPERM;
> +	}
> +
>   no_transition_disable:
>   	if (!wiphy_select_cipher(wiphy, rsn.pairwise_ciphers))
>   		return -ENOTSUP;
> =


Regards,
-Denis
--===============4631126479668320974==--

