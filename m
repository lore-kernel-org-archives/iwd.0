Content-Type: multipart/mixed; boundary="===============2517803934168821643=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 09/19] p2p: Add the Listen State
Date: Fri, 24 Apr 2020 12:08:50 -0500
Message-ID: <7c434d2b-dbc2-d252-b265-50e2f6df4611@gmail.com>
In-Reply-To: <20200423162447.15750-9-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2517803934168821643==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 4/23/20 11:24 AM, Andrew Zaborowski wrote:
> Start a remain-on-channel cmd implementing the Listen State, after each
> the Scan Phase implemented as an active scan.
> ---
>   src/p2p.c | 371 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 369 insertions(+), 2 deletions(-)
> =

> diff --git a/src/p2p.c b/src/p2p.c
> index 2955efe0..fd1ebb00 100644
> --- a/src/p2p.c
> +++ b/src/p2p.c
> @@ -70,9 +70,15 @@ struct p2p_device {
>   	uint8_t listen_country[3];
>   	uint8_t listen_oper_class;
>   	uint32_t listen_channel;
> +	unsigned int scan_interval;
> +	time_t next_scan_ts;
> +	struct l_timeout *scan_timeout;
>   	uint32_t scan_id;
>   	unsigned int chans_per_scan;
>   	unsigned int scan_chan_idx;
> +	uint64_t roc_cookie;
> +	bool have_roc_cookie;

Is the roc cookie up to the driver to provide? In theory nl80211 uses =

cfg80211_assign_cookie which can never be zero.  But if the drivers =

don't use that, ok.  Do you want to use a bitfield for the =

have_roc_cookie flag?

> +	unsigned int listen_duration;
>   	struct l_queue *discovery_users;
>   	struct l_queue *peer_list;
>   =

> @@ -97,6 +103,7 @@ struct p2p_peer {
>   };
>   =

>   static struct l_queue *p2p_device_list;
> +static uint32_t unicast_watch;
>   =

>   /*
>    * For now we only scan the common 2.4GHz channels, to be replaced with
> @@ -105,6 +112,11 @@ static struct l_queue *p2p_device_list;
>   static const int channels_social[] =3D { 1, 6, 11 };
>   static const int channels_scan_2_4_other[] =3D { 2, 3, 4, 5, 7, 8, 9, 1=
0 };
>   =

> +enum {
> +	FRAME_GROUP_DEFAULT =3D 0,
> +	FRAME_GROUP_LISTEN,
> +};
> +
>   static bool p2p_device_match(const void *a, const void *b)
>   {
>   	const struct p2p_device *dev =3D a;
> @@ -252,9 +264,170 @@ static void p2p_scan_destroy(void *user_data)
>   	dev->scan_id =3D 0;
>   }
>   =

> +#define SCAN_INTERVAL_MAX	3
> +#define SCAN_INTERVAL_STEP	1
>   #define CHANS_PER_SCAN_INITIAL	2
>   #define CHANS_PER_SCAN		2
>   =

> +static bool p2p_device_scan_start(struct p2p_device *dev);
> +static void p2p_device_roc_start(struct p2p_device *dev);
> +
> +static void p2p_device_roc_timeout(struct l_timeout *timeout, void *user=
_data)
> +{
> +	struct p2p_device *dev =3D user_data;
> +
> +	l_timeout_remove(dev->scan_timeout);
> +
> +	if (time(NULL) < dev->next_scan_ts) {
> +		/*
> +		 * dev->scan_timeout destroy function will have been called
> +		 * by now so it won't overwrite the new timeout set by
> +		 * p2p_device_roc_start.
> +		 */
> +		p2p_device_roc_start(dev);
> +		return;
> +	}
> +
> +	p2p_device_scan_start(dev);
> +}
> +
> +static void p2p_device_roc_cancel(struct p2p_device *dev, uint64_t *cook=
ie,
> +					bool *have_cookie, bool frame_tx)
> +{
> +	struct l_genl_msg *msg;
> +	enum nl80211_commands cmd =3D frame_tx ? NL80211_CMD_FRAME_WAIT_CANCEL :
> +		NL80211_CMD_CANCEL_REMAIN_ON_CHANNEL;
> +
> +	if (!*have_cookie)
> +		return;

???

Are you trying to pay 3-4 lines here to avoid paying one line in the caller?

> +
> +	l_debug("");
> +
> +	msg =3D l_genl_msg_new_sized(cmd, 32);
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_WDEV, 8, &dev->wdev_id);
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_COOKIE, 8, cookie);
> +	l_genl_family_send(dev->nl80211, msg, NULL, NULL, NULL);
> +
> +	*have_cookie =3D false;
> +}
> +
> +static void p2p_scan_timeout_destroy(void *user_data)
> +{
> +	struct p2p_device *dev =3D user_data;
> +
> +	dev->scan_timeout =3D NULL;
> +
> +	if (dev->nl80211) {
> +		/*
> +		 * Most likely when the timer expires the ROC period
> +		 * has finished but send a cancel command to make sure,
> +		 * as well as handle situations like disabling P2P.
> +		 */
> +		p2p_device_roc_cancel(dev, &dev->roc_cookie,
> +					&dev->have_roc_cookie, false);
> +	}
> +}
> +
> +static void p2p_device_roc_cb(struct l_genl_msg *msg, void *user_data)
> +{
> +	struct p2p_device *dev =3D user_data;
> +	struct l_genl_attr attr;
> +	uint16_t type;
> +	uint16_t len;
> +	const void *data;
> +	int error =3D l_genl_msg_get_error(msg);
> +
> +	l_debug("ROC: %s (%i)", strerror(-error), -error);
> +
> +	if (error)
> +		return;
> +
> +	if (!l_genl_attr_init(&attr, msg))
> +		return;
> +
> +	while (l_genl_attr_next(&attr, &type, &len, &data)) {
> +		switch (type) {
> +		case NL80211_ATTR_COOKIE:
> +			if (len !=3D 8)
> +				break;

nl80211util supports COOKIE extraction if you want to make your life easier

> +
> +			dev->roc_cookie =3D *(const uint64_t *) data;
> +			dev->have_roc_cookie =3D true;
> +
> +			if (!dev->scan_timeout)
> +				p2p_device_roc_cancel(dev, &dev->roc_cookie,
> +							&dev->have_roc_cookie,
> +							false);

So what is this doing and how would we get here?  Probably a comment is =

a good idea here...

> +
> +			break;
> +		}
> +	}
> +}
> +

