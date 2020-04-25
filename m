Content-Type: multipart/mixed; boundary="===============2338421292968293807=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 02/11] p2p: Add the WSC interface on peer DBus objects
Date: Sat, 25 Apr 2020 11:09:25 +0200
Message-ID: <20200425090934.22285-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200425090934.22285-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2338421292968293807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add net.connman.iwd.SimpleConfiguration interfaces to peer objects on
DBus and handle method calls.  Building and transmitting the actual
action frames to start the connection sequence is done in the following
commits.
---
 src/p2p.c | 290 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 288 insertions(+), 2 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index 70aa2f02..e758511f 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -81,6 +81,12 @@ struct p2p_device {
 	struct l_queue *discovery_users;
 	struct l_queue *peer_list;
 =

+	struct p2p_peer *conn_peer;
+	uint16_t conn_config_method;
+	char *conn_pin;
+	uint8_t conn_addr[6];
+	uint16_t conn_password_id;
+
 	bool enabled : 1;
 	bool have_roc_cookie : 1;
 };
@@ -186,10 +192,14 @@ static void p2p_peer_put(void *user_data)
 {
 	struct p2p_peer *peer =3D user_data;
 =

+	/* Removes both interfaces, no need to call wsc_dbus_remove_interface */
 	l_dbus_unregister_object(dbus_get_bus(), p2p_peer_get_path(peer));
 	p2p_peer_free(peer);
 }
 =

+static void p2p_device_discovery_start(struct p2p_device *dev);
+static void p2p_device_discovery_stop(struct p2p_device *dev);
+
 /* TODO: convert to iovecs */
 static uint8_t *p2p_build_scan_ies(struct p2p_device *dev, uint8_t *buf,
 					size_t buf_len, size_t *out_len)
@@ -256,6 +266,61 @@ static uint8_t *p2p_build_scan_ies(struct p2p_device *=
dev, uint8_t *buf,
 	return buf;
 }
 =

+static void p2p_connection_reset(struct p2p_device *dev)
+{
+	struct p2p_peer *peer =3D dev->conn_peer;
+
+	if (!peer)
+		return;
+
+	/*
+	 * conn_peer is currently not refcounted and we make sure it's always
+	 * on the dev->peer_list so we can just drop our reference.  Since we
+	 * may not have been scanning for a while, don't drop the peer object
+	 * now just because it's not been seen in scan results recently, its
+	 * age will be checked on the next scan.
+	 */
+	dev->conn_peer =3D NULL;
+	dev->connections_left++;
+
+	if (dev->conn_pin) {
+		explicit_bzero(dev->conn_pin, strlen(dev->conn_pin));
+		l_free(dev->conn_pin);
+		dev->conn_pin =3D NULL;
+	}
+
+	l_dbus_property_changed(dbus_get_bus(), p2p_device_get_path(dev),
+				IWD_P2P_INTERFACE, "AvailableConnections");
+
+	if (!dev->enabled || (dev->enabled && dev->start_stop_cmd_id)) {
+		/*
+		 * The device has been disabled in the mean time, all peers
+		 * have been removed except this one.  Now it's safe to
+		 * drop this peer from the scan results too.
+		 */
+		l_queue_destroy(dev->peer_list, p2p_peer_put);
+		dev->peer_list =3D NULL;
+	}
+
+	if (dev->enabled && !dev->start_stop_cmd_id &&
+			!l_queue_isempty(dev->discovery_users))
+		p2p_device_discovery_start(dev);
+}
+
+static void p2p_connect_failed(struct p2p_device *dev)
+{
+	struct p2p_peer *peer =3D dev->conn_peer;
+
+	if (!peer)
+		return;
+
+	if (peer->wsc.pending_connect)
+		dbus_pending_reply(&peer->wsc.pending_connect,
+				dbus_error_failed(peer->wsc.pending_connect));
+
+	p2p_connection_reset(dev);
+}
+
 static void p2p_scan_destroy(void *user_data)
 {
 	struct p2p_device *dev =3D user_data;
@@ -263,6 +328,165 @@ static void p2p_scan_destroy(void *user_data)
 	dev->scan_id =3D 0;
 }
 =

