Content-Type: multipart/mixed; boundary="===============7176781793816909725=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v4] network: add 6GHz restrictions to
 network_can_connect_bss
Date: Mon, 28 Feb 2022 11:32:38 -0600
Message-ID: <526559de-6f82-a2e6-e720-304ce81d8c15@gmail.com>
In-Reply-To: 20220226010639.2965333-1-prestwoj@gmail.com

--===============7176781793816909725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2/25/22 19:06, James Prestwood wrote:
> The 802.11ax standards adds some restrictions for the 6GHz band. In short
> stations must use SAE, OWE, or 8021x on this band and frame protection is
> required.
> ---
>   src/network.c | 58 +++++++++++++++++++++++++++++++++++++++------------
>   1 file changed, 45 insertions(+), 13 deletions(-)
> =

> v4:
>   * Renamed label to mfp_no_tkip
>   * Fixed missing parentheses after IS_SAE
> =


<snip>

> +		/* Basically the STA must use OWE, SAE, or 8021x */
> +		if (!IE_AKM_IS_SAE(rsn.akm_suites) &&
> +				!IE_AKM_IS_8021X(rsn.akm_suites) &&
> +				(!(rsn.akm_suites | IE_RSN_AKM_SUITE_OWE)))

I amended this to use '&' instead of '|' and applied, thanks.

Regards,
-Denis
--===============7176781793816909725==--

