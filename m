Content-Type: multipart/mixed; boundary="===============1788177309899774912=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 08/19] p2p: Add the Scan Phase
Date: Thu, 23 Apr 2020 18:24:36 +0200
Message-ID: <20200423162447.15750-8-andrew.zaborowski@intel.com>
In-Reply-To: <20200423162447.15750-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1788177309899774912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add some of the Device Discovery logic and the DBus API.  Device
Discovery is documented as having three states: the Scan Phase, the Find
Phase and the Listen State.

This patch adds the Scan Phase and the next patch adds the Listen State,
which will happen sequentially in a loop until discovery is stopped.

The Find Phase, which is documented as happening at the beginning of the
Discovery Phase, is incorporated into the Scan Phases.  The difference
between the two is that Find Phase scans all of the supported channels
while the Scan Phase only scans the three "social" channels.  In
practical terms the Find Phase would discover existing groups, which may
operate on any channel, while the Scan Phase will only discover P2P
Devices -- peers that are not in a group yet.  To cover existing groups,
we add a few "non-social" channels to each of our active scans
implementing the Scan Phases.
---
 src/p2p.c | 464 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 464 insertions(+)

diff --git a/src/p2p.c b/src/p2p.c
index f4e0965b..2955efe0 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -67,20 +67,44 @@ struct p2p_device {
 	l_dbus_property_complete_cb_t pending_complete;
 	struct l_dbus_message *pending_message;
 =

+	uint8_t listen_country[3];
+	uint8_t listen_oper_class;
+	uint32_t listen_channel;
+	uint32_t scan_id;
+	unsigned int chans_per_scan;
+	unsigned int scan_chan_idx;
+	struct l_queue *discovery_users;
 	struct l_queue *peer_list;
 =

 	bool enabled : 1;
 };
 =

+struct p2p_discovery_user {
+	char *client;
+	struct p2p_device *dev;
+	unsigned int disconnect_watch;
+};
+
 struct p2p_peer {
 	struct scan_bss *bss;
 	struct p2p_device *dev;
+	struct wsc_dbus wsc;
 	char *name;
 	struct wsc_primary_device_type primary_device_type;
+	const uint8_t *device_addr;
+	/* Whether peer is currently a GO */
+	bool group;
 };
 =

 static struct l_queue *p2p_device_list;
 =

+/*
+ * For now we only scan the common 2.4GHz channels, to be replaced with
+ * a query of actual allowed channels per band and reg-domain.
+ */
+static const int channels_social[] =3D { 1, 6, 11 };
+static const int channels_scan_2_4_other[] =3D { 2, 3, 4, 5, 7, 8, 9, 10 };
+
 static bool p2p_device_match(const void *a, const void *b)
 {
 	const struct p2p_device *dev =3D a;
@@ -99,6 +123,32 @@ static const char *p2p_device_get_path(const struct p2p=
_device *dev)
 	return wiphy_get_path(dev->wiphy);
 }
 =

+static bool p2p_discovery_user_match(const void *a, const void *b)
+{
+	const struct p2p_discovery_user *user =3D a;
+
+	return !strcmp(user->client, b);
+}
+
+static void p2p_discovery_user_free(void *data)
+{
+	struct p2p_discovery_user *user =3D data;
+
+	if (user->disconnect_watch)
+		l_dbus_remove_watch(dbus_get_bus(), user->disconnect_watch);
+
+	l_free(user->client);
+	l_free(user);
+}
+
+static bool p2p_peer_match(const void *a, const void *b)
+{
+	const struct p2p_peer *peer =3D a;
+	const uint8_t *addr =3D b;
+
+	return !memcmp(peer->bss->addr, addr, 6);
+}
+
 static const char *p2p_peer_get_path(const struct p2p_peer *peer)
 {
 	static char path[256];
@@ -129,6 +179,329 @@ static void p2p_peer_put(void *user_data)
 	p2p_peer_free(peer);
 }
 =

