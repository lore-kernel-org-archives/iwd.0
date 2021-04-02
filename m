Content-Type: multipart/mixed; boundary="===============3576437666056306351=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v5 1/2] wiphy: allow FT AKM to be used if Auth/Assoc is
 not supported
Date: Fri, 02 Apr 2021 16:26:09 -0500
Message-ID: <ddc200a4-4f02-555b-408a-5323c404e8f9@gmail.com>
In-Reply-To: <20210402204227.931444-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3576437666056306351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/2/21 3:42 PM, James Prestwood wrote:
> Until now FT was only supported via Auth/Assoc commands which barred
> any fullmac cards from using FT AKMs. With PSK offload support these
> cards can do FT but only when offloading is used.
> ---
>   src/wiphy.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> =

> v5 (forgot to tag v4 on previous set):
>   * Offloading is assumed if the driver supports it
> =

> diff --git a/src/wiphy.c b/src/wiphy.c
> index ab57a2d2..d5f6f876 100644
> --- a/src/wiphy.c
> +++ b/src/wiphy.c
> @@ -246,10 +246,18 @@ enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy=
 *wiphy,
>   		}
>   =

>   wpa2_personal:
> +		/*
> +		 * Allow FT if either Auth/Assoc is supported OR if the card
> +		 * supports PSK offload. Without Auth/Assoc, PSK offload is the
> +		 * only mechanism to allow FT on these cards.
> +		 */
>   		if ((info.akm_suites & IE_RSN_AKM_SUITE_FT_USING_PSK) &&
> -				bss->rsne && bss->mde_present &&
> -				wiphy->support_cmds_auth_assoc)
> -			return IE_RSN_AKM_SUITE_FT_USING_PSK;
> +					bss->rsne && bss->mde_present) {
> +			if (wiphy->support_cmds_auth_assoc ||
> +				wiphy_has_ext_feature(wiphy,
> +				NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_PSK))

This if statement is a bit messy now and doesn't follow item M4 in =

doc/coding-style.txt

Also, I would think wiphy_supports_firmware_roam() is a better indicator as=
 to =

whether FT should be used or not?  Offloading the handshake should have no =

bearing on whether FT is supported or not...

> +				return IE_RSN_AKM_SUITE_FT_USING_PSK;
> +		}
>   =

>   		if (info.akm_suites & IE_RSN_AKM_SUITE_PSK_SHA256)
>   			return IE_RSN_AKM_SUITE_PSK_SHA256;
> =


Regards,
-Denis
--===============3576437666056306351==--

