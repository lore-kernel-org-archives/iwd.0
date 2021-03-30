Content-Type: multipart/mixed; boundary="===============2834329896017634112=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 2/7] wiphy: fix wiphy_can_connect AKM checks
Date: Tue, 30 Mar 2021 14:58:11 -0500
Message-ID: <0c8650bf-5dea-e610-4269-e473a30ff8c8@gmail.com>
In-Reply-To: <20210330184808.744574-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2834329896017634112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/30/21 1:48 PM, James Prestwood wrote:
> Commit 6e8b76527 added a switch statement for AKM suites which
> was not correct as this is a bitmask and may contain multiple
> values. Intead we can rely on wiphy_select_akm which is a more
> robust check anyways.

Might as well use a Fixes: tag.

Also, please re-order this to be the first in the series.  No sense in touc=
hing =

wiphy_can_connect in patch 1 just to remove all traces in patch 2.

> ---
>   src/wiphy.c | 24 +++++++-----------------
>   1 file changed, 7 insertions(+), 17 deletions(-)
> =

> diff --git a/src/wiphy.c b/src/wiphy.c
> index 35872577..f570495e 100644
> --- a/src/wiphy.c
> +++ b/src/wiphy.c
> @@ -414,24 +414,14 @@ bool wiphy_can_connect(struct wiphy *wiphy, struct =
scan_bss *bss)
>   					rsn_info.group_management_cipher))
>   			return false;
>   =

> +		/*
> +		 * Just assume FILS capable at this point. Station will verify
> +		 * this later, but at this point we cannot know if the network
> +		 * settings have the needed FILS identity.
> +		 */
> +		if (!wiphy_select_akm(wiphy, bss, true))
> +			return false;

Why not return wiphy_select_akm() here?  Also, since we only support FILS o=
n =

SoftMAC, the safer option might be false actually.

>   =

> -		switch (rsn_info.akm_suites) {
> -		case IE_RSN_AKM_SUITE_SAE_SHA256:
> -		case IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256:
> -			if (!wiphy_can_connect_sae(wiphy, NULL))
> -				return false;
> -
> -			break;
> -		case IE_RSN_AKM_SUITE_OWE:
> -		case IE_RSN_AKM_SUITE_FILS_SHA256:
> -		case IE_RSN_AKM_SUITE_FILS_SHA384:
> -		case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256:
> -		case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384:
> -			if (!wiphy->support_cmds_auth_assoc)
> -				return false;
> -
> -			break;
> -		}
>   	} else if (r !=3D -ENOENT)
>   		return false;
>   =

> =


Regards,
-Denis
--===============2834329896017634112==--

