Content-Type: multipart/mixed; boundary="===============2818669866773611612=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/8] wiphy: Add wiphy_get_supported_rates
Date: Fri, 25 Oct 2019 14:11:37 -0500
Message-ID: <ee233e03-8325-3b35-653a-8f5c90da1e69@gmail.com>
In-Reply-To: <20191024043000.13687-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2818669866773611612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/23/19 11:29 PM, Andrew Zaborowski wrote:
> Add code to parse the supported data rates info from the wiphy dumps and
> expose it for P2P's use with a getter function.
> ---
>   src/wiphy.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++---
>   src/wiphy.h |  2 ++
>   2 files changed, 76 insertions(+), 4 deletions(-)
> =

> diff --git a/src/wiphy.c b/src/wiphy.c
> index 9cb9ae66..12ec5d17 100644
> --- a/src/wiphy.c
> +++ b/src/wiphy.c
> @@ -76,6 +76,7 @@ struct wiphy {
>   	struct watchlist state_watches;
>   	uint8_t extended_capabilities[EXT_CAP_LEN + 2]; /* max bitmap size + I=
E header */
>   	uint8_t *iftype_extended_capabilities[NUM_NL80211_IFTYPES];
> +	uint8_t *supported_rates[NUM_NL80211_BANDS];

So bit rates are uint32 in nl80211 and a uint16 in the kernel.  How will =

this work to compress a 16 bit value in 8 bits, even if we divide by 5?

>   	uint8_t rm_enabled_capabilities[7]; /* 5 size max + header */
>   =

>   	bool support_scheduled_scan:1;
> @@ -212,6 +213,9 @@ static void wiphy_free(void *data)
>   	for (i =3D 0; i < NUM_NL80211_IFTYPES; i++)
>   		l_free(wiphy->iftype_extended_capabilities[i]);
>   =

> +	for (i =3D 0; i < NUM_NL80211_BANDS; i++)
> +		l_free(wiphy->supported_rates[i]);
> +
>   	scan_freq_set_free(wiphy->supported_freqs);
>   	watchlist_destroy(&wiphy->state_watches);
>   	l_free(wiphy->model_str);
> @@ -478,6 +482,14 @@ bool wiphy_supports_iftype(struct wiphy *wiphy, uint=
32_t iftype)
>   	return wiphy->supported_iftypes & (1 << (iftype - 1));
>   }
>   =

> +const uint8_t *wiphy_get_supported_rates(struct wiphy *wiphy, unsigned i=
nt band)
> +{
> +	if (band >=3D L_ARRAY_SIZE(wiphy->supported_rates))
> +		return NULL;
> +
> +	return wiphy->supported_rates[band];
> +}
> +
>   uint32_t wiphy_state_watch_add(struct wiphy *wiphy,
>   				wiphy_state_watch_func_t func,
>   				void *user_data, wiphy_destroy_func_t destroy)
> @@ -622,20 +634,70 @@ static void parse_supported_frequencies(struct wiph=
y *wiphy,
>   	}
>   }
>   =

> +static uint8_t *parse_supported_rates(struct l_genl_attr *attr)
> +{
> +	uint16_t type;
> +	uint16_t len;
> +	const void *data;
> +	struct l_genl_attr nested;
> +	int count =3D 0;
> +	uint8_t *ret;
> +
> +	if (!l_genl_attr_recurse(attr, &nested))
> +		return NULL;
> +
> +	while (l_genl_attr_next(&nested, NULL, NULL, NULL))
> +		count++;
> +
> +	if (!l_genl_attr_recurse(attr, &nested))
> +		return NULL;
> +
> +	ret =3D l_malloc(count + 1);
> +	ret[count] =3D 0;

So I know you use this to obtain the array size using strlen later.  But =

man that is completely non-obvious.  Maybe you should just make the =

supported rates length an out parameter in wiphy_get_supported_rates.


Regards,
-Denis
--===============2818669866773611612==--

