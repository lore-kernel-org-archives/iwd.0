Content-Type: multipart/mixed; boundary="===============7654258378770400570=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/6] wiphy: check SAE offload in wiphy_select_akm
Date: Fri, 19 Mar 2021 10:11:54 -0500
Message-ID: <1490e337-8627-ebaa-c559-2175ee0ae1ca@gmail.com>
In-Reply-To: <20210318172039.278896-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7654258378770400570==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/18/21 12:20 PM, James Prestwood wrote:
> This allows an SAE AKM to be selected if the hardware does not
> support SAE in userspace, but does support SAE offload.
> ---
>   src/wiphy.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)
> =

> diff --git a/src/wiphy.c b/src/wiphy.c
> index e230b273..9aac830f 100644
> --- a/src/wiphy.c
> +++ b/src/wiphy.c
> @@ -189,17 +189,15 @@ enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy=
 *wiphy,
>   			}
>   =

>   			/*
> -			 * TODO: Only SoftMAC (mac80211) drivers are currently
> -			 * capable of SAE since it requires ability to send
> -			 * Authenticate and Associate frames (which is given by
> -			 * support_cmds_auth_assoc).  FullMAC drivers require
> -			 * SAE offload which we do not support nor supported
> -			 * in any upstream driver as of this time.
> +			 * If the hardware does not support SAE in userspace
> +			 * (NL80211_FEATURE_SAE), has no Auth/Assoc support,
> +			 * nor has SAE offload support downgrade to WPA2.

So linux/nl80211.h states:
"
  * @NL80211_FEATURE_SAE: This driver supports simultaneous authentication =
of
  *      equals (SAE) with user space SME (NL80211_CMD_AUTHENTICATE) in sta=
tion
  *      mode
"

However, there's at least one upstream driver (qtnfmac) that supports SAE =

through CMD_EXTERNAL_AUTH and sets NL80211_FEATURE_SAE as well.

>   			 */
> -			if (!wiphy_has_feature(wiphy, NL80211_FEATURE_SAE) ||
> -					!wiphy->support_cmds_auth_assoc) {

The original code here seems to cover the above case...

> -				l_debug("No HW WPA3 support, trying WPA2");
> -				goto wpa2_personal;
> +			if (!wiphy_has_feature(wiphy, NL80211_FEATURE_SAE)) {

And this looks like it would allow qtnfmac through...

> +				if (!wiphy_has_ext_feature(wiphy,
> +					NL80211_EXT_FEATURE_SAE_OFFLOAD) &&
> +						!wiphy->support_cmds_auth_assoc)
> +					goto wpa2_personal;

Perhaps all this mess needs to be moved into a separate function with all t=
hese =

details explained.

To me it looks like there's 3 paths:

1. SoftMac case:
	FEATURE_SAE &&
		wiphy_supports_cmds_auth_assoc =3D=3D true

2. Non-Offloaded case via CMD_EXTERNAL_AUTH
	FEATURE_SAE &&
		wiphy_supports_cmds_auth_assoc =3D=3D false

3. Offloaded case:
	!FEATURE_SAE &&
		FEATURE_EXT_SAE_OFFLOAD &&
		wiphy_supports_cmds_auth_assoc =3D=3D false

And then maybe in the case of brcmfmac it supports case 2 without setting =

FEATURE_SAE.

Total mess as there seems to be no way to check for external auth support.

>   			}
>   =

>   			if (info.akm_suites &
> =


Regards,
-Denis
--===============7654258378770400570==--

