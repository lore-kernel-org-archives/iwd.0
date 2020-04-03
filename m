Content-Type: multipart/mixed; boundary="===============4494637959397897322=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 08/17] p2p: Add the Listen State
Date: Fri, 03 Apr 2020 18:14:21 +0200
Message-ID: <20200403161430.14168-8-andrew.zaborowski@intel.com>
In-Reply-To: <20200403161430.14168-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4494637959397897322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Start a remain-on-channel cmd implementing the Listen State, after each
the Scan Phase implemented as an active scan.
---
 src/p2p.c | 371 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 369 insertions(+), 2 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index de70d1a8..d0e0d9ac 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -70,9 +70,15 @@ struct p2p_device {
 	uint8_t country[3];
 	uint8_t oper_class;
 	uint32_t listen_channel;
+	unsigned int scan_interval;
+	time_t next_scan_ts;
+	struct l_timeout *scan_timeout;
 	uint32_t scan_id;
 	unsigned int chans_per_scan;
 	unsigned int scan_chan_idx;
+	uint64_t roc_cookie;
+	bool have_roc_cookie;
+	unsigned int listen_duration;
 	struct l_queue *discovery_users;
 	struct l_queue *peer_list;
 =

@@ -97,6 +103,7 @@ struct p2p_peer {
 };
 =

 static struct l_queue *p2p_device_list;
+static uint32_t unicast_watch;
 =

 /*
  * For now we only scan the common 2.4GHz channels, to be replaced with
@@ -105,6 +112,11 @@ static struct l_queue *p2p_device_list;
 static const int channels_social[] =3D { 1, 6, 11 };
 static const int channels_scan_2_4_other[] =3D { 2, 3, 4, 5, 7, 8, 9, 10 };
 =

+enum {
+	FRAME_GROUP_DEFAULT =3D 0,
+	FRAME_GROUP_LISTEN,
+};
+
 struct device_type_category_info {
 	char *category_str;
 	unsigned int subcategory_max;
@@ -397,9 +409,170 @@ static void p2p_scan_destroy(void *user_data)
 	dev->scan_id =3D 0;
 }
 =

+#define SCAN_INTERVAL_MAX	3
+#define SCAN_INTERVAL_STEP	1
 #define CHANS_PER_SCAN_INITIAL	2
 #define CHANS_PER_SCAN		2
 =

+static bool p2p_device_scan_start(struct p2p_device *dev);
+static void p2p_device_roc_start(struct p2p_device *dev);
+
+static void p2p_device_roc_timeout(struct l_timeout *timeout, void *user_d=
ata)
+{
+	struct p2p_device *dev =3D user_data;
+
+	l_timeout_remove(dev->scan_timeout);
+
+	if (time(NULL) < dev->next_scan_ts) {
+		/*
+		 * dev->scan_timeout destroy function will have been called
+		 * by now so it won't overwrite the new timeout set by
+		 * p2p_device_roc_start.
+		 */
+		p2p_device_roc_start(dev);
+		return;
+	}
+
+	p2p_device_scan_start(dev);
+}
+
+static void p2p_device_roc_cancel(struct p2p_device *dev, uint64_t *cookie,
+					bool *have_cookie, bool frame_tx)
+{
+	struct l_genl_msg *msg;
+	enum nl80211_commands cmd =3D frame_tx ? NL80211_CMD_FRAME_WAIT_CANCEL :
+		NL80211_CMD_CANCEL_REMAIN_ON_CHANNEL;
+
+	if (!*have_cookie)
+		return;
+
+	l_debug("");
+
+	msg =3D l_genl_msg_new_sized(cmd, 32);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_WDEV, 8, &dev->wdev_id);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_COOKIE, 8, cookie);
+	l_genl_family_send(dev->nl80211, msg, NULL, NULL, NULL);
+
+	*have_cookie =3D false;
+}
+
+static void p2p_scan_timeout_destroy(void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+
+	dev->scan_timeout =3D NULL;
+
+	if (dev->nl80211) {
+		/*
+		 * Most likely when the timer expires the ROC period
+		 * has finished but send a cancel command to make sure,
+		 * as well as handle situations like disabling P2P.
+		 */
+		p2p_device_roc_cancel(dev, &dev->roc_cookie,
+					&dev->have_roc_cookie, false);
+	}
+}
+
+static void p2p_device_roc_cb(struct l_genl_msg *msg, void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+	struct l_genl_attr attr;
+	uint16_t type;
+	uint16_t len;
+	const void *data;
+	int error =3D l_genl_msg_get_error(msg);
+
+	l_debug("ROC: %s (%i)", strerror(-error), -error);
+
+	if (error)
+		return;
+
+	if (!l_genl_attr_init(&attr, msg))
+		return;
+
+	while (l_genl_attr_next(&attr, &type, &len, &data)) {
+		switch (type) {
+		case NL80211_ATTR_COOKIE:
+			if (len !=3D 8)
+				break;
+
+			dev->roc_cookie =3D *(const uint64_t *) data;
+			dev->have_roc_cookie =3D true;
+
+			if (!dev->scan_timeout)
+				p2p_device_roc_cancel(dev, &dev->roc_cookie,
+							&dev->have_roc_cookie,
+							false);
+
+			break;
+		}
+	}
+}
+
+static void p2p_device_roc_start(struct p2p_device *dev)
+{
+	struct l_genl_msg *msg;
+	uint32_t listen_freq;
+	uint32_t duration;
+	uint32_t cmd_id;
+
+	l_debug("");
+
+	/*
+	 * One second granularity is fine here because some randomess
+	 * is desired and the intervals don't have strictly defined
+	 * limits.
+	 */
+	duration =3D (dev->next_scan_ts - time(NULL)) * 1000;
+
+	if (duration < 200)
+		duration =3D 200;
+
+	/*
+	 * Driver max duration seems to be 5000ms or more for all drivers
+	 * except mac80211_hwsim where it is only 1000ms.
+	 */
+	if (duration > wiphy_get_max_roc_duration(dev->wiphy))
+		duration =3D wiphy_get_max_roc_duration(dev->wiphy);
+
+	/*
+	 * Some drivers seem to miss fewer frames if we start new requests
+	 * often.
+	 */
+	if (duration > 1000)
+		duration =3D 1000;
+
+	listen_freq =3D scan_channel_to_freq(dev->listen_channel,
+						SCAN_BAND_2_4_GHZ);
+
+	msg =3D l_genl_msg_new_sized(NL80211_CMD_REMAIN_ON_CHANNEL, 64);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_WDEV, 8, &dev->wdev_id);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY_FREQ, 4, &listen_freq);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_DURATION, 4, &duration);
+
+	cmd_id =3D l_genl_family_send(dev->nl80211, msg, p2p_device_roc_cb, dev,
+					NULL);
+	if (!cmd_id)
+		l_genl_msg_unref(msg);
+
+	/*
+	 * Time out after @duration ms independent of whether we were able to
+	 * start the ROC command.  If we receive the CMD_REMAIN_ON_CHANNEL
+	 * event we'll update the timeout to give the ROC command enough time
+	 * to finish.  On an error or if we time out before the ROC command
+	 * even starts, we'll just retry after @duration ms so we don't even
+	 * need to handle errors specifically.
+	 */
+	dev->scan_timeout =3D l_timeout_create_ms(duration,
+						p2p_device_roc_timeout, dev,
+						p2p_scan_timeout_destroy);
+	dev->listen_duration =3D duration;
+	dev->have_roc_cookie =3D false;
+
+	l_debug("started a ROC command on channel %i for %i ms",
+		(int) dev->listen_channel, (int) duration);
+}
+
 static bool p2p_device_peer_add(struct p2p_device *dev, struct p2p_peer *p=
eer)
 {
 	if (!strlen(peer->name) || !l_utf8_validate(
@@ -536,7 +709,32 @@ static bool p2p_scan_notify(int err, struct l_queue *b=
ss_list,
 	l_queue_destroy(bss_list, NULL);
 =

 schedule:
-	/* TODO: move to listen state */
+	/*
+	 * Calculate interval between now and when we want the next active
+	 * scan to start.  Keep issuing Remain-on-Channel commands of
+	 * maximum duration until it's time to start the new scan.
+	 * The listen periods are actually like a passive scan except that
+	 * instead of listening for Beacons only, we also look at Probe
+	 * Requests and Probe Responses because they, too, carry P2P IEs
+	 * with all the information we need about peer devices.  Beacons
+	 * also do, in case of GOs, but we will already get the same
+	 * information from the Probe Responses and (even if we can
+	 * receive the beacons in userspace in the first place) we don't
+	 * want to handle so many frames.
+	 *
+	 * According to 3.1.2.1.1 we shall be available in listen state
+	 * during Find for at least 500ms continuously at least once in
+	 * every 5s.  According to 3.1.2.1.3, the Listen State lasts for
+	 * between 1 and 3 one-hundred TU Intervals.
+	 *
+	 * The Search State duration is implementation dependent.
+	 */
+	if (dev->scan_interval < SCAN_INTERVAL_MAX)
+		dev->scan_interval +=3D SCAN_INTERVAL_STEP;
+
+	dev->next_scan_ts =3D time(NULL) + dev->scan_interval;
+
+	p2p_device_roc_start(dev);
 	return true;
 }
 =

@@ -616,11 +814,118 @@ static bool p2p_device_scan_start(struct p2p_device =
*dev)
 	return dev->scan_id !=3D 0;
 }
 =

+static void p2p_device_probe_cb(const struct mmpdu_header *mpdu,
+				const void *body, size_t body_len,
+				int rssi, void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+	struct p2p_peer *peer;
+	struct p2p_probe_req p2p_info;
+	struct wsc_probe_request wsc_info;
+	int r;
+	uint8_t *wsc_payload;
+	ssize_t wsc_len;
+	struct scan_bss *bss;
+	struct p2p_channel_attr *channel;
+	enum scan_band band;
+	uint32_t frequency;
+
+	l_debug("");
+
+	if (!dev->scan_timeout && !dev->scan_id)
+		return;
+
+	wsc_payload =3D ie_tlv_extract_wsc_payload(body, body_len, &wsc_len);
+	if (!wsc_payload)	/* Not a P2P Probe Req, ignore */
+		return;
+
+	r =3D  wsc_parse_probe_request(wsc_payload, wsc_len, &wsc_info);
+	l_free(wsc_payload);
+
+	if (r < 0) {
+		l_error("Probe Request WSC IE parse error %s (%i)",
+			strerror(-r), -r);
+		return;
+	}
+
+	r =3D p2p_parse_probe_req(body, body_len, &p2p_info);
+	if (r < 0) {
+		if (r =3D=3D -ENOENT)	/* Not a P2P Probe Req, ignore */
+			return;
+
+		l_error("Probe Request P2P IE parse error %s (%i)",
+			strerror(-r), -r);
+		return;
+	}
+
+	/*
+	 * We don't currently have a use case for replying to Probe Requests
+	 * except when waiting for a GO Negotiation Request from our target
+	 * peer.
+	 */
+
+	/*
+	 * The peer's listen frequency may be different from ours.
+	 * The Listen Channel attribute is optional but if neither
+	 * it nor the Operating Channel are set then we have no way
+	 * to contact that peer.  Ignore such peers.
+	 */
+	if (p2p_info.listen_channel.country[0])
+		channel =3D &p2p_info.listen_channel;
+	else if (p2p_info.operating_channel.country[0])
+		channel =3D &p2p_info.operating_channel;
+	else
+		goto p2p_free;
+
+	band =3D scan_oper_class_to_band((const uint8_t *) channel->country,
+					channel->oper_class);
+	frequency =3D scan_channel_to_freq(channel->channel_num, band);
+	if (!frequency)
+		goto p2p_free;
+
+	bss =3D scan_bss_new_from_probe_req(mpdu, body, body_len, frequency,
+						rssi);
+	if (!bss)
+		goto p2p_free;
+
+	bss->time_stamp =3D l_time_now();
+
+	if (p2p_peer_update_existing(bss, dev->peer_list, dev->peer_list))
+		goto p2p_free;
+
+	peer =3D l_new(struct p2p_peer, 1);
+	peer->dev =3D dev;
+	peer->bss =3D bss;
+	peer->name =3D l_strdup(wsc_info.device_name);
+	peer->primary_device_type =3D wsc_info.primary_device_type;
+	peer->group =3D !!(p2p_info.capability.group_caps & P2P_GROUP_CAP_GO);
+	/*
+	 * The Device Info attribute is present conditionally so we can't get
+	 * the Device Address from there.  In theory only P2P Devices send
+	 * out Probe Requests, not P2P GOs, so we assume the source address
+	 * is the Device Address.
+	 */
+	peer->device_addr =3D bss->addr;
+
+	if (!p2p_device_peer_add(dev, peer))
+		p2p_peer_free(peer);
+
+	/*
+	 * Note: check SSID/BSSID are wildcard values if present and
+	 * reply with a Probe Response -- not useful in our current usage
+	 * scenarios but required by the spec.
+	 */
+
+p2p_free:
+	p2p_clear_probe_req(&p2p_info);
+}
+
 static void p2p_device_discovery_start(struct p2p_device *dev)
 {
-	if (dev->scan_id)
+	if (dev->scan_timeout || dev->scan_id)
 		return;
 =

+	dev->scan_interval =3D 1;
 	dev->chans_per_scan =3D CHANS_PER_SCAN_INITIAL;
 	dev->scan_chan_idx =3D 0;
 =

@@ -635,13 +940,26 @@ static void p2p_device_discovery_start(struct p2p_dev=
ice *dev)
 					L_ARRAY_SIZE(channels_social)];
 	dev->oper_class =3D 81;
 =

+	frame_watch_add(dev->wdev_id, FRAME_GROUP_LISTEN, 0x0040,
+			(uint8_t *) "", 0, p2p_device_probe_cb, dev, NULL);
+
 	p2p_device_scan_start(dev);
 }
 =

 static void p2p_device_discovery_stop(struct p2p_device *dev)
 {
+	dev->scan_interval =3D 0;
+
 	if (dev->scan_id)
 		scan_cancel(dev->wdev_id, dev->scan_id);
+
+	if (dev->scan_timeout)
+		l_timeout_remove(dev->scan_timeout);
+
+	p2p_device_roc_cancel(dev, &dev->roc_cookie, &dev->have_roc_cookie,
+				false);
+
+	frame_watch_group_remove(dev->wdev_id, FRAME_GROUP_LISTEN);
 }
 =

 static void p2p_device_enable_cb(struct l_genl_msg *msg, void *user_data)
@@ -1313,8 +1631,47 @@ static void p2p_peer_interface_setup(struct l_dbus_i=
nterface *interface)
 					p2p_peer_get_connected, NULL);
 }
 =

