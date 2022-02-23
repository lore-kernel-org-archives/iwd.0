Content-Type: multipart/mixed; boundary="===============8387865993732377008=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 4/7] scan: add support for scanning on AP interface type
Date: Wed, 23 Feb 2022 12:50:37 -0600
Message-ID: <0ea0a29c-edeb-b240-5c4c-98d69b555319@gmail.com>
In-Reply-To: 20220222225718.2485794-4-prestwoj@gmail.com

--===============8387865993732377008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/22/22 16:57, James Prestwood wrote:
> This adds a new flag, force_ap to the scan parameters. When enabled
> this will set NL80211_SCAN_FLAG_AP.
> ---
>   src/scan.c | 4 ++++
>   src/scan.h | 1 +
>   2 files changed, 5 insertions(+)
> =

> diff --git a/src/scan.c b/src/scan.c
> index 12b7a3fd..01056634 100644
> --- a/src/scan.c
> +++ b/src/scan.c
> @@ -391,6 +391,10 @@ static struct l_genl_msg *scan_build_cmd(struct scan=
_context *sc,
>   					NL80211_EXT_FEATURE_SCAN_RANDOM_SN))
>   		flags |=3D NL80211_SCAN_FLAG_RANDOM_SN;
>   =

> +	if (params->force_ap && wiphy_has_feature(sc->wiphy,
> +						NL80211_FEATURE_AP_SCAN))

You already check this in patch 5 ap_dbus_scan()?

> +		flags |=3D NL80211_SCAN_FLAG_AP;
> +
>   	if (flags)
>   		l_genl_msg_append_attr(msg, NL80211_ATTR_SCAN_FLAGS, 4, &flags);
>   =

> diff --git a/src/scan.h b/src/scan.h
> index 2c401df6..7ad50e5d 100644
> --- a/src/scan.h
> +++ b/src/scan.h
> @@ -98,6 +98,7 @@ struct scan_parameters {
>   	bool randomize_mac_addr_hint : 1;
>   	bool no_cck_rates : 1;
>   	bool duration_mandatory : 1;
> +	bool force_ap : 1;

force_ap_scan? or simply ap_scan?

>   	const uint8_t *ssid;	/* Used for direct probe request */
>   	size_t ssid_len;
>   	const uint8_t *source_mac;
> =


Regards,
-Denis
--===============8387865993732377008==--

