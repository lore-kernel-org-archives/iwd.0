Content-Type: multipart/mixed; boundary="===============2903119403137593675=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/5] rrm: add radio resource management module
Date: Mon, 04 Nov 2019 15:09:17 -0600
Message-ID: <5cdedc03-cb77-2f5d-42b4-a60ce5dfa9ab@gmail.com>
In-Reply-To: <20191029175043.27745-4-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2903119403137593675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/29/19 12:50 PM, James Prestwood wrote:
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
>   src/rrm.c   | 764 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 765 insertions(+)
>   create mode 100644 src/rrm.c
> =


<snip>

> +/*
> + * Basically the same as 802.11-2016 9.4.2.21.7
> + *
> + * Note: Not packed as this is only for saving values for response
> + */
> +struct rrm_beacon_req_info {
> +	uint8_t oper_class;
> +	uint8_t channel;	/* The single channel provided in request */
> +	uint8_t bssid[6];
> +	char *ssid;

ssid is a fixed length field, so you can store it that way, e.g. char [33];

> +};
> +
> +struct rrm_request_info {
> +	uint32_t ifindex;
> +	uint8_t from[6];
> +	uint8_t dialog_token; /* dialog token in Radio Measurement Request */
> +	uint8_t mtoken; /* token in measurement request element */
> +	uint8_t mode;
> +	uint8_t type;
> +
> +	/* TODO: once more measurements are supported this can be a union */
> +	struct rrm_beacon_req_info *beacon;
> +};

Why not use container_of and store rrm_request_info right in =

rrm_beacon_req_info.

> +
> +static uint64_t last_request_us;
> +static const uint8_t wildcard_bss[6] =3D { 0xff, 0xff, 0xff, 0xff, 0xff,=
 0xff };

This seems like a utility method candidate...

<snip>

> +
> +static void rrm_build_measurement_report(struct rrm_request_info *info,
> +				const void *report, size_t report_len,
> +				uint8_t *to)
> +{
> +	*to++ =3D IE_TYPE_MEASUREMENT_REPORT;
> +	*to++ =3D 3 + report_len;
> +	*to++ =3D info->mtoken;
> +	*to++ =3D 0;
> +	*to++ =3D info->type;
> +
> +	if (report)
> +		memcpy(to, report, report_len);
> +}
> +
> +static void rrm_register_frame_cb(struct l_genl_msg *msg, void *user_dat=
a)
> +{
> +	if (l_genl_msg_get_error(msg) < 0)
> +		l_error("Could not register frame watch type %04x: %i",
> +			L_PTR_TO_UINT(user_data), l_genl_msg_get_error(msg));
> +}
> +
> +static void rrm_register_frame(uint32_t ifindex)
> +{
> +	struct l_genl_msg *msg;
> +	uint16_t frame_type =3D 0x00d0;
> +	uint8_t prefix[] =3D { 0x05, 0x00 }; /* Radio Measurment Request */
> +
> +	msg =3D l_genl_msg_new_sized(NL80211_CMD_REGISTER_FRAME, 34);
> +
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &ifindex);
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME_TYPE, 2, &frame_type);
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME_MATCH,
> +					sizeof(prefix), prefix);
> +
> +	l_genl_family_send(nl80211, msg, rrm_register_frame_cb,
> +			L_UINT_TO_PTR(frame_type), NULL);
> +}
> +
> +static void rrm_netdev_watch(struct netdev *netdev,
> +				enum netdev_watch_event event, void *user_data)
> +{
> +	switch (event) {
> +	case NETDEV_WATCH_EVENT_NEW:
> +		rrm_register_frame(netdev_get_ifindex(netdev));

Might want to check that we're in station mode here.  You sort of do in =

the actual frame unicast watch callback, but not registering to it =

unless needed in the first place is even better.

Also, any reason for not using netdev_frame_watch_add?

> +		return;
> +	default:
> +		break;
> +	}
> +}
> +

<snip>

> +static bool rrm_handle_beacon_scan(struct rrm_request_info *info,
> +					bool passive)
> +{
> +	struct netdev *netdev =3D netdev_find(info->ifindex);
> +	struct scan_freq_set *freqs =3D scan_freq_set_new();
> +	struct scan_parameters params =3D { .freqs =3D freqs, .flush =3D true };
> +	enum scan_band band =3D scan_oper_class_to_band(NULL,
> +						info->beacon->oper_class);
> +	uint32_t freq;
> +	uint32_t scan_id;
> +
> +	freq =3D scan_channel_to_freq(info->beacon->channel, band);
> +	scan_freq_set_add(freqs, freq);
> +
> +	if (passive)
> +		scan_id =3D scan_passive(netdev_get_wdev_id(netdev), freqs,
> +						rrm_scan_triggered,
> +						rrm_scan_results, info,
> +						rrm_info_destroy);
> +	else
> +		scan_id =3D scan_active_full(netdev_get_wdev_id(netdev), &params,
> +						rrm_scan_triggered,
> +						rrm_scan_results, info,
> +						rrm_info_destroy);
> +
> +	scan_freq_set_free(freqs);

Should we be canceling the scan if station disconnects?

> +
> +	return scan_id !=3D 0;
> +}
> +

<snip>

Regards,
-Denis
--===============2903119403137593675==--

