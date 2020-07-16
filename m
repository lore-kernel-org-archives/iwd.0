Content-Type: multipart/mixed; boundary="===============3661537552955390146=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/4] p2p: Add the p2p.Display interface on WFD-capable peers
Date: Thu, 16 Jul 2020 02:10:16 +0200
Message-ID: <20200716001018.311387-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200716001018.311387-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3661537552955390146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If anyone's registered as implementing the WFD service, add the
net.connman.iwd.p2p.Display DBus interface on peer objects that are
WFD-capable and are available for a WFD Session.
---
 src/dbus.h |   1 +
 src/p2p.c  | 294 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 288 insertions(+), 7 deletions(-)

diff --git a/src/dbus.h b/src/dbus.h
index eaad1f66..045b1bcb 100644
--- a/src/dbus.h
+++ b/src/dbus.h
@@ -38,6 +38,7 @@
 #define IWD_P2P_INTERFACE "net.connman.iwd.p2p.Device"
 #define IWD_P2P_PEER_INTERFACE "net.connman.iwd.p2p.Peer"
 #define IWD_P2P_SERVICE_MANAGER_INTERFACE "net.connman.iwd.p2p.ServiceMana=
ger"
+#define IWD_P2P_WFD_INTERFACE "net.connman.iwd.p2p.Display"
 =

 #define IWD_BASE_PATH "/net/connman/iwd"
 #define IWD_AGENT_MANAGER_PATH IWD_BASE_PATH
diff --git a/src/p2p.c b/src/p2p.c
index 2afceb4d..f18d7dcd 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -132,6 +132,7 @@ struct p2p_peer {
 	char *name;
 	struct wsc_primary_device_type primary_device_type;
 	const uint8_t *device_addr;
+	struct p2p_wfd_properties *wfd;
 	/* Whether peer is currently a GO */
 	bool group;
 };
@@ -243,7 +244,10 @@ static void p2p_peer_put(void *user_data)
 {
 	struct p2p_peer *peer =3D user_data;
 =

-	/* Removes both interfaces, no need to call wsc_dbus_remove_interface */
+	/*
+	 * Removes all interfaces with one call, no need to call
+	 * wsc_dbus_remove_interface.
+	 */
 	l_dbus_unregister_object(dbus_get_bus(), p2p_peer_get_path(peer));
 	p2p_peer_free(peer);
 }
@@ -1371,6 +1375,109 @@ static void p2p_device_fill_channel_list(struct p2p=
_device *dev,
 	l_queue_push_tail(attr->channel_entries, channel_entry);
 }
 =

