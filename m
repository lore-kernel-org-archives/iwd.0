Content-Type: multipart/mixed; boundary="===============9148609049538829063=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 2/3] rrm: add radio resource management module
Date: Wed, 06 Nov 2019 17:29:50 -0600
Message-ID: <6ac760bf-edb2-3769-fef1-459d2db759fc@gmail.com>
In-Reply-To: <20191106222520.27871-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9148609049538829063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

> +static void rrm_station_watch_cb(enum station_state state, void *userdat=
a)
> +{
> +	struct rrm_state *rrm =3D userdata;
> +
> +	switch (state) {
> +	case STATION_STATE_CONNECTED:
> +		rrm->enabled =3D true;

Can't you use station_get_state instead?

> +
> +		break;
> +	case STATION_STATE_DISCONNECTING:
> +	case STATION_STATE_DISCONNECTED:
> +		rrm->enabled =3D false;
> +
> +		rrm_cancel_pending(rrm);
> +		break;
> +	default:
> +		return;
> +	}
> +}
> +
> +static void rrm_frame_watch_cb(struct netdev *netdev,
> +				const struct mmpdu_header *mpdu,
> +				const void *body, size_t body_len,
> +				void *user_data)
> +{
> +	struct rrm_state *rrm =3D user_data;
> +	const uint8_t *request =3D body;
> +	uint8_t dialog_token;
> +	struct ie_tlv_iter iter;
> +	struct scan_bss *bss;
> +
> +	if (!rrm->station) {
> +		/*
> +		 * Just in case the station interface was not found during init
> +		 * we can try and find it here. If found, we also setup the
> +		 * station watch and set the correct enabled state.
> +		 */
> +		rrm->station =3D station_find(rrm->ifindex);
> +
> +		if (!rrm->station) {
> +			l_error("station interface could not be found");
> +			return;
> +		}
> +
> +		station_add_state_watch(rrm->station, rrm_station_watch_cb,
> +						rrm, NULL);
> +
> +		if (station_get_state(rrm->station) =3D=3D STATION_STATE_CONNECTED)
> +			rrm->enabled =3D true;
> +	}
> +
> +	/*
> +	 * Ignore if not connected or already have an outstanding request
> +	 */
> +	if (!rrm->enabled || rrm->pending)
> +		return;
> +
> +	bss =3D station_get_connected_bss(rrm->station);
> +
> +	if (memcmp(bss->addr, mpdu->address_2, 6))
> +		return;
> +
> +	if (body_len < 5)
> +		return;
> +
> +	if (request[0] !=3D 0x05)
> +		return;
> +
> +	if (request[1] !=3D 0x00)
> +		return;
> +
> +	/*
> +	 * We have reached our max requests per second, no point in continuing
> +	 */
> +	if (l_time_now() - rrm->last_request < MIN_MICROS_BETWEEN_REQUESTS) {
> +		l_debug("Max requests per second reached, ignoring request");
> +		return;
> +	}
> +
> +	dialog_token =3D request[2];
> +
> +	/* Update time regardless of success */
> +	rrm->last_request =3D l_time_now();
> +
> +	ie_tlv_iter_init(&iter, request + 5, body_len - 5);
> +
> +	while (ie_tlv_iter_next(&iter)) {
> +		const uint8_t *req;
> +		size_t req_len;
> +
> +		if (ie_tlv_iter_get_tag(&iter) !=3D IE_TYPE_MEASUREMENT_REQUEST)
> +			continue;
> +
> +		req =3D ie_tlv_iter_get_data(&iter);
> +		req_len =3D ie_tlv_iter_get_length(&iter);
> +
> +		if (req_len < 3)
> +			return;
> +
> +		switch (req[2]) {
> +		case 5: /* beacon */
> +			rrm_handle_beacon_request(rrm, dialog_token, req,
> +							req_len);
> +			break;
> +		default:
> +			return;
> +		}
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
> +
> +	if (netdev_get_iftype(netdev) !=3D NETDEV_IFTYPE_STATION)
> +		return;
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
> +	rrm->station =3D station_find(rrm->ifindex);
> +
> +	/*
> +	 * Station may not exist yet, if not we can try and initialize this
> +	 * once the first request comes in.
> +	 */
> +	if (rrm->station)
> +		station_add_state_watch(rrm->station, rrm_station_watch_cb,
> +					rrm, NULL);

This seems rather superfluous.  Why make your job and code harder? :)

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
> +
> +		l_queue_remove(states, rrm);

Please do not ever do this. l_queue_find and l_queue_remove in =

succession are just waste.  This should really be:

rrm =3D l_queue_remove_if...
if (rrm) {
	rrm_cancel
	rrm_state_destroy
}

> +		rrm_state_destroy(rrm);
> +
> +		return;
> +	default:
> +		break;
> +	}
> +}

Regards,
-Denis
--===============9148609049538829063==--