+static void p2p_start_go_negotiation(struct p2p_device *dev)
+{
+	/* TODO: start GO Negotiation */
+}
+
+static void p2p_start_provision_discovery(struct p2p_device *dev)
+{
+	/* TODO: start Provision Discovery */
+}
+
+static bool p2p_peer_get_info(struct p2p_peer *peer,
+				uint16_t *wsc_config_methods,
+				struct p2p_capability_attr **capability)
+{
+	struct wsc_probe_request wsc_info;
+
+	switch (peer->bss->source_frame) {
+	case SCAN_BSS_PROBE_RESP:
+		if (!peer->bss->p2p_probe_resp_info)
+			return false;
+
+		if (wsc_config_methods)
+			*wsc_config_methods =3D peer->bss->p2p_probe_resp_info->
+				device_info.wsc_config_methods;
+
+		*capability =3D &peer->bss->p2p_probe_resp_info->capability;
+		return true;
+	case SCAN_BSS_PROBE_REQ:
+		if (!peer->bss->p2p_probe_req_info || !peer->bss->wsc)
+			return false;
+
+		if (wsc_parse_probe_request(peer->bss->wsc, peer->bss->wsc_size,
+						&wsc_info) < 0)
+			return false;
+
+		if (wsc_config_methods)
+			*wsc_config_methods =3D wsc_info.config_methods;
+
+		*capability =3D &peer->bss->p2p_probe_req_info->capability;
+		return true;
+	case SCAN_BSS_BEACON:
+		if (!peer->bss->p2p_beacon_info || !peer->bss->wsc)
+			return false;
+
+		if (wsc_parse_probe_request(peer->bss->wsc, peer->bss->wsc_size,
+						&wsc_info) < 0)
+			return false;
+
+		if (wsc_config_methods)
+			*wsc_config_methods =3D wsc_info.config_methods;
+
+		*capability =3D &peer->bss->p2p_beacon_info->capability;
+		break;
+	}
+
+	return false;
+}
+
+static void p2p_peer_connect(struct p2p_peer *peer, const char *pin)
+{
+	struct p2p_device *dev =3D peer->dev;
+	uint16_t wsc_config_methods;
+	struct p2p_capability_attr *capability;
+	struct l_dbus_message *message =3D peer->wsc.pending_connect;
+	struct l_dbus_message *reply;
+
+	if (dev->conn_peer) {
+		reply =3D dbus_error_busy(message);
+		goto send_error;
+	}
+
+	/*
+	 * Step 1, check if the device indicates it supports our WSC method
+	 * and check other flags to make sure a connection is possible.
+	 */
+	if (!p2p_peer_get_info(peer, &wsc_config_methods, &capability)) {
+		reply =3D dbus_error_failed(message);
+		goto send_error;
+	}
+
+	dev->conn_config_method =3D pin ? WSC_CONFIGURATION_METHOD_KEYPAD :
+		WSC_CONFIGURATION_METHOD_PUSH_BUTTON;
+	dev->conn_password_id =3D pin ?
+		(strlen(pin) =3D=3D 4 || wsc_pin_is_checksum_valid(pin) ?
+		 WSC_DEVICE_PASSWORD_ID_DEFAULT :
+		 WSC_DEVICE_PASSWORD_ID_USER_SPECIFIED) :
+		WSC_DEVICE_PASSWORD_ID_PUSH_BUTTON;
+
+	if (!(wsc_config_methods & dev->conn_config_method)) {
+		reply =3D dbus_error_not_supported(message);
+		goto send_error;
+	}
+
+	if (capability->device_caps & P2P_DEVICE_CAP_DEVICE_LIMIT) {
+		reply =3D dbus_error_not_supported(message);
+		goto send_error;
+	}
+
+	if (capability->group_caps & P2P_GROUP_CAP_GROUP_LIMIT) {
+		reply =3D dbus_error_not_supported(message);
+		goto send_error;
+	}
+
+	if (capability->group_caps & P2P_GROUP_CAP_GROUP_FORMATION) {
+		reply =3D dbus_error_busy(message);
+		goto send_error;
+	}
+
+	p2p_device_discovery_stop(dev);
+
+	/* Generate the interface address for our P2P-Client connection */
+	wiphy_generate_random_address(dev->wiphy, dev->conn_addr);
+
+	dev->conn_peer =3D peer; /* No ref counting so just set the pointer */
+	dev->conn_pin =3D l_strdup(pin);
+	dev->connections_left--;
+	l_dbus_property_changed(dbus_get_bus(), p2p_device_get_path(dev),
+				IWD_P2P_INTERFACE, "AvailableConnections");
+
+	/*
+	 * Step 2, if peer is already a GO then send the Provision Discovery
+	 * before doing WSC.  If it's not then do Provision Discovery
+	 * optionally as seems to be required by some implementations, and
+	 * start GO negotiation following that.
+	 * TODO: Add a AlwaysUsePD config setting.
+	 */
+	if (dev->conn_peer->group)
+		p2p_start_provision_discovery(dev);
+	else
+		p2p_start_go_negotiation(dev);
+
+	return;
+
+send_error:
+	dbus_pending_reply(&peer->wsc.pending_connect, reply);
+}
+
+static void p2p_peer_disconnect(struct p2p_peer *peer)
+{
+	struct p2p_device *dev =3D peer->dev;
+	struct l_dbus_message *message =3D peer->wsc.pending_cancel;
+	struct l_dbus_message *reply;
+
+	if (dev->conn_peer !=3D peer) {
+		reply =3D dbus_error_not_connected(message);
+		goto send_reply;
+	}
+
+	if (peer->wsc.pending_connect)
+		dbus_pending_reply(&peer->wsc.pending_connect,
+				dbus_error_aborted(peer->wsc.pending_connect));
+
+	p2p_connection_reset(dev);
+	reply =3D l_dbus_message_new_method_return(message);
+
+send_reply:
+	dbus_pending_reply(&peer->wsc.pending_cancel, reply);
+}
+
 #define SCAN_INTERVAL_MAX	3
 #define SCAN_INTERVAL_STEP	1
 #define CHANS_PER_SCAN_INITIAL	2