+static bool p2p_extract_wfd_properties(const uint8_t *ie, size_t ie_size,
+					struct p2p_wfd_properties *out)
+{
+	struct wfd_subelem_iter iter;
+	const uint8_t *devinfo =3D NULL;
+	const uint8_t *ext_caps =3D NULL;
+	const uint8_t *r2 =3D NULL;
+
+	if (!ie)
+		return false;
+
+	wfd_subelem_iter_init(&iter, ie, ie_size);
+
+	while (wfd_subelem_iter_next(&iter)) {
+		enum wfd_subelem_type type =3D wfd_subelem_iter_get_type(&iter);
+		size_t len =3D wfd_subelem_iter_get_length(&iter);
+		const uint8_t *data =3D wfd_subelem_iter_get_data(&iter);
+
+		switch (type) {
+#define SUBELEM_CHECK(var, expected_len, name)		\
+			if (len !=3D expected_len) {	\
+				l_debug(name " length wrong in WFD IE");\
+				return false;		\
+			}				\
+							\
+			if (var) {			\
+				l_debug("Duplicate" name " in WFD IE");\
+				return false;		\
+			}				\
+							\
+			var =3D data;
+		case WFD_SUBELEM_WFD_DEVICE_INFORMATION:
+			SUBELEM_CHECK(devinfo, 6, "Device Information");
+			break;
+		case WFD_SUBELEM_EXTENDED_CAPABILITY:
+			SUBELEM_CHECK(ext_caps, 2, "Extended Capability");
+			break;
+		case WFD_SUBELEM_R2_DEVICE_INFORMATION:
+			SUBELEM_CHECK(r2, 2, "R2 Device Information");
+			break;
+#undef SUBELEM_CHECK
+		default:
+			/* Skip unknown IEs */
+			break;
+		}
+	}
+
+	if (devinfo) {
+		uint16_t capability =3D l_get_be16(devinfo + 0);
+		bool source;
+		bool sink;
+		uint16_t port;
+
+		source =3D (capability & WFD_DEV_INFO_DEVICE_TYPE) =3D=3D
+			WFD_DEV_INFO_TYPE_SOURCE ||
+			(capability & WFD_DEV_INFO_DEVICE_TYPE) =3D=3D
+			WFD_DEV_INFO_TYPE_DUAL_ROLE;
+		sink =3D (capability & WFD_DEV_INFO_DEVICE_TYPE) =3D=3D
+			WFD_DEV_INFO_TYPE_PRIMARY_SINK ||
+			(capability & WFD_DEV_INFO_DEVICE_TYPE) =3D=3D
+			WFD_DEV_INFO_TYPE_DUAL_ROLE;
+
+		if (!source && !sink)
+			return false;
+
+		port =3D l_get_be16(devinfo + 2);
+
+		if (source && port =3D=3D 0) {
+			l_debug("0 port number in WFD IE Device Information");
+			return false;
+		}
+
+		memset(out, 0, sizeof(*out));
+		out->available =3D
+			(capability & WFD_DEV_INFO_SESSION_AVAILABILITY) =3D=3D
+			WFD_DEV_INFO_SESSION_AVAILABLE;
+		out->source =3D source;
+		out->sink =3D sink;
+		out->port =3D port;
+		out->cp =3D capability & WFD_DEV_INFO_CONTENT_PROTECTION_SUPPORT;
+		out->audio =3D !sink ||
+			!(capability & WFD_DEV_INFO_NO_AUDIO_AT_PRIMARY_SINK);
+	} else {
+		l_error("Device Information missing in WFD IE");
+		return false;
+	}
+
+	if (ext_caps && (l_get_be16(ext_caps) & 1))
+		out->uibc =3D 1;
+
+	if (r2) {
+		uint8_t role =3D l_get_be16(r2) & 3;
+
+		if ((out->source && role !=3D 0 && role !=3D 3) ||
+				(out->sink && role !=3D 1 && role !=3D 3))
+			l_debug("Invalid role in WFD R2 Device Information");
+		else
+			out->r2 =3D true;
+	}
+
+	return true;
+}
+
 static bool p2p_go_negotiation_confirm_cb(const struct mmpdu_header *mpdu,
 					const void *body, size_t body_len,
 					int rssi, struct p2p_device *dev)
@@ -2408,6 +2515,63 @@ static void p2p_device_roc_start(struct p2p_device *=
dev)
 		(int) dev->listen_channel, (int) duration);
 }
 =

