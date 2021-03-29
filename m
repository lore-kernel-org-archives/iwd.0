Content-Type: multipart/mixed; boundary="===============4985361780690613877=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 2/4] diagnostic: add diagnostic_akm_suite_to_security
Date: Mon, 29 Mar 2021 13:22:06 -0500
Message-ID: <52a57013-824c-e743-9eaf-d222d1d93842@gmail.com>
In-Reply-To: <20210329173310.706671-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4985361780690613877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/29/21 12:33 PM, James Prestwood wrote:
> Converts ie_rsn_akm_suite values (and WPA1 hint) into a more
> human readable security string such as:
> =

> WPA2-Personal, WPA3-Personal, WPA2-Personal + FT etc.
> ---
>   src/diagnostic.c | 41 +++++++++++++++++++++++++++++++++++++++++
>   src/diagnostic.h |  5 +++++
>   2 files changed, 46 insertions(+)
> =

> v3:
>   * Added wpa1 hint
>   * Moved this from ie.c into diagnostic.c
> =


<snip>

> +
> +const char *diagnostic_akm_suite_to_security(enum ie_rsn_akm_suite akm,
> +						bool wpa)
> +{
> +	switch (akm) {
> +	case IE_RSN_AKM_SUITE_8021X:

FYI, there is in theory WPA1-Enterprise, but I've never seen that in the wi=
ld...

> +	case IE_RSN_AKM_SUITE_8021X_SHA256:
> +		return "WPA2-Enterprise";
> +	case IE_RSN_AKM_SUITE_PSK:
> +	case IE_RSN_AKM_SUITE_PSK_SHA256:

PSK_SHA256 isn't a valid AKM for WPA1, so I amended this patch slightly to =
fix =

that...

> +		if (wpa)
> +			return "WPA1-Personal";
> +
> +		return "WPA2-Personal";
> +	case IE_RSN_AKM_SUITE_FT_OVER_8021X:
> +	case IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384:
> +		return "WPA2-Enterprise + FT";
> +	case IE_RSN_AKM_SUITE_FT_USING_PSK:

And FT isn't an option in WPA1 either, so I amended this part as well.

> +		if (wpa)
> +			return "WPA1-Personal + FT";
> +
> +		return "WPA2-Personal + FT";
> +	case IE_RSN_AKM_SUITE_SAE_SHA256:
> +		return "WPA3-Personal";
> +	case IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256:
> +		return "WPA3-Personal + FT";
> +	case IE_RSN_AKM_SUITE_OWE:
> +		return "OWE";
> +	case IE_RSN_AKM_SUITE_FILS_SHA256:
> +	case IE_RSN_AKM_SUITE_FILS_SHA384:
> +		return "FILS";
> +	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256:
> +	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384:
> +		return "FILS + FT";
> +	case IE_RSN_AKM_SUITE_OSEN:
> +		return "OSEN";
> +	default:
> +		return NULL;
> +	}
> +}

All 4 patches have been applied, thanks.

Regards,
-Denis
--===============4985361780690613877==--

