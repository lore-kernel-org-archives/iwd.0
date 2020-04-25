Content-Type: multipart/mixed; boundary="===============6902850276074948913=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 10/11] p2p: WSC client provisioning and connection
Date: Sat, 25 Apr 2020 11:09:33 +0200
Message-ID: <20200425090934.22285-10-andrew.zaborowski@intel.com>
In-Reply-To: <20200425090934.22285-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6902850276074948913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the final two steps of the connection setup, and corresponding
disconnect logic:

* the WSC connection to the GO to do the client provisioning,
* the netdev_connect call to use the provisioned credentials for the
  final WPA2 connection.
---
 src/p2p.c | 319 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 316 insertions(+), 3 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index c2c12709..be009505 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -91,6 +91,7 @@ struct p2p_device {
 	struct netdev *conn_netdev;
 	uint32_t conn_netdev_watch_id;
 	uint32_t conn_new_intf_cmd_id;
+	struct wsc_enrollee *conn_enrollee;
 =

 	struct l_timeout *config_timeout;
 	unsigned long go_config_delay;
@@ -103,6 +104,14 @@ struct p2p_device {
 =

 	bool enabled : 1;
 	bool have_roc_cookie : 1;
+	/*
+	 * We need to track @disconnecting because while a connect action is
+	 * always triggered by a DBus message, meaning that @pending_message
+	 * is going to be non-NULL, a disconnect may also be a result of an
+	 * error at a layer higher than netdev and may last until
+	 * netdev_disconnect, or similar, finishes.
+	 */
+	bool disconnecting : 1;
 };
 =

 struct p2p_discovery_user {
@@ -173,6 +182,12 @@ static void p2p_discovery_user_free(void *data)
 	l_free(user);
 }
 =

+static inline bool p2p_peer_operational(struct p2p_peer *peer)
+{
+	return peer && peer->dev->conn_netdev && !peer->dev->conn_wsc_bss &&
+		!peer->wsc.pending_connect && !peer->dev->disconnecting;
+}
+
 static bool p2p_peer_match(const void *a, const void *b)
 {
 	const struct p2p_peer *peer =3D a;
@@ -296,6 +311,7 @@ static void p2p_connection_reset(struct p2p_device *dev)
 	 * age will be checked on the next scan.
 	 */
 	dev->conn_peer =3D NULL;
+	dev->disconnecting =3D false;
 	dev->connections_left++;
 =

 	if (dev->conn_pin) {
@@ -320,6 +336,9 @@ static void p2p_connection_reset(struct p2p_device *dev)
 		 */
 		l_genl_family_cancel(dev->nl80211, dev->conn_new_intf_cmd_id);
 =

+	if (dev->conn_enrollee)
+		wsc_enrollee_cancel(dev->conn_enrollee, false);
+
 	if (dev->conn_netdev) {
 		struct l_genl_msg *msg;
 		uint64_t wdev_id =3D netdev_get_wdev_id(dev->conn_netdev);
@@ -471,9 +490,254 @@ static const struct frame_xchg_prefix p2p_frame_pd_re=
sp =3D {
 	.len =3D 7,
 };
 =

+static void p2p_netdev_connect_cb(struct netdev *netdev,
+					enum netdev_result result,
+					void *event_data, void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+	struct p2p_peer *peer =3D dev->conn_peer;
+
+	l_debug("result: %i", result);
+
+	if (!peer->wsc.pending_connect || dev->disconnecting) {
+		/* Shouldn't happen except maybe in the ABORTED case */
+		return;
+	}
+
+	switch (result) {
+	case NETDEV_RESULT_OK:
+		dbus_pending_reply(&peer->wsc.pending_connect,
+					l_dbus_message_new_method_return(
+						peer->wsc.pending_connect));
+		l_dbus_property_changed(dbus_get_bus(),
+					p2p_peer_get_path(dev->conn_peer),
+					IWD_P2P_PEER_INTERFACE, "Connected");
+		break;
+	case NETDEV_RESULT_AUTHENTICATION_FAILED:
+	case NETDEV_RESULT_ASSOCIATION_FAILED:
+	case NETDEV_RESULT_HANDSHAKE_FAILED:
+	case NETDEV_RESULT_KEY_SETTING_FAILED:
+		/*
+		 * In the AUTHENTICATION_FAILED and ASSOCIATION_FAILED
+		 * cases there's nothing to disconnect.  In the
+		 * HANDSHAKE_FAILED and KEY_SETTINGS failed cases
+		 * netdev disconnects from the GO automatically and we are
+		 * called already from within the disconnect callback,
+		 * so we can directly free the netdev.
+		 */
+		p2p_connect_failed(dev);
+		break;
+	case NETDEV_RESULT_ABORTED:
+		/*
+		 * This case can only be triggered by netdev_disconnect so
+		 * we'll wait for its callback before freeing the netdev.
+		 * We will also have already replied to
+		 * @peer->wsc.pending_connect so we have nothing to do here.
+		 */
+		break;
+	}
+}
+
+static void p2p_netdev_event(struct netdev *netdev, enum netdev_event even=
t,
+				void *event_data, void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+
+	switch (event) {
+	case NETDEV_EVENT_DISCONNECT_BY_AP:
+	case NETDEV_EVENT_DISCONNECT_BY_SME:
+		/*
+		 * We may get a DISCONNECT_BY_SME as a result of a
+		 * netdev_disconnect().  In that case let the callback handle
+		 * that.
+		 */
+		if (dev->disconnecting)
+			break;
+
+		/* If we're not connected, .Connected is already False */
+		if (!p2p_peer_operational(dev->conn_peer)) {
+			p2p_connect_failed(dev);
+			break;
+		}
+
+		l_dbus_property_changed(dbus_get_bus(),
+					p2p_peer_get_path(dev->conn_peer),
+					IWD_P2P_PEER_INTERFACE, "Connected");
+		p2p_connection_reset(dev);
+		break;
+	default:
+		break;
+	};
+}
+
+static void p2p_handshake_event(struct handshake_state *hs,
+				enum handshake_event event, void *user_data,
+				...)
+{
+	va_list args;
+
+	va_start(args, user_data);
+
+	switch (event) {
+	case HANDSHAKE_EVENT_FAILED:
+		netdev_handshake_failed(hs, va_arg(args, int));
+		break;
+	default:
+		break;
+	}
+
+	va_end(args);
+}
+
+static void p2p_peer_provision_done(int err, struct wsc_credentials_info *=
creds,
+					unsigned int n_creds, void *user_data)
+{
+	struct p2p_peer *peer =3D user_data;
+	struct p2p_device *dev =3D peer->dev;
+	struct scan_bss *bss =3D dev->conn_wsc_bss;
+	struct handshake_state *hs =3D NULL;
+	struct iovec ie_iov =3D {};
+	int r =3D -EOPNOTSUPP;
+	struct p2p_association_req info =3D {};
+	struct ie_rsn_info bss_info =3D {};
+	struct ie_rsn_info rsn_info =3D {};
+	uint8_t rsne_buf[256];
+
+	l_debug("err=3D%i n_creds=3D%u", err, n_creds);
+
+	dev->conn_wsc_bss =3D NULL;
+	dev->conn_enrollee =3D NULL;
+
+	l_timeout_remove(dev->config_timeout);
+	l_timeout_remove(dev->go_neg_req_timeout);
+
+	if (err < 0) {
+		if (err =3D=3D -ECANCELED && peer->wsc.pending_cancel) {
+			dbus_pending_reply(&peer->wsc.pending_cancel,
+				l_dbus_message_new_method_return(
+						peer->wsc.pending_cancel));
+
+			p2p_connection_reset(dev);
+		} else
+			p2p_connect_failed(dev);
+
+		goto done;
+	}
+
+	if (strlen(creds[0].ssid) !=3D bss->ssid_len ||
+			memcmp(creds[0].ssid, bss->ssid, bss->ssid_len)) {
+		l_error("Unsupported: the SSID from the P2P peer's WSC "
+			"credentials doesn't match the SSID from the "
+			"Probe Response IEs");
+		goto not_supported;
+	}
+
+	/*
+	 * Apparently some implementations send the intended client's address
+	 * here (i.e. our), and some send the target BSS's (their own).
+	 */
+	if (memcmp(creds[0].addr, netdev_get_address(dev->conn_netdev), 6) &&
+			memcmp(creds[0].addr, bss->addr, 6)) {
+		char addr1[32], addr2[32];
+
+		l_strlcpy(addr1, util_address_to_string(creds[0].addr),
+				sizeof(addr1));
+		l_strlcpy(addr2, util_address_to_string(
+					netdev_get_address(dev->conn_netdev)),
+				sizeof(addr2));
+		l_error("Error: WSC credentials are not for our client "
+			"interface (%s vs. %s)", addr1, addr2);
+		goto error;
+	}
+
+	if (!bss->rsne || creds[0].security !=3D SECURITY_PSK)
+		goto not_supported;
+
+	info.capability =3D dev->capability;
+	info.device_info =3D dev->device_info;
+
+	ie_iov.iov_base =3D p2p_build_association_req(&info, &ie_iov.iov_len);
+	L_WARN_ON(!ie_iov.iov_base);
+
+	scan_bss_get_rsn_info(bss, &bss_info);
+
+	rsn_info.akm_suites =3D wiphy_select_akm(dev->wiphy, bss, false);
+	if (!rsn_info.akm_suites)
+		goto not_supported;
+
+	rsn_info.pairwise_ciphers =3D wiphy_select_cipher(dev->wiphy,
+						bss_info.pairwise_ciphers);
+	rsn_info.group_cipher =3D wiphy_select_cipher(dev->wiphy,
+						bss_info.group_cipher);
+	if (!rsn_info.pairwise_ciphers || !rsn_info.group_cipher)
+		goto not_supported;
+
+	rsn_info.group_management_cipher =3D wiphy_select_cipher(dev->wiphy,
+					bss_info.group_management_cipher);
+	rsn_info.mfpc =3D rsn_info.group_management_cipher !=3D 0;
+	ie_build_rsne(&rsn_info, rsne_buf);
+
+	hs =3D netdev_handshake_state_new(dev->conn_netdev);
+
+	if (!handshake_state_set_authenticator_ie(hs, bss->rsne))
+		goto not_supported;
+
+	if (!handshake_state_set_supplicant_ie(hs, rsne_buf))
+		goto not_supported;
+
+	handshake_state_set_event_func(hs, p2p_handshake_event, dev);
+	handshake_state_set_ssid(hs, bss->ssid, bss->ssid_len);
+
+	if (creds[0].has_passphrase) {
+		uint8_t psk[32];
+
+		if (crypto_psk_from_passphrase(creds[0].passphrase, bss->ssid,
+						bss->ssid_len, psk) < 0)
+			goto error;
+
+		handshake_state_set_pmk(hs, psk, 32);
+	} else
+		handshake_state_set_pmk(hs, creds[0].psk, 32);
+
+	r =3D netdev_connect(dev->conn_netdev, bss, hs, &ie_iov, 1,
+				p2p_netdev_event, p2p_netdev_connect_cb, dev);
+	if (r =3D=3D 0)
+		goto done;
+
+	l_error("netdev_connect error: %s (%i)", strerror(-err), -err);
+
+error:
+not_supported:
+	if (r < 0) {
+		if (hs)
+			handshake_state_free(hs);
+
+		p2p_connect_failed(dev);
+	}
+
+done:
+	l_free(ie_iov.iov_base);
+	scan_bss_free(bss);
+}
+
 static void p2p_provision_connect(struct p2p_device *dev)
 {
-	/* TODO */
+	struct iovec iov;
+	struct p2p_association_req info =3D {};
+
+	/* Ready to start the provisioning */
+	info.capability =3D dev->capability;
+	info.device_info =3D dev->device_info;
+
+	iov.iov_base =3D p2p_build_association_req(&info, &iov.iov_len);
+	L_WARN_ON(!iov.iov_base);
+
+	dev->conn_enrollee =3D wsc_enrollee_new(dev->conn_netdev,
+						dev->conn_wsc_bss,
+						dev->conn_pin, &iov, 1,
+						p2p_peer_provision_done,
+						dev->conn_peer);
+	l_free(iov.iov_base);
 }
 =

 static void p2p_device_netdev_watch_destroy(void *user_data)
@@ -495,7 +759,8 @@ static void p2p_device_netdev_notify(struct netdev *net=
dev,
 	switch (event) {
 	case NETDEV_WATCH_EVENT_UP:
 	case NETDEV_WATCH_EVENT_NEW:
-		if (!dev->conn_wsc_bss || !netdev_get_is_up(netdev))
+		if (!dev->conn_wsc_bss || dev->conn_enrollee ||
+				!netdev_get_is_up(netdev))
 			break;
 =

 		p2p_provision_connect(dev);
@@ -1669,6 +1934,23 @@ send_error:
 	dbus_pending_reply(&peer->wsc.pending_connect, reply);
 }
 =

+static void p2p_peer_disconnect_cb(struct netdev *netdev, bool result,
+					void *user_data)
+{
+	struct p2p_peer *peer =3D user_data;
+	struct p2p_device *dev =3D peer->dev;
+
+	if (!peer->wsc.pending_cancel || !dev->disconnecting)
+		return;
+
+	dbus_pending_reply(&peer->wsc.pending_cancel,
+				l_dbus_message_new_method_return(
+						peer->wsc.pending_cancel));
+
+	/* Independent of the result this will just drop the whole netdev */
+	p2p_connection_reset(dev);
+}
+
 static void p2p_peer_disconnect(struct p2p_peer *peer)
 {
 	struct p2p_device *dev =3D peer->dev;
@@ -1680,10 +1962,35 @@ static void p2p_peer_disconnect(struct p2p_peer *pe=
er)
 		goto send_reply;
 	}
 =

+	if (dev->disconnecting) {
+		reply =3D dbus_error_busy(message);
+		goto send_reply;
+	}
+
 	if (peer->wsc.pending_connect)
 		dbus_pending_reply(&peer->wsc.pending_connect,
 				dbus_error_aborted(peer->wsc.pending_connect));
 =

+	if (p2p_peer_operational(peer))
+		l_dbus_property_changed(dbus_get_bus(), p2p_peer_get_path(peer),
+					IWD_P2P_PEER_INTERFACE, "Connected");
+
+	dev->disconnecting =3D true;
+
+	if (dev->conn_enrollee) {
+		wsc_enrollee_cancel(dev->conn_enrollee, true);
+		return;
+	}
+
+	if (dev->conn_netdev && !dev->conn_wsc_bss) {
+		/* Note: in theory we need to add the P2P IEs here too */
+		if (netdev_disconnect(dev->conn_netdev, p2p_peer_disconnect_cb,
+					peer) =3D=3D 0)
+			return;
+
+		l_error("netdev_disconnect failed");
+	}
+
 	p2p_connection_reset(dev);
 	reply =3D l_dbus_message_new_method_return(message);
 =

@@ -1994,6 +2301,10 @@ static bool p2p_peer_update_existing(struct scan_bss=
 *bss,
 =

 	/*
 	 * We've seen this peer already, only update the scan_bss object.
+	 * We can do this even if peer =3D=3D peer->dev->conn_peer because
+	 * its .bss is not used by .conn_netdev or .conn_enrollee.
+	 * .conn_wsc_bss is used for both connections and it doesn't come
+	 * from the discovery scan results.
 	 * Do we need to update DBus properties?
 	 */
 	scan_bss_free(peer->bss);
@@ -3117,7 +3428,9 @@ static bool p2p_peer_get_connected(struct l_dbus *dbu=
s,
 					struct l_dbus_message_builder *builder,
 					void *user_data)
 {
-	bool connected =3D false;
+	struct p2p_peer *peer =3D user_data;
+	bool connected =3D p2p_peer_operational(peer) &&
+		peer->dev->conn_peer =3D=3D peer;
 =

 	l_dbus_message_builder_append_basic(builder, 'b', &connected);
 	return true;
-- =

2.25.1

--===============6902850276074948913==--