+static void p2p_peer_update_wfd(struct p2p_peer *peer,
+				struct p2p_wfd_properties *new_wfd)
+{
+	struct p2p_wfd_properties *orig_wfd =3D peer->wfd;
+
+	if (!orig_wfd && !new_wfd)
+		return;
+
+	peer->wfd =3D new_wfd ? l_memdup(new_wfd, sizeof(*new_wfd)) : NULL;
+
+	if (!orig_wfd && new_wfd) {
+		l_dbus_object_add_interface(dbus_get_bus(),
+						p2p_peer_get_path(peer),
+						IWD_P2P_WFD_INTERFACE, peer);
+		return;
+	} else if (orig_wfd && !new_wfd) {
+		l_free(orig_wfd);
+		l_dbus_object_remove_interface(dbus_get_bus(),
+						p2p_peer_get_path(peer),
+						IWD_P2P_WFD_INTERFACE);
+		return;
+	}
+
+	if (orig_wfd->source !=3D new_wfd->source)
+		l_dbus_property_changed(dbus_get_bus(),
+					p2p_peer_get_path(peer),
+					IWD_P2P_WFD_INTERFACE, "Source");
+
+	if (orig_wfd->sink !=3D new_wfd->sink)
+		l_dbus_property_changed(dbus_get_bus(),
+					p2p_peer_get_path(peer),
+					IWD_P2P_WFD_INTERFACE, "Sink");
+
+	if (orig_wfd->port !=3D new_wfd->port)
+		l_dbus_property_changed(dbus_get_bus(),
+					p2p_peer_get_path(peer),
+					IWD_P2P_WFD_INTERFACE, "Port");
+
+	if (orig_wfd->audio !=3D new_wfd->audio)
+		l_dbus_property_changed(dbus_get_bus(),
+					p2p_peer_get_path(peer),
+					IWD_P2P_WFD_INTERFACE, "HasAudio");
+
+	if (orig_wfd->uibc !=3D new_wfd->uibc)
+		l_dbus_property_changed(dbus_get_bus(),
+					p2p_peer_get_path(peer),
+					IWD_P2P_WFD_INTERFACE, "HasUIBC");
+
+	if (orig_wfd->cp !=3D new_wfd->cp)
+		l_dbus_property_changed(dbus_get_bus(),
+					p2p_peer_get_path(peer),
+					IWD_P2P_WFD_INTERFACE,
+					"HasContentProtection");
+
+	l_free(orig_wfd);
+}
+
 static const char *p2p_peer_wsc_get_path(struct wsc_dbus *wsc)
 {
 	return p2p_peer_get_path(l_container_of(wsc, struct p2p_peer, wsc));
@@ -2433,6 +2597,8 @@ static void p2p_peer_wsc_remove(struct wsc_dbus *wsc)
 =

 static bool p2p_device_peer_add(struct p2p_device *dev, struct p2p_peer *p=
eer)
 {
+	struct p2p_wfd_properties wfd;
+
 	if (!strlen(peer->name) || !l_utf8_validate(
 					peer->name, strlen(peer->name), NULL)) {
 		l_debug("Device name doesn't validate for bssid %s",
@@ -2470,6 +2636,16 @@ static bool p2p_device_peer_add(struct p2p_device *d=
ev, struct p2p_peer *peer)
 		return false;
 	}
 =

+	/*
+	 * We need to either only show peers that are available for a WFD
+	 * session, or expose the availability information through a property,
+	 * which we are not doing right now.
+	 */
+	if (p2p_own_wfd && p2p_extract_wfd_properties(peer->bss->wfd,
+						peer->bss->wfd_size, &wfd) &&
+			wfd.available)
+		p2p_peer_update_wfd(peer, &wfd);
+
 	l_queue_push_tail(dev->peer_list, peer);
 =

 	return true;
@@ -2500,18 +2676,20 @@ static bool p2p_peer_update_existing(struct scan_bs=
s *bss,
 					struct l_queue *new_list)
 {
 	struct p2p_peer *peer;
+	struct p2p_wfd_properties wfd;
 =

 	peer =3D l_queue_remove_if(old_list, p2p_peer_match, bss->addr);
 	if (!peer)
 		return false;
 =

 	/*
-	 * We've seen this peer already, only update the scan_bss object.
-	 * We can do this even if peer =3D=3D peer->dev->conn_peer because
-	 * its .bss is not used by .conn_netdev or .conn_enrollee.
-	 * .conn_wsc_bss is used for both connections and it doesn't come
-	 * from the discovery scan results.
-	 * Do we need to update DBus properties?
+	 * We've seen this peer already, only update the scan_bss object
+	 * and WFD state.  We can update peer->bss even if
+	 * peer =3D=3D peer->dev->conn_peer because its .bss is not used by
+	 * .conn_netdev or .conn_enrollee.  .conn_wsc_bss is used for
+	 * both connections and it doesn't come from the discovery scan
+	 * results.
+	 * Some property changes may need to be notified here.
 	 */
 =

 	if (peer->device_addr =3D=3D peer->bss->addr)
@@ -2523,6 +2701,13 @@ static bool p2p_peer_update_existing(struct scan_bss=
 *bss,
 	scan_bss_free(peer->bss);
 	peer->bss =3D bss;
 =

+	if (p2p_own_wfd && p2p_extract_wfd_properties(bss->wfd, bss->wfd_size,
+							&wfd) &&
+			wfd.available)
+		p2p_peer_update_wfd(peer, &wfd);
+	else if (peer->wfd)
+		p2p_peer_update_wfd(peer, NULL);
+
 	l_queue_push_tail(new_list, peer);
 	return true;
 }
@@ -3700,6 +3885,94 @@ static void p2p_peer_interface_setup(struct l_dbus_i=
nterface *interface)
 				p2p_peer_dbus_disconnect, "", "");
 }
 =

+static bool p2p_peer_get_wfd_source(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct p2p_peer *peer =3D user_data;
+
+	l_dbus_message_builder_append_basic(builder, 'b', &peer->wfd->source);
+	return true;
+}
+
+static bool p2p_peer_get_wfd_sink(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct p2p_peer *peer =3D user_data;
+
+	l_dbus_message_builder_append_basic(builder, 'b', &peer->wfd->sink);
+	return true;
+}
+
+static bool p2p_peer_get_wfd_port(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct p2p_peer *peer =3D user_data;
+
+	if (!peer->wfd->source)
+		return false;
+
+	l_dbus_message_builder_append_basic(builder, 'q', &peer->wfd->port);
+	return true;
+}
+
+static bool p2p_peer_get_wfd_has_audio(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct p2p_peer *peer =3D user_data;
+
+	if (!peer->wfd->sink)
+		return false;
+
+	l_dbus_message_builder_append_basic(builder, 'b', &peer->wfd->audio);
+	return true;
+}
+
+static bool p2p_peer_get_wfd_has_uibc(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct p2p_peer *peer =3D user_data;
+
+	l_dbus_message_builder_append_basic(builder, 'b', &peer->wfd->uibc);
+	return true;
+}
+
+static bool p2p_peer_get_wfd_has_cp(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct p2p_peer *peer =3D user_data;
+
+	l_dbus_message_builder_append_basic(builder, 'b', &peer->wfd->cp);
+	return true;
+}
+
+static void p2p_wfd_interface_setup(struct l_dbus_interface *interface)
+{
+	l_dbus_interface_property(interface, "Source", 0, "b",
+					p2p_peer_get_wfd_source, NULL);
+	l_dbus_interface_property(interface, "Sink", 0, "b",
+					p2p_peer_get_wfd_sink, NULL);
+	l_dbus_interface_property(interface, "Port", 0, "q",
+					p2p_peer_get_wfd_port, NULL);
+	l_dbus_interface_property(interface, "HasAudio", 0, "b",
+					p2p_peer_get_wfd_has_audio, NULL);
+	l_dbus_interface_property(interface, "HasUIBC", 0, "b",
+					p2p_peer_get_wfd_has_uibc, NULL);
+	l_dbus_interface_property(interface, "HasContentProtection", 0, "b",
+					p2p_peer_get_wfd_has_cp, NULL);
+}
+
 static void p2p_own_wfd_free(void)
 {
 	const struct l_queue_entry *entry;
@@ -3902,6 +4175,12 @@ static int p2p_init(void)
 	p2p_dhcp_settings =3D l_settings_new();
 	p2p_device_list =3D l_queue_new();
 =

+	if (!l_dbus_register_interface(dbus, IWD_P2P_WFD_INTERFACE,
+					p2p_wfd_interface_setup,
+					NULL, false))
+		l_error("Unable to register the %s interface",
+			IWD_P2P_WFD_INTERFACE);
+
 	if (!l_dbus_register_interface(dbus, IWD_P2P_SERVICE_MANAGER_INTERFACE,
 					p2p_service_manager_interface_setup,
 					p2p_service_manager_destroy_cb, false))
@@ -3922,6 +4201,7 @@ static void p2p_exit(void)
 =

 	l_dbus_unregister_interface(dbus, IWD_P2P_INTERFACE);
 	l_dbus_unregister_interface(dbus, IWD_P2P_PEER_INTERFACE);
+	l_dbus_unregister_interface(dbus, IWD_P2P_WFD_INTERFACE);
 	l_dbus_unregister_interface(dbus, IWD_P2P_SERVICE_MANAGER_INTERFACE);
 	l_queue_destroy(p2p_device_list, p2p_device_free);
 	p2p_device_list =3D NULL;
-- =

2.25.1

--===============3661537552955390146==--

