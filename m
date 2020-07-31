Content-Type: multipart/mixed; boundary="===============8376107407925379036=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 05/13] p2p: Retry connect on "Previous authentication not
 valid"
Date: Fri, 31 Jul 2020 03:31:28 +0200
Message-ID: <20200731013136.65057-5-andrew.zaborowski@intel.com>
In-Reply-To: <20200731013136.65057-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8376107407925379036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With some WFD devices we occasionally get a Disconnect before or during
the DHCP setup on the first connection attempt to a newly formeg group,
with the reason code MMPDU_REASON_CODE_PREV_AUTH_NOT_VALID.  Retrying a
a few times makes the connections consistently successful.  Some
conditions are simplified/update in this patch because
conn_dhcp_timeout now implies conn_wsc_bss, and both imply
conn_retry_count.
---
 src/p2p.c | 248 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 147 insertions(+), 101 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index e327cba9..aaecb8ee 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -97,6 +97,8 @@ struct p2p_device {
 	struct netconfig *conn_netconfig;
 	struct l_timeout *conn_dhcp_timeout;
 	struct p2p_wfd_properties *conn_own_wfd;
+	uint8_t conn_psk[32];
+	int conn_retry_count;
 =

 	struct l_timeout *config_timeout;
 	unsigned long go_config_delay;
@@ -206,8 +208,7 @@ static void p2p_discovery_user_free(void *data)
 static inline bool p2p_peer_operational(struct p2p_peer *peer)
 {
 	return peer && peer->dev->conn_netdev && !peer->dev->conn_wsc_bss &&
-		!peer->dev->conn_dhcp_timeout && !peer->wsc.pending_connect &&
-		!peer->dev->disconnecting;
+		!peer->wsc.pending_connect && !peer->dev->disconnecting;
 }
 =

 static bool p2p_peer_match(const void *a, const void *b)
@@ -488,6 +489,9 @@ static void p2p_connection_reset(struct p2p_device *dev)
 		p2p_own_wfd->available =3D true;
 	}
 =

+	explicit_bzero(dev->conn_psk, 32);
+	dev->conn_retry_count =3D 0;
+
 	if (dev->enabled && !dev->start_stop_cmd_id &&
 			!l_queue_isempty(dev->discovery_users))
 		p2p_device_discovery_start(dev);
@@ -596,31 +600,40 @@ static const struct frame_xchg_prefix p2p_frame_pd_re=
sp =3D {
 	.len =3D 7,
 };
 =

+static void p2p_peer_connect_done(struct p2p_device *dev)
+{
+	struct p2p_peer *peer =3D dev->conn_peer;
+
+	/* We can free anything potentially needed for a retry */
+	scan_bss_free(dev->conn_wsc_bss);
+	dev->conn_wsc_bss =3D NULL;
+	explicit_bzero(dev->conn_psk, 32);
+
+	dbus_pending_reply(&peer->wsc.pending_connect,
+				l_dbus_message_new_method_return(
+						peer->wsc.pending_connect));
+	l_dbus_property_changed(dbus_get_bus(),
+				p2p_peer_get_path(dev->conn_peer),
+				IWD_P2P_PEER_INTERFACE, "Connected");
+	l_dbus_property_changed(dbus_get_bus(),
+				p2p_peer_get_path(dev->conn_peer),
+				IWD_P2P_PEER_INTERFACE,
+				"ConnectedInterface");
+	l_dbus_property_changed(dbus_get_bus(),
+				p2p_peer_get_path(dev->conn_peer),
+				IWD_P2P_PEER_INTERFACE,
+				"ConnectedIP");
+}
+
 static void p2p_netconfig_event_handler(enum netconfig_event event,
 					void *user_data)
 {
 	struct p2p_device *dev =3D user_data;
-	struct p2p_peer *peer =3D dev->conn_peer;
 =

 	switch (event) {
 	case NETCONFIG_EVENT_CONNECTED:
 		l_timeout_remove(dev->conn_dhcp_timeout);
-
-		dbus_pending_reply(&peer->wsc.pending_connect,
-					l_dbus_message_new_method_return(
-						peer->wsc.pending_connect));
-		l_dbus_property_changed(dbus_get_bus(),
-					p2p_peer_get_path(dev->conn_peer),
-					IWD_P2P_PEER_INTERFACE, "Connected");
-		l_dbus_property_changed(dbus_get_bus(),
-					p2p_peer_get_path(dev->conn_peer),
-					IWD_P2P_PEER_INTERFACE,
-					"ConnectedInterface");
-		l_dbus_property_changed(dbus_get_bus(),
-					p2p_peer_get_path(dev->conn_peer),
-					IWD_P2P_PEER_INTERFACE,
-					"ConnectedIP");
-
+		p2p_peer_connect_done(dev);
 		break;
 	default:
 		l_error("station: Unsupported netconfig event: %d.", event);
@@ -654,10 +667,12 @@ static void p2p_start_dhcp(struct p2p_device *dev)
 					&dhcp_timeout_val))
 		dhcp_timeout_val =3D 10;	/* 10s default */
 =

