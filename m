Content-Type: multipart/mixed; boundary="===============2922903148055256959=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 2/4] ie: add ie_akm_suite_to_string
Date: Thu, 25 Mar 2021 10:47:48 -0500
Message-ID: <683a4052-1db6-447b-4d36-ed928a86e66e@gmail.com>
In-Reply-To: <20210324230538.583325-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2922903148055256959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/24/21 6:05 PM, James Prestwood wrote:
> Converts ie_rsn_akm_suite values into strings
> ---
>   src/ie.c | 33 +++++++++++++++++++++++++++++++++
>   src/ie.h |  2 ++
>   2 files changed, 35 insertions(+)
> =

> diff --git a/src/ie.c b/src/ie.c
> index 46f7496e..80c6e5e4 100644
> --- a/src/ie.c
> +++ b/src/ie.c
> @@ -2636,3 +2636,36 @@ int ie_build_hs20_indication(uint8_t version, uint=
8_t *to)
>   =

>   	return 0;
>   }
> +
> +const char *ie_akm_suite_to_string(enum ie_rsn_akm_suite akm)
> +{
> +	switch (akm) {
> +	case IE_RSN_AKM_SUITE_8021X:

How are you distinguishing between WPA1 and WPA2?

> +	case IE_RSN_AKM_SUITE_8021X_SHA256:
> +		return "WPA2-Enterprise";
> +	case IE_RSN_AKM_SUITE_PSK:
> +	case IE_RSN_AKM_SUITE_PSK_SHA256:
> +		return "WPA2-Personal";
> +	case IE_RSN_AKM_SUITE_FT_OVER_8021X:
> +	case IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384:
> +		return "WPA2-Enterprise + FT";
> +	case IE_RSN_AKM_SUITE_FT_USING_PSK:
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

Also, for reasons mentioned in patch 1, I'd rather keep this specific to th=
e =

diagnostics interface.  So this probably belongs in diagnostics.c ?

Regards,
-Denis
--===============2922903148055256959==--