+/* TODO: convert to iovecs */
+static uint8_t *p2p_build_scan_ies(struct p2p_device *dev, uint8_t *buf,
+					size_t buf_len, size_t *out_len)
+{
+	struct p2p_probe_req p2p_info =3D {};
+	struct wsc_probe_request wsc_info =3D {};
+	L_AUTO_FREE_VAR(uint8_t *, p2p_ie) =3D NULL;
+	size_t p2p_ie_size;
+	uint8_t *wsc_data;
+	size_t wsc_data_size;
+	L_AUTO_FREE_VAR(uint8_t *, wsc_ie) =3D NULL;
+	size_t wsc_ie_size;
+
+	p2p_info.capability =3D dev->capability;
+	memcpy(p2p_info.listen_channel.country, dev->listen_country, 3);
+	p2p_info.listen_channel.oper_class =3D dev->listen_oper_class;
+	p2p_info.listen_channel.channel_num =3D dev->listen_channel;
+
+	/*
+	 * Note that through an attribute we can also request Group Owners
+	 * to send us info on clients within their groups and could also
+	 * show those on D-Bus.  Doesn't seem useful at this time but may
+	 * be desired at some point.
+	 */
+
+	p2p_ie =3D p2p_build_probe_req(&p2p_info, &p2p_ie_size);
+	if (!p2p_ie)
+		return NULL;
+
+	wsc_info.version2 =3D true;
+	wsc_info.request_type =3D WSC_REQUEST_TYPE_ENROLLEE_INFO;
+	wsc_info.config_methods =3D dev->device_info.wsc_config_methods;
+
+	if (!wsc_uuid_from_addr(dev->addr, wsc_info.uuid_e))
+		return NULL;
+
+	wsc_info.primary_device_type =3D dev->device_info.primary_device_type;
+	wsc_info.rf_bands =3D WSC_RF_BAND_2_4_GHZ;
+	wsc_info.association_state =3D WSC_ASSOCIATION_STATE_NOT_ASSOCIATED;
+	wsc_info.configuration_error =3D WSC_CONFIGURATION_ERROR_NO_ERROR;
+	wsc_info.device_password_id =3D WSC_DEVICE_PASSWORD_ID_DEFAULT;
+	l_strlcpy(wsc_info.device_name, dev->device_info.device_name,
+			sizeof(wsc_info.device_name));
+
+	wsc_data =3D wsc_build_probe_request(&wsc_info, &wsc_data_size);
+	if (!wsc_data)
+		return NULL;
+
+	wsc_ie =3D ie_tlv_encapsulate_wsc_payload(wsc_data, wsc_data_size,
+						&wsc_ie_size);
+	l_free(wsc_data);
+
+	if (!wsc_ie)
+		return NULL;
+
+	/* WFD and other service IEs go here */
+
+	if (buf_len < wsc_ie_size + p2p_ie_size)
+		return NULL;
+
+	memcpy(buf + 0, wsc_ie, wsc_ie_size);
+	memcpy(buf + wsc_ie_size, p2p_ie, p2p_ie_size);
+	*out_len =3D wsc_ie_size + p2p_ie_size;
+	return buf;
+}
+
+static void p2p_scan_destroy(void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+
+	dev->scan_id =3D 0;
+}
+
+#define CHANS_PER_SCAN_INITIAL	2
+#define CHANS_PER_SCAN		2
+
+static bool p2p_device_peer_add(struct p2p_device *dev, struct p2p_peer *p=
eer)
+{
+	if (!strlen(peer->name) || !l_utf8_validate(
+					peer->name, strlen(peer->name), NULL)) {
+		l_debug("Device name doesn't validate for bssid %s",
+			util_address_to_string(peer->bss->addr));
+		return false;
+	}
+
+	if (!l_dbus_object_add_interface(dbus_get_bus(),
+						p2p_peer_get_path(peer),
+						IWD_P2P_PEER_INTERFACE, peer)) {
+		l_debug("Unable to add the %s interface to %s",
+			IWD_P2P_PEER_INTERFACE, p2p_peer_get_path(peer));
+		return false;
+	}
+
+	if (!l_dbus_object_add_interface(dbus_get_bus(),
+						p2p_peer_get_path(peer),
+						L_DBUS_INTERFACE_PROPERTIES,
+						NULL)) {
+		l_dbus_unregister_object(dbus_get_bus(),
+						p2p_peer_get_path(peer));
+		l_debug("Unable to add the %s interface to %s",
+			L_DBUS_INTERFACE_PROPERTIES, p2p_peer_get_path(peer));
+		return false;
+	}
+
+	l_queue_push_tail(dev->peer_list, peer);
+
+	return true;
+}
+
+struct p2p_peer_move_data {
+	struct l_queue *new_list;
+	uint64_t now;
+};
+
+static bool p2p_peer_move_recent(void *data, void *user_data)
+{
+	struct p2p_peer *peer =3D data;
+	struct p2p_peer_move_data *move_data =3D user_data;
+
+	if (move_data->now > peer->bss->time_stamp + 30 * L_USEC_PER_SEC)
+		return false;	/* Old, keep on the list */
+
+	/* Recently seen or currently connected, move to the new list */
+	l_queue_push_tail(move_data->new_list, peer);
+	return true;
+}
+
+static bool p2p_peer_update_existing(struct scan_bss *bss,
+					struct l_queue *old_list,
+					struct l_queue *new_list)
+{
+	struct p2p_peer *peer;
+
+	peer =3D l_queue_remove_if(old_list, p2p_peer_match, bss->addr);
+	if (!peer)
+		return false;
+
+	/*
+	 * We've seen this peer already, only update the scan_bss object.
+	 * Do we need to update DBus properties?
+	 */
+	scan_bss_free(peer->bss);
+	peer->bss =3D bss;
+
+	l_queue_push_tail(new_list, peer);
+	return true;
+}
+
+static bool p2p_scan_notify(int err, struct l_queue *bss_list,
+				void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+	const struct l_queue_entry *entry;
+	struct l_queue *old_peer_list =3D dev->peer_list;
+	struct p2p_peer_move_data move_data;
+
+	if (err) {
+		l_debug("P2P scan failed: %s (%i)", strerror(-err), -err);
+		goto schedule;
+	}
+
+	dev->peer_list =3D l_queue_new();
+
+	for (entry =3D l_queue_get_entries(bss_list); entry;
+			entry =3D entry->next) {
+		struct scan_bss *bss =3D entry->data;
+		struct p2p_peer *peer;
+
+		if (bss->source_frame !=3D SCAN_BSS_PROBE_RESP ||
+				!bss->p2p_probe_resp_info) {
+			scan_bss_free(bss);
+			continue;
+		}
+
+		if (p2p_peer_update_existing(bss, old_peer_list,
+						dev->peer_list))
+			continue;
+
+		peer =3D l_new(struct p2p_peer, 1);
+		peer->dev =3D dev;
+		peer->bss =3D bss;
+		peer->name =3D l_strdup(bss->p2p_probe_resp_info->
+						device_info.device_name);
+		peer->primary_device_type =3D
+			bss->p2p_probe_resp_info->device_info.primary_device_type;
+		peer->group =3D
+			!!(bss->p2p_probe_resp_info->capability.group_caps &
+			   P2P_GROUP_CAP_GO);
+		/*
+		 * Both P2P Devices and GOs can send Probe Responses so the
+		 * frame's source address may not necessarily be the Device
+		 * Address, use what's in the obligatory Device Info.
+		 */
+		peer->device_addr =3D
+			bss->p2p_probe_resp_info->device_info.device_addr;
+
+		if (!p2p_device_peer_add(dev, peer))
+			p2p_peer_free(peer);
+	}
+
+	/*
+	 * old_peer_list now only contains peers not present in the new
+	 * results.  Move any peers seen in the last 30 secs to the new
+	 * dev->peer_list and unref only the remaining peers.
+	 */
+	move_data.new_list =3D dev->peer_list;
+	move_data.now =3D l_time_now();
+	l_queue_foreach_remove(old_peer_list, p2p_peer_move_recent, &move_data);
+	l_queue_destroy(old_peer_list, p2p_peer_put);
+	l_queue_destroy(bss_list, NULL);
+
+schedule:
+	/* TODO: move to listen state */
+	return true;
+}
+
+static bool p2p_device_scan_start(struct p2p_device *dev)
+{
+	struct scan_parameters params =3D {};
+	uint8_t buf[256];
+	unsigned int i;
+
+	wiphy_get_reg_domain_country(dev->wiphy, (char *) dev->listen_country);
+	dev->listen_country[2] =3D 4;	/* Table E-4 */
+	dev->listen_oper_class =3D 81;	/* 2.4 band */
+
+	params.extra_ie =3D p2p_build_scan_ies(dev, buf, sizeof(buf),
+						&params.extra_ie_size);
+	L_WARN_ON(!params.extra_ie);
+	params.flush =3D true;
+	/* P2P Wildcard SSID because we don't need legacy networks to reply */
+	params.ssid =3D "DIRECT-";
+	/*
+	 * Must send probe requests at 6Mb/s, OFDM only.  The no-CCK rates
+	 * flag forces the drivers to do exactly this for 2.4GHz frames.
+	 *
+	 * "- P2P Devices shall not use 11b rates (1, 2, 5.5, 11 Mbps) for data
+	 *   and management frames except:
+	 *    * Probe Request frames sent to both P2P Devices and non-P2P
+	 *      Devices.
+	 * - P2P Devices shall not respond to Probe Request frames that indicate
+	 *   support for 11b rates only.
+	 * Note 1 - This means that the P2P Group Owner transmits Beacon frames
+	 * using OFDM.
+	 * Note 2 - This means that the P2P Group Owner transmits Probe Response
+	 * frames using OFDM, including frames sent in response to Probe
+	 * Requests received at 11b rates from non 11b-only devices.
+	 * Note 3 - P2P Devices shall not include 11b rates in the list of
+	 * supported rates in Probe Request frame intended only for P2P Devices.
+	 * 11b rates may be included in the list of supported rates in Probe
+	 * Request frames intended for both P2P Devices and non-P2P Devices."
+	 */
+	params.no_cck_rates =3D true;
+	params.freqs =3D scan_freq_set_new();
+
+	for (i =3D 0; i < L_ARRAY_SIZE(channels_social); i++) {
+		int chan =3D channels_social[i];
+		uint32_t freq =3D scan_channel_to_freq(chan, SCAN_BAND_2_4_GHZ);
+
+		scan_freq_set_add(params.freqs, freq);
+	}
+
+	/*
+	 * Instead of doing a single Scan Phase at the beginning of the Device
+	 * Discovery and then strictly a Find Phase loop as defined in the
+	 * spec, mix both to keep watching for P2P groups on the non-social
+	 * channels, slowly going through a few channels@a time in each
+	 * Scan State iteration.  Scan dev->chans_per_scan channels each time,
+	 * use dev->scan_chan_idx to keep track of which channels we've
+	 * visited recently.
+	 */
+	for (i =3D 0; i < dev->chans_per_scan; i++) {
+		int idx =3D dev->scan_chan_idx++;
+		int chan =3D channels_scan_2_4_other[idx];
+		uint32_t freq =3D scan_channel_to_freq(chan, SCAN_BAND_2_4_GHZ);
+
+		if (dev->scan_chan_idx >=3D
+				L_ARRAY_SIZE(channels_scan_2_4_other)) {
+			dev->scan_chan_idx =3D 0;
+			/*
+			 * Do fewer channels per scan after we've initially
+			 * gone through the 2.4 band.
+			 */
+			dev->chans_per_scan =3D CHANS_PER_SCAN;
+		}
+
+		scan_freq_set_add(params.freqs, freq);
+	}
+
+	dev->scan_id =3D scan_active_full(dev->wdev_id, &params, NULL,
+					p2p_scan_notify, dev, p2p_scan_destroy);
+	scan_freq_set_free(params.freqs);
+
+	return dev->scan_id !=3D 0;
+}
+
+static void p2p_device_discovery_start(struct p2p_device *dev)
+{
+	if (dev->scan_id)
+		return;
+
+	dev->chans_per_scan =3D CHANS_PER_SCAN_INITIAL;
+	dev->scan_chan_idx =3D 0;
+
+	/*
+	 * 3.1.2.1.1: "The Listen Channel shall be chosen at the beginning of
+	 * the In-band Device Discovery"
+	 *
+	 * (Unless we're waiting for a GO Negotiation Request from a peer on
+	 * a known channel)
+	 */
+	dev->listen_channel =3D channels_social[l_getrandom_uint32() %
+					L_ARRAY_SIZE(channels_social)];
+
+	p2p_device_scan_start(dev);
+}
+
+static void p2p_device_discovery_stop(struct p2p_device *dev)
+{
+	if (dev->scan_id)
+		scan_cancel(dev->wdev_id, dev->scan_id);
+}
+
 static void p2p_device_enable_cb(struct l_genl_msg *msg, void *user_data)
 {
 	struct p2p_device *dev =3D user_data;
@@ -142,6 +515,9 @@ static void p2p_device_enable_cb(struct l_genl_msg *msg=
, void *user_data)
 =

 	dev->enabled =3D !dev->enabled;
 =

+	if (dev->enabled && !l_queue_isempty(dev->discovery_users))
+		p2p_device_discovery_start(dev);
+
 done:
 	dev->pending_complete(dbus_get_bus(), message,
 				error ? dbus_error_failed(message) :
@@ -168,6 +544,9 @@ static void p2p_device_start_stop(struct p2p_device *de=
v,
 {
 	struct l_genl_msg *cmd;
 =

+	if (dev->enabled)
+		p2p_device_discovery_stop(dev);
+
 	if (!dev->enabled)
 		cmd =3D l_genl_msg_new_sized(NL80211_CMD_START_P2P_DEVICE, 16);
 	else
@@ -365,6 +744,8 @@ struct p2p_device *p2p_device_update_from_genl(struct l=
_genl_msg *msg,
 =

 	l_debug("Created P2P device %" PRIx64, dev->wdev_id);
 =

+	scan_wdev_add(dev->wdev_id);
+
 	if (!l_dbus_object_add_interface(dbus_get_bus(),
 						p2p_device_get_path(dev),
 						IWD_P2P_INTERFACE, dev))
@@ -388,9 +769,12 @@ static void p2p_device_free(void *user_data)
 		dev->pending_complete =3D NULL;
 	}
 =

+	p2p_device_discovery_stop(dev);
 	l_dbus_unregister_object(dbus_get_bus(), p2p_device_get_path(dev));
 	l_queue_destroy(dev->peer_list, p2p_peer_put);
+	l_queue_destroy(dev->discovery_users, p2p_discovery_user_free);
 	l_genl_family_free(dev->nl80211); /* Cancels dev->start_stop_cmd_id */
+	scan_wdev_remove(dev->wdev_id);
 	l_free(dev);
 }
 =

@@ -535,6 +919,82 @@ static struct l_dbus_message *p2p_device_get_peers(str=
uct l_dbus *dbus,
 	return reply;
 }
 =

+static void p2p_device_discovery_disconnect(struct l_dbus *dbus, void *use=
r_data)
+{
+	struct p2p_discovery_user *user =3D user_data;
+	struct p2p_device *dev =3D user->dev;
+
+	l_debug("P2P Device Discovery user %s disconnected", user->client);
+
+	l_queue_remove(dev->discovery_users, user);
+	p2p_discovery_user_free(user);
+
+	if (l_queue_isempty(dev->discovery_users))
+		p2p_device_discovery_stop(dev);
+}
+
+static void p2p_device_discovery_destroy(void *user_data)
+{
+	struct p2p_discovery_user *user =3D user_data;
+
+	user->disconnect_watch =3D 0;
+}
+
+static struct l_dbus_message *p2p_device_request_discovery(struct l_dbus *=
dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+	struct p2p_discovery_user *user;
+	bool first_user =3D l_queue_isempty(dev->discovery_users);
+
+	if (!l_dbus_message_get_arguments(message, ""))
+		return dbus_error_invalid_args(message);
+
+	if (l_queue_find(dev->discovery_users, p2p_discovery_user_match,
+				l_dbus_message_get_sender(message)))
+		return dbus_error_already_exists(message);
+
+	user =3D l_new(struct p2p_discovery_user, 1);
+	user->client =3D l_strdup(l_dbus_message_get_sender(message));
+	user->dev =3D dev;
+	user->disconnect_watch =3D l_dbus_add_disconnect_watch(dbus,
+						user->client,
+						p2p_device_discovery_disconnect,
+						user,
+						p2p_device_discovery_destroy);
+	l_queue_push_tail(dev->discovery_users, user);
+
+	if (first_user && dev->enabled)
+		p2p_device_discovery_start(dev);
+
+	return l_dbus_message_new_method_return(message);
+}
+
+static struct l_dbus_message *p2p_device_release_discovery(struct l_dbus *=
dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+	struct p2p_discovery_user *user;
+
+	if (!l_dbus_message_get_arguments(message, ""))
+		return dbus_error_invalid_args(message);
+
+	user =3D l_queue_remove_if(dev->discovery_users,
+				p2p_discovery_user_match,
+				l_dbus_message_get_sender(message));
+	if (!user)
+		return dbus_error_not_found(message);
+
+	p2p_discovery_user_free(user);
+
+	if (l_queue_isempty(dev->discovery_users))
+		p2p_device_discovery_stop(dev);
+
+	return l_dbus_message_new_method_return(message);
+}
+
 static void p2p_interface_setup(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_property(interface, "Enabled", 0, "b",
@@ -547,6 +1007,10 @@ static void p2p_interface_setup(struct l_dbus_interfa=
ce *interface)
 					p2p_device_get_avail_conns, NULL);
 	l_dbus_interface_method(interface, "GetPeers", 0,
 				p2p_device_get_peers, "a(on)", "", "peers");
+	l_dbus_interface_method(interface, "RequestDiscovery", 0,
+				p2p_device_request_discovery, "", "");
+	l_dbus_interface_method(interface, "ReleaseDiscovery", 0,
+				p2p_device_release_discovery, "", "");
 }
 =

 static bool p2p_peer_get_name(struct l_dbus *dbus,
-- =

2.20.1

--===============1788177309899774912==--