+static void p2p_unicast_notify(struct l_genl_msg *msg, void *user_data)
+{
+	struct p2p_device *dev;
+	uint64_t wdev_id;
+	uint64_t cookie;
+	uint8_t cmd =3D l_genl_msg_get_command(msg);
+
+	if (nl80211_parse_attrs(msg, NL80211_ATTR_WDEV, &wdev_id,
+				NL80211_ATTR_COOKIE, &cookie,
+				NL80211_ATTR_UNSPEC) < 0)
+			return;
+
+	dev =3D p2p_device_find(wdev_id);
+	if (!dev)
+		return;
+
+	switch (cmd) {
+	case NL80211_CMD_REMAIN_ON_CHANNEL:
+		if (!dev->have_roc_cookie || cookie !=3D dev->roc_cookie)
+			break;
+
+		if (!dev->scan_timeout)
+			break;
+
+		/*
+		 * The Listen phase is actually starting here, update the
+		 * timeout so we know more or less when it ends.
+		 */
+		l_debug("ROC started");
+		l_timeout_modify_ms(dev->scan_timeout, dev->listen_duration);
+		break;
+	case NL80211_CMD_CANCEL_REMAIN_ON_CHANNEL:
+		/* TODO */
+		break;
+	}
+}
+
 static int p2p_init(void)
 {
+	struct l_genl *genl =3D iwd_get_genl();
+
 	if (!l_dbus_register_interface(dbus_get_bus(),
 					IWD_P2P_INTERFACE,
 					p2p_interface_setup,
@@ -1329,6 +1686,12 @@ static int p2p_init(void)
 		l_error("Unable to register the %s interface",
 			IWD_P2P_PEER_INTERFACE);
 =

+	unicast_watch =3D l_genl_add_unicast_watch(genl, NL80211_GENL_NAME,
+							p2p_unicast_notify,
+							NULL, NULL);
+	if (!unicast_watch)
+		l_error("Registering for unicast notification failed");
+
 	p2p_device_list =3D l_queue_new();
 =

 	return 0;
@@ -1336,6 +1699,10 @@ static int p2p_init(void)
 =

 static void p2p_exit(void)
 {
+	struct l_genl *genl =3D iwd_get_genl();
+
+	l_genl_remove_unicast_watch(genl, unicast_watch);
+	unicast_watch =3D 0;
 	l_dbus_unregister_interface(dbus_get_bus(), IWD_P2P_INTERFACE);
 	l_dbus_unregister_interface(dbus_get_bus(), IWD_P2P_PEER_INTERFACE);
 	l_queue_destroy(p2p_device_list, p2p_device_free);
-- =

2.20.1

--===============4494637959397897322==--

