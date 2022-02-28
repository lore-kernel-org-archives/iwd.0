Content-Type: multipart/mixed; boundary="===============0090619937636037682=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 4/7] scan: add support for scanning on AP interface type
Date: Mon, 28 Feb 2022 12:06:23 -0600
Message-ID: <5d0a61aa-d119-d73d-ae50-b7ed8a5d9ade@gmail.com>
In-Reply-To: 20220224170500.2779425-4-prestwoj@gmail.com

--===============0090619937636037682==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/24/22 11:04, James Prestwood wrote:
> This adds a new flag, force_ap to the scan parameters. When enabled
> this will set NL80211_SCAN_FLAG_AP.
> ---
>   src/scan.c | 4 ++++
>   src/scan.h | 1 +
>   2 files changed, 5 insertions(+)
> =

> v2:
>   * Renamed flag to 'ap_scan'
> =

> diff --git a/src/scan.c b/src/scan.c
> index 12b7a3fd..2345ca50 100644
> --- a/src/scan.c
> +++ b/src/scan.c
> @@ -391,6 +391,10 @@ static struct l_genl_msg *scan_build_cmd(struct scan=
_context *sc,
>   					NL80211_EXT_FEATURE_SCAN_RANDOM_SN))
>   		flags |=3D NL80211_SCAN_FLAG_RANDOM_SN;
>   =

> +	if (params->ap_scan && wiphy_has_feature(sc->wiphy,
> +						NL80211_FEATURE_AP_SCAN))

So I still think this check should be in ap.c itself.  If someone wants to =
use =

this with drivers that do not set this feature...  Well they need to fix th=
e =

driver then :)

> +		flags |=3D NL80211_SCAN_FLAG_AP;
> +
>   	if (flags)
>   		l_genl_msg_append_attr(msg, NL80211_ATTR_SCAN_FLAGS, 4, &flags);

Regards,
-Denis
--===============0090619937636037682==--

