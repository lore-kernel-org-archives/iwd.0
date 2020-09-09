Content-Type: multipart/mixed; boundary="===============0227435134595686581=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 14/17] ap: Pass extra IEs between mgmt frames and user
Date: Wed, 09 Sep 2020 15:25:21 -0500
Message-ID: <582c0a46-4b3d-f5f2-cdf0-74ac626ead5f@gmail.com>
In-Reply-To: <20200908234933.301439-14-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0227435134595686581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 9/8/20 6:49 PM, Andrew Zaborowski wrote:
> Add user callbacks to add extra IEs to the AP's beacons and other
> frames.  I considered a few ways for the user to pass this data
> without callbacks but so far this seems to be the easiest and most
> versatile way.
> =

> Similarly pass the string of IEs from STA association frames to the user
> through the AP events.  I dropped ap_event_station_added_data.rsn_ie
> because that probably would have not been very useful and the RSN IE
> is included in the IE array in any case.
> ---
>   src/ap.c | 57 +++++++++++++++++++++++++++++++++++++++++++++-----------
>   src/ap.h | 10 +++++++++-
>   2 files changed, 55 insertions(+), 12 deletions(-)
> =


<snip>

> @@ -505,7 +514,11 @@ static void ap_set_beacon_cb(struct l_genl_msg *msg,=
 void *user_data)
>   static void ap_update_beacon(struct ap_state *ap)
>   {
>   	struct l_genl_msg *cmd;
> -	uint8_t head[256], tail[256];
> +	size_t extra_ies_len =3D ap->ops->get_mgmt_frame_ies_len ?
> +		ap->ops->get_mgmt_frame_ies_len(MPDU_MANAGEMENT_SUBTYPE_BEACON,
> +						ap->user_data) : 0;
> +	uint8_t head[256];
> +	uint8_t tail[256 + extra_ies_len];
>   	size_t head_len, tail_len;
>   	uint64_t wdev_id =3D netdev_get_wdev_id(ap->netdev);
>   	static const uint8_t bcast_addr[6] =3D {

Given that this is semi-static, and the caller has to call ap_update_beacon =

anyway, wouldn't it make more sense to just have the caller pass in the ext=
ra =

ies so you could just use append_attrv() on the NL80211_ATTR_BEACON_TAIL?

Regards,
-Denis
--===============0227435134595686581==--