<snip>

> @@ -475,11 +673,118 @@ static bool p2p_device_scan_start(struct p2p_devic=
e *dev)
>   	return dev->scan_id !=3D 0;
>   }
>   =

> +static void p2p_device_probe_cb(const struct mmpdu_header *mpdu,
> +				const void *body, size_t body_len,
> +				int rssi, void *user_data)
> +{
> +	struct p2p_device *dev =3D user_data;
> +	struct p2p_peer *peer;
> +	struct p2p_probe_req p2p_info;
> +	struct wsc_probe_request wsc_info;
> +	int r;
> +	uint8_t *wsc_payload;
> +	ssize_t wsc_len;
> +	struct scan_bss *bss;
> +	struct p2p_channel_attr *channel;
> +	enum scan_band band;
> +	uint32_t frequency;
> +
> +	l_debug("");
> +
> +	if (!dev->scan_timeout && !dev->scan_id)
> +		return;
> +
> +	wsc_payload =3D ie_tlv_extract_wsc_payload(body, body_len, &wsc_len);
> +	if (!wsc_payload)	/* Not a P2P Probe Req, ignore */
> +		return;
> +
> +	r =3D  wsc_parse_probe_request(wsc_payload, wsc_len, &wsc_info);
> +	l_free(wsc_payload);
> +
> +	if (r < 0) {
> +		l_error("Probe Request WSC IE parse error %s (%i)",
> +			strerror(-r), -r);
> +		return;
> +	}
> +
> +	r =3D p2p_parse_probe_req(body, body_len, &p2p_info);
> +	if (r < 0) {
> +		if (r =3D=3D -ENOENT)	/* Not a P2P Probe Req, ignore */
> +			return;
> +
> +		l_error("Probe Request P2P IE parse error %s (%i)",
> +			strerror(-r), -r);
> +		return;
> +	}
> +
> +	/*
> +	 * We don't currently have a use case for replying to Probe Requests
> +	 * except when waiting for a GO Negotiation Request from our target
> +	 * peer.
> +	 */
> +
> +	/*
> +	 * The peer's listen frequency may be different from ours.
> +	 * The Listen Channel attribute is optional but if neither
> +	 * it nor the Operating Channel are set then we have no way
> +	 * to contact that peer.  Ignore such peers.
> +	 */
> +	if (p2p_info.listen_channel.country[0])
> +		channel =3D &p2p_info.listen_channel;
> +	else if (p2p_info.operating_channel.country[0])
> +		channel =3D &p2p_info.operating_channel;
> +	else
> +		goto p2p_free;
> +
> +	band =3D scan_oper_class_to_band((const uint8_t *) channel->country,
> +					channel->oper_class);
> +	frequency =3D scan_channel_to_freq(channel->channel_num, band);
> +	if (!frequency)
> +		goto p2p_free;
> +
> +	bss =3D scan_bss_new_from_probe_req(mpdu, body, body_len, frequency,
> +						rssi);
> +	if (!bss)
> +		goto p2p_free;
> +
> +	bss->time_stamp =3D l_time_now();
> +
> +	if (p2p_peer_update_existing(bss, dev->peer_list, dev->peer_list))
> +		goto p2p_free;

Are you leaking bss here?

> +
> +	peer =3D l_new(struct p2p_peer, 1);
> +	peer->dev =3D dev;
> +	peer->bss =3D bss;
> +	peer->name =3D l_strdup(wsc_info.device_name);
> +	peer->primary_device_type =3D wsc_info.primary_device_type;
> +	peer->group =3D !!(p2p_info.capability.group_caps & P2P_GROUP_CAP_GO);
> +	/*
> +	 * The Device Info attribute is present conditionally so we can't get
> +	 * the Device Address from there.  In theory only P2P Devices send
> +	 * out Probe Requests, not P2P GOs, so we assume the source address
> +	 * is the Device Address.
> +	 */
> +	peer->device_addr =3D bss->addr;
> +
> +	if (!p2p_device_peer_add(dev, peer))
> +		p2p_peer_free(peer);
> +
> +	/*
> +	 * Note: check SSID/BSSID are wildcard values if present and
> +	 * reply with a Probe Response -- not useful in our current usage
> +	 * scenarios but required by the spec.

Should this be a TODO?

> +	 */
> +
> +p2p_free:
> +	p2p_clear_probe_req(&p2p_info);
> +}
> +
>   static void p2p_device_discovery_start(struct p2p_device *dev)
>   {
> -	if (dev->scan_id)
> +	if (dev->scan_timeout || dev->scan_id)
>   		return;
>   =

> +	dev->scan_interval =3D 1;
>   	dev->chans_per_scan =3D CHANS_PER_SCAN_INITIAL;
>   	dev->scan_chan_idx =3D 0;
>   =


<snip>

> @@ -1103,6 +1460,12 @@ static int p2p_init(void)
>   		l_error("Unable to register the %s interface",
>   			IWD_P2P_PEER_INTERFACE);
>   =

> +	unicast_watch =3D l_genl_add_unicast_watch(genl, NL80211_GENL_NAME,
> +							p2p_unicast_notify,
> +							NULL, NULL);
> +	if (!unicast_watch)
> +		l_error("Registering for unicast notification failed");
> +

I'm a bit lost why this is done through the unicast watch?  In =

nl80211_send_remain_on_chan_event(), both CMD_REMAIN_ON_CHANNEL and =

CMD_CANCEL_REMAIN_ON_CHANNEL are multicast on the "mlme" group?  I can't =

seem to find any instance where it would be unicast.

>   	p2p_device_list =3D l_queue_new();
>   =

>   	return 0;

<snip>

Regards,
-Denis
--===============2517803934168821643==--