-	dev->conn_netconfig =3D netconfig_new(ifindex);
 	if (!dev->conn_netconfig) {
-		p2p_connect_failed(dev);
-		return;
+		dev->conn_netconfig =3D netconfig_new(ifindex);
+		if (!dev->conn_netconfig) {
+			p2p_connect_failed(dev);
+			return;
+		}
 	}
 =

 	netconfig_configure(dev->conn_netconfig, p2p_dhcp_settings,
@@ -711,13 +726,35 @@ static void p2p_netdev_connect_cb(struct netdev *netd=
ev,
 	}
 }
 =

+static void p2p_try_connect_group(struct p2p_device *dev);
+
 static void p2p_netdev_event(struct netdev *netdev, enum netdev_event even=
t,
 				void *event_data, void *user_data)
 {
 	struct p2p_device *dev =3D user_data;
+	const uint16_t *reason_code;
 =

 	switch (event) {
 	case NETDEV_EVENT_DISCONNECT_BY_AP:
+		reason_code =3D event_data;
+
+		if (*reason_code =3D=3D MMPDU_REASON_CODE_PREV_AUTH_NOT_VALID &&
+				dev->conn_wsc_bss &&
+				dev->conn_retry_count < 5) {
+			/*
+			 * Sometimes a retry helps here, may be that we haven't
+			 * waited long enough for the GO setup.
+			 */
+			l_timeout_remove(dev->conn_dhcp_timeout);
+
+			if (dev->conn_netconfig)
+				netconfig_reset(dev->conn_netconfig);
+
+			p2p_try_connect_group(dev);
+			break;
+		}
+
+		/* Fall through. */
 	case NETDEV_EVENT_DISCONNECT_BY_SME:
 		/*
 		 * We may get a DISCONNECT_BY_SME as a result of a
@@ -770,72 +807,19 @@ static void p2p_handshake_event(struct handshake_stat=
e *hs,
 	va_end(args);
 }
 =

-static void p2p_peer_provision_done(int err, struct wsc_credentials_info *=
creds,
-					unsigned int n_creds, void *user_data)
+static void p2p_try_connect_group(struct p2p_device *dev)
 {
-	struct p2p_peer *peer =3D user_data;
-	struct p2p_device *dev =3D peer->dev;
 	struct scan_bss *bss =3D dev->conn_wsc_bss;
 	struct handshake_state *hs =3D NULL;
 	struct iovec ie_iov[16];
 	int ie_num =3D 0;
-	int r =3D -EOPNOTSUPP;
+	int r;
 	struct p2p_association_req info =3D {};
 	struct ie_rsn_info bss_info =3D {};
 	struct ie_rsn_info rsn_info =3D {};
 	uint8_t rsne_buf[256];
 	uint8_t wfd_ie[32];
 =

-	l_debug("err=3D%i n_creds=3D%u", err, n_creds);
-
-	dev->conn_wsc_bss =3D NULL;
-	dev->conn_enrollee =3D NULL;
-
-	l_timeout_remove(dev->config_timeout);
-	l_timeout_remove(dev->go_neg_req_timeout);
-
-	if (err < 0) {
-		if (err =3D=3D -ECANCELED && peer->wsc.pending_cancel) {
-			dbus_pending_reply(&peer->wsc.pending_cancel,
-				l_dbus_message_new_method_return(
-						peer->wsc.pending_cancel));
-
-			p2p_connection_reset(dev);
-		} else
-			p2p_connect_failed(dev);
-
-		goto done;
-	}
-
-	if (strlen(creds[0].ssid) !=3D bss->ssid_len ||
-			memcmp(creds[0].ssid, bss->ssid, bss->ssid_len)) {
-		l_error("Unsupported: the SSID from the P2P peer's WSC "
-			"credentials doesn't match the SSID from the "
-			"Probe Response IEs");
-		goto not_supported;
-	}
-
-	/*
-	 * Apparently some implementations send the intended client's address
-	 * here (i.e. our), and some send the target BSS's (their own).
-	 */
-	if (memcmp(creds[0].addr, netdev_get_address(dev->conn_netdev), 6) &&
-			memcmp(creds[0].addr, bss->addr, 6)) {
-		char addr1[32], addr2[32];
-
-		l_strlcpy(addr1, util_address_to_string(creds[0].addr),
-				sizeof(addr1));
-		l_strlcpy(addr2, util_address_to_string(
-					netdev_get_address(dev->conn_netdev)),
-				sizeof(addr2));
-		l_error("Error: WSC credentials are not for our client "
-			"interface (%s vs. %s)", addr1, addr2);
-		goto error;
-	}
-
-	if (!bss->rsne || creds[0].security !=3D SECURITY_PSK)
-		goto not_supported;
-
 	info.capability =3D dev->capability;
 	info.device_info =3D dev->device_info;
 =

@@ -879,39 +863,100 @@ static void p2p_peer_provision_done(int err, struct =
wsc_credentials_info *creds,
 =

 	handshake_state_set_event_func(hs, p2p_handshake_event, dev);
 	handshake_state_set_ssid(hs, bss->ssid, bss->ssid_len);
-
-	if (creds[0].has_passphrase) {
-		uint8_t psk[32];
-
-		if (crypto_psk_from_passphrase(creds[0].passphrase, bss->ssid,
-						bss->ssid_len, psk) < 0)
-			goto error;
-
-		handshake_state_set_pmk(hs, psk, 32);
-	} else
-		handshake_state_set_pmk(hs, creds[0].psk, 32);
+	handshake_state_set_pmk(hs, dev->conn_psk, 32);
 =

 	r =3D netdev_connect(dev->conn_netdev, bss, hs, ie_iov, ie_num,
 				p2p_netdev_event, p2p_netdev_connect_cb, dev);
-	if (r =3D=3D 0)
-		goto done;
+	if (r < 0) {
+		l_error("netdev_connect error: %s (%i)", strerror(-r), -r);
+		goto error;
+	}
 =

-	l_error("netdev_connect error: %s (%i)", strerror(-err), -err);
+	dev->conn_retry_count++;
+
+done:
+	l_free(ie_iov[0].iov_base);
+	return;
 =

 error:
 not_supported:
-	if (r < 0) {
-		if (hs)
-			handshake_state_free(hs);
+	if (hs)
+		handshake_state_free(hs);
 =

-		p2p_connect_failed(dev);
+	p2p_connect_failed(dev);
+	goto done;
+}
+
+static void p2p_peer_provision_done(int err, struct wsc_credentials_info *=
creds,
+					unsigned int n_creds, void *user_data)
+{
+	struct p2p_peer *peer =3D user_data;
+	struct p2p_device *dev =3D peer->dev;
+	struct scan_bss *bss =3D dev->conn_wsc_bss;
+
+	l_debug("err=3D%i n_creds=3D%u", err, n_creds);
+
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
+			return;
+		} else
+			goto error;
 	}
 =

-done:
-	if (ie_num)
-		l_free(ie_iov[0].iov_base);
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
+	if (creds[0].has_passphrase) {
+		if (crypto_psk_from_passphrase(creds[0].passphrase, bss->ssid,
+						bss->ssid_len,
+						dev->conn_psk) < 0)
+			goto error;
+	} else
+		memcpy(dev->conn_psk, creds[0].psk, 32);
 =

-	scan_bss_free(bss);
+	dev->conn_retry_count =3D 0;
+	p2p_try_connect_group(dev);
+	return;
+
+error:
+not_supported:
+	p2p_connect_failed(dev);
 }
 =

 static void p2p_provision_connect(struct p2p_device *dev)
@@ -963,7 +1008,8 @@ static void p2p_device_netdev_notify(struct netdev *ne=
tdev,
 	switch (event) {
 	case NETDEV_WATCH_EVENT_UP:
 	case NETDEV_WATCH_EVENT_NEW:
-		if (!dev->conn_wsc_bss || dev->conn_enrollee ||
+		/* Ignore the event if we're already connecting/connected */
+		if (dev->conn_enrollee || dev->conn_retry_count ||
 				!netdev_get_is_up(netdev))
 			break;
 =

@@ -2459,7 +2505,7 @@ static void p2p_peer_disconnect(struct p2p_peer *peer)
 		return;
 	}
 =

-	if (dev->conn_netdev && !dev->conn_wsc_bss) {
+	if (dev->conn_netdev && dev->conn_retry_count) {
 		/* Note: in theory we need to add the P2P IEs here too */
 		if (netdev_disconnect(dev->conn_netdev, p2p_peer_disconnect_cb,
 					peer) =3D=3D 0)
-- =

2.25.1

--===============8376107407925379036==--

