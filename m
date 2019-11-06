Content-Type: multipart/mixed; boundary="===============6662126579409400384=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 2/3] rrm: add radio resource management module
Date: Wed, 06 Nov 2019 15:34:12 -0600
Message-ID: <fefac4d3-28be-6a56-a8c2-887e68765bd7@gmail.com>
In-Reply-To: <20191106175732.711-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6662126579409400384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/6/19 11:57 AM, James Prestwood wrote:
> This module takes care of radio measurements which an AP can request.
> There are many types of requests, and for now only beacon requests
> are supported.
> =

> IWD will filter certain types of beacon requests that are NOT
> supported:
> =

>   - AP channel reports. Only single channel requests will be supported
>   - Autonomous measurements. Only direct requests will be supported.
>     IWD will not accept requets to trigger reports under certain
>     conditions (SNR/RSSI thresholds, etc.)
>   - Timed measurements. Only immediate measurements will be performed.
>     The accuracy for timed measurements cannot be reliably guaranteed
>     due to kernel scheduling/queues.
>   - Full reporting detail. The AP can request the STA return the full
>     set of IEs in a beacon. IWD does not currently save all IEs, plus
>     there is quite a bit of complexity involved as certain IEs get
>     truncated, and there are other length limitations.
> =

> There are other limitations not specific to beacon requests:
> =

>   - IWD will support single measurement requests per report. Multiple
>     measurement request IEs can be included, but the reports will be
>     sent out separately.
> =

>   - IWD will limit the number of requests it responds to in a given
>     amount of time. As it stands now this is hard coded to 2 requests
>     per second maximum. This will prevent DoS attacks.
> =

>   - IWD will not accept any measurement requests from APs it is not
>     connected to, and will not accept any requests until connected.
> ---
>   Makefile.am |   1 +
>   src/rrm.c   | 786 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 787 insertions(+)
>   create mode 100644 src/rrm.c
> =

> -v2:
>   * Added a per-netdev 'rrm_state'. This holds values such as ifindex
>     wdev_id, connected address etc which will be used for all requests
>     on a given netdev
>   * Watch station and disable/enable rrm_state depending on if we get
>     connected or disconnected.
>   * Refactored rrm_request_info/rrm_beacon_req_info to avoid extra
>     allocations (using l_container_of)
>   * rrm_state also holds 'pending' requests and will ignore any
>     requests made when we have an outstanding request
>   * Track scan ID's and cancel if station becomes disconnected
> =


<snip>

> +static void rrm_station_watch_cb(enum station_state state, void *userdat=
a)
> +{
> +	struct rrm_state *rrm =3D userdata;
> +	struct station *station;
> +	struct scan_bss *bss;
> +
> +	switch (state) {
> +	case STATION_STATE_CONNECTED:
> +		station =3D station_find(rrm->ifindex);
> +		bss =3D station_get_connected_bss(station);
> +
> +		rrm->enabled =3D true;
> +		memcpy(rrm->connected_addr, bss->addr, 6);
> +		rrm->connected_freq =3D bss->frequency;

Why not just save the station pointer instead of carrying all this info?

> +
> +		break;
> +	case STATION_STATE_DISCONNECTED:

Also for DISCONNECTING?

> +		rrm->enabled =3D false;
> +
> +		rrm_cancel_pending(rrm);

All you really care about here is the cancelation logic.

> +		break;
> +	default:
> +		return;
> +	}
> +}
> +
> +static void rrm_state_destroy(void *data)
> +{
> +	struct rrm_state *rrm =3D data;
> +
> +	if (rrm->pending)
> +		rrm_info_destroy(rrm->pending);
> +
> +	l_free(rrm);
> +}
> +
> +static void rrm_new_state(struct netdev *netdev)
> +{
> +	struct rrm_state *rrm;
> +	uint16_t frame_type =3D 0x00d0;
> +	uint8_t prefix[] =3D { 0x05, 0x00 };
> +	struct station *station;
> +
> +	rrm =3D l_new(struct rrm_state, 1);
> +
> +	rrm->last_request =3D l_time_now();
> +	rrm->ifindex =3D netdev_get_ifindex(netdev);
> +	rrm->wdev_id =3D netdev_get_wdev_id(netdev);
> +
> +	netdev_frame_watch_add(netdev, frame_type, prefix, sizeof(prefix),
> +					rrm_frame_watch_cb, rrm);
> +
> +	station =3D station_find(rrm->ifindex);
> +	station_add_state_watch(station, rrm_station_watch_cb, rrm, NULL);

Shouldn't you be checking that station exists first?  Also, you have a =

bit of a chicken/egg problem since station is watching the same =

netdev_watch.  So by luck of the draw it may be getting notified (and =

thus created) after the rrm module.

How we get around this is unclear.  One way would be to check the iftype =

to be station and just assume that the station object comes around =

eventually.  Perhaps by lazy-instantiating the station watch only once =

an actual request arrives.

> +
> +	l_queue_push_head(states, rrm);
> +}
> +
> +static bool match_ifindex(const void *a, const void *b)
> +{
> +	const struct rrm_state *rrm =3D a;
> +	uint32_t ifindex =3D L_PTR_TO_UINT(b);
> +
> +	return rrm->ifindex =3D=3D ifindex;
> +}
> +
> +static void rrm_netdev_watch(struct netdev *netdev,
> +				enum netdev_watch_event event, void *user_data)
> +{
> +	struct rrm_state *rrm;
> +	uint32_t ifindex =3D netdev_get_ifindex(netdev);
> +
> +	switch (event) {
> +	case NETDEV_WATCH_EVENT_NEW:
> +		rrm_new_state(netdev);
> +		return;
> +	case NETDEV_WATCH_EVENT_DEL:
> +		rrm =3D l_queue_find(states, match_ifindex,
> +					L_UINT_TO_PTR(ifindex));
> +		if (!rrm)
> +			return;
> +
> +		rrm_cancel_pending(rrm);

Shouldn't you be freeing the rrm state?

> +		return;
> +	default:
> +		break;
> +	}
> +}
> +
> +static int rrm_init(void)
> +{
> +	struct l_genl *genl =3D iwd_get_genl();
> +
> +	states =3D l_queue_new();
> +
> +	nl80211 =3D l_genl_family_new(genl, NL80211_GENL_NAME);
> +
> +	netdev_watch =3D netdev_watch_add(rrm_netdev_watch, NULL, NULL);
> +
> +	return 0;
> +}
> +
> +static void rrm_exit(void)
> +{
> +	l_genl_family_free(nl80211);
> +	nl80211 =3D NULL;
> +
> +	netdev_watch_remove(netdev_watch);
> +
> +	l_queue_destroy(states, rrm_state_destroy);
> +}
> +
> +IWD_MODULE(rrm, rrm_init, rrm_exit);
> +IWD_MODULE_DEPENDS(rrm, netdev);
> =


Regards,
-Denis
--===============6662126579409400384==--