@@ -413,6 +637,29 @@ static void p2p_device_roc_start(struct p2p_device *de=
v)
 		(int) dev->listen_channel, (int) duration);
 }
 =

+static const char *p2p_peer_wsc_get_path(struct wsc_dbus *wsc)
+{
+	return p2p_peer_get_path(l_container_of(wsc, struct p2p_peer, wsc));
+}
+
+static void p2p_peer_wsc_connect(struct wsc_dbus *wsc, const char *pin)
+{
+	p2p_peer_connect(l_container_of(wsc, struct p2p_peer, wsc), pin);
+}
+
+static void p2p_peer_wsc_cancel(struct wsc_dbus *wsc)
+{
+	p2p_peer_disconnect(l_container_of(wsc, struct p2p_peer, wsc));
+}
+
+static void p2p_peer_wsc_remove(struct wsc_dbus *wsc)
+{
+	/*
+	 * The WSC removal is triggered in p2p_peer_put so we call
+	 * p2p_peer_free directly from there too.
+	 */
+}
+
 static bool p2p_device_peer_add(struct p2p_device *dev, struct p2p_peer *p=
eer)
 {
 	if (!strlen(peer->name) || !l_utf8_validate(
@@ -441,6 +688,17 @@ static bool p2p_device_peer_add(struct p2p_device *dev=
, struct p2p_peer *peer)
 		return false;
 	}
 =

+	peer->wsc.get_path =3D p2p_peer_wsc_get_path;
+	peer->wsc.connect =3D p2p_peer_wsc_connect;
+	peer->wsc.cancel =3D p2p_peer_wsc_cancel;
+	peer->wsc.remove =3D p2p_peer_wsc_remove;
+
+	if (!wsc_dbus_add_interface(&peer->wsc)) {
+		l_dbus_unregister_object(dbus_get_bus(),
+						p2p_peer_get_path(peer));
+		return false;
+	}
+
 	l_queue_push_tail(dev->peer_list, peer);
 =

 	return true;
@@ -448,6 +706,7 @@ static bool p2p_device_peer_add(struct p2p_device *dev,=
 struct p2p_peer *peer)
 =

 struct p2p_peer_move_data {
 	struct l_queue *new_list;
+	struct p2p_peer *conn_peer;
 	uint64_t now;
 };
 =

@@ -456,7 +715,8 @@ static bool p2p_peer_move_recent(void *data, void *user=
_data)
 	struct p2p_peer *peer =3D data;
 	struct p2p_peer_move_data *move_data =3D user_data;
 =

-	if (move_data->now > peer->bss->time_stamp + 30 * L_USEC_PER_SEC)
+	if (move_data->now > peer->bss->time_stamp + 30 * L_USEC_PER_SEC &&
+			peer !=3D move_data->conn_peer)
 		return false;	/* Old, keep on the list */
 =

 	/* Recently seen or currently connected, move to the new list */
@@ -543,6 +803,7 @@ static bool p2p_scan_notify(int err, struct l_queue *bs=
s_list,
 	 * dev->peer_list and unref only the remaining peers.
 	 */
 	move_data.new_list =3D dev->peer_list;
+	move_data.conn_peer =3D dev->conn_peer;
 	move_data.now =3D l_time_now();
 	l_queue_foreach_remove(old_peer_list, p2p_peer_move_recent, &move_data);
 	l_queue_destroy(old_peer_list, p2p_peer_put);
@@ -872,6 +1133,9 @@ static void p2p_device_start_stop(struct p2p_device *d=
ev,
 		 * Stopping the P2P device, drop all peers as we can't start
 		 * new connections from now on.
 		 */
+		if (dev->conn_peer)
+			p2p_connect_failed(dev);
+
 		l_queue_destroy(dev->peer_list, p2p_peer_put);
 		dev->peer_list =3D NULL;
 	}
@@ -1108,6 +1372,7 @@ static void p2p_device_free(void *user_data)
 	}
 =

 	p2p_device_discovery_stop(dev);
+	p2p_connection_reset(dev);
 	l_dbus_unregister_object(dbus_get_bus(), p2p_device_get_path(dev));
 	l_queue_destroy(dev->peer_list, p2p_peer_put);
 	l_queue_destroy(dev->discovery_users, p2p_discovery_user_free);
@@ -1303,7 +1568,7 @@ static struct l_dbus_message *p2p_device_request_disc=
overy(struct l_dbus *dbus,
 						p2p_device_discovery_destroy);
 	l_queue_push_tail(dev->discovery_users, user);
 =

-	if (first_user && dev->enabled)
+	if (first_user && !dev->conn_peer && dev->enabled)
 		p2p_device_discovery_start(dev);
 =

 	return l_dbus_message_new_method_return(message);
@@ -1413,6 +1678,25 @@ static bool p2p_peer_get_connected(struct l_dbus *db=
us,
 	return true;
 }
 =

+static struct l_dbus_message *p2p_peer_dbus_disconnect(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct p2p_peer *peer =3D user_data;
+
+	if (!l_dbus_message_get_arguments(message, ""))
+		return dbus_error_invalid_args(message);
+
+	/*
+	 * Save the message for both WSC.Cancel and Peer.Disconnect the
+	 * same way.
+	 */
+	peer->wsc.pending_cancel =3D l_dbus_message_ref(message);
+
+	p2p_peer_disconnect(peer);
+	return NULL;
+}
+
 static void p2p_peer_interface_setup(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_property(interface, "Name", 0, "s",
@@ -1423,6 +1707,8 @@ static void p2p_peer_interface_setup(struct l_dbus_in=
terface *interface)
 					p2p_peer_get_subcategory, NULL);
 	l_dbus_interface_property(interface, "Connected", 0, "b",
 					p2p_peer_get_connected, NULL);
+	l_dbus_interface_method(interface, "Disconnect", 0,
+				p2p_peer_dbus_disconnect, "", "");
 }
 =

 static int p2p_init(void)
-- =

2.25.1

--===============2338421292968293807==--

