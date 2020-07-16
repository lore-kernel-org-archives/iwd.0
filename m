Content-Type: multipart/mixed; boundary="===============2984867239178356222=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/4] p2p: Add WFD IEs in GO Negotiation and association
Date: Thu, 16 Jul 2020 02:10:17 +0200
Message-ID: <20200716001018.311387-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200716001018.311387-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2984867239178356222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch lets us establish WFD connections by parsing, validating and
acting on WFD IEs in received frames, and adding our own WFD IEs in the
GO Negotiation and Association frames.  Applications should assume that
any connection to a WFD-capable peer when we ourselves have a WFD
service registered, are WFD connections and should handle RTSP and
other IP-based protocols on those connections.

When connecting to a WFD-capable peer and when we have a WFD service
registered, the connection will fail if there are any conflicting or
invalid WFD parameters during GO Negotiation.
---
 src/p2p.c | 213 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 195 insertions(+), 18 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index f18d7dcd..03354445 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -97,6 +97,7 @@ struct p2p_device {
 	struct wsc_enrollee *conn_enrollee;
 	struct netconfig *conn_netconfig;
 	struct l_timeout *conn_dhcp_timeout;
+	struct p2p_wfd_properties *conn_own_wfd;
 =

 	struct l_timeout *config_timeout;
 	unsigned long go_config_delay;
@@ -486,6 +487,12 @@ static void p2p_connection_reset(struct p2p_device *de=
v)
 		dev->peer_list =3D NULL;
 	}
 =

+	if (dev->conn_own_wfd) {
+		l_free(dev->conn_own_wfd);
+		dev->conn_own_wfd =3D NULL;
+		p2p_own_wfd->available =3D true;
+	}
+
 	if (dev->enabled && !dev->start_stop_cmd_id &&
 			!l_queue_isempty(dev->discovery_users))
 		p2p_device_discovery_start(dev);
@@ -775,12 +782,14 @@ static void p2p_peer_provision_done(int err, struct w=
sc_credentials_info *creds,
 	struct p2p_device *dev =3D peer->dev;
 	struct scan_bss *bss =3D dev->conn_wsc_bss;
 	struct handshake_state *hs =3D NULL;
-	struct iovec ie_iov =3D {};
+	struct iovec ie_iov[16];
+	int ie_num =3D 0;
 	int r =3D -EOPNOTSUPP;
 	struct p2p_association_req info =3D {};
 	struct ie_rsn_info bss_info =3D {};
 	struct ie_rsn_info rsn_info =3D {};
 	uint8_t rsne_buf[256];
+	uint8_t wfd_ie[32];
 =

 	l_debug("err=3D%i n_creds=3D%u", err, n_creds);
 =

@@ -835,8 +844,17 @@ static void p2p_peer_provision_done(int err, struct ws=
c_credentials_info *creds,
 	info.capability =3D dev->capability;
 	info.device_info =3D dev->device_info;
 =

-	ie_iov.iov_base =3D p2p_build_association_req(&info, &ie_iov.iov_len);
-	L_WARN_ON(!ie_iov.iov_base);
+	ie_iov[0].iov_base =3D p2p_build_association_req(&info,
+							&ie_iov[0].iov_len);
+	L_WARN_ON(!ie_iov[0].iov_base);
+	ie_num =3D 1;
+
+	if (dev->conn_own_wfd) {
+		ie_iov[ie_num].iov_base =3D wfd_ie;
+		ie_iov[ie_num].iov_len =3D p2p_build_wfd_ie(dev->conn_own_wfd,
+								wfd_ie);
+		ie_num++;
+	}
 =

 	scan_bss_get_rsn_info(bss, &bss_info);
 =

@@ -878,7 +896,7 @@ static void p2p_peer_provision_done(int err, struct wsc=
_credentials_info *creds,
 	} else
 		handshake_state_set_pmk(hs, creds[0].psk, 32);
 =

-	r =3D netdev_connect(dev->conn_netdev, bss, hs, &ie_iov, 1,
+	r =3D netdev_connect(dev->conn_netdev, bss, hs, ie_iov, ie_num,
 				p2p_netdev_event, p2p_netdev_connect_cb, dev);
 	if (r =3D=3D 0)
 		goto done;
@@ -895,28 +913,40 @@ not_supported:
 	}
 =

 done:
-	l_free(ie_iov.iov_base);
+	if (ie_num)
+		l_free(ie_iov[0].iov_base);
+
 	scan_bss_free(bss);
 }
 =

 static void p2p_provision_connect(struct p2p_device *dev)
 {
-	struct iovec iov;
+	struct iovec iov[16];
+	int iov_num;
+	uint8_t wfd_ie[32];
 	struct p2p_association_req info =3D {};
 =

 	/* Ready to start the provisioning */
 	info.capability =3D dev->capability;
 	info.device_info =3D dev->device_info;
 =

-	iov.iov_base =3D p2p_build_association_req(&info, &iov.iov_len);
-	L_WARN_ON(!iov.iov_base);
+	iov[0].iov_base =3D p2p_build_association_req(&info, &iov[0].iov_len);
+	L_WARN_ON(!iov[0].iov_base);
+	iov_num =3D 1;
+
+	if (dev->conn_own_wfd) {
+		iov[iov_num].iov_base =3D wfd_ie;
+		iov[iov_num].iov_len =3D p2p_build_wfd_ie(dev->conn_own_wfd,
+							wfd_ie);
+		iov_num++;
+	}
 =

 	dev->conn_enrollee =3D wsc_enrollee_new(dev->conn_netdev,
 						dev->conn_wsc_bss,
-						dev->conn_pin, &iov, 1,
+						dev->conn_pin, iov, iov_num,
 						p2p_peer_provision_done,
 						dev->conn_peer);
-	l_free(iov.iov_base);
+	l_free(iov[0].iov_base);
 }
 =

 static void p2p_device_netdev_watch_destroy(void *user_data)
@@ -1478,6 +1508,60 @@ static bool p2p_extract_wfd_properties(const uint8_t=
 *ie, size_t ie_size,
 	return true;
 }
 =

+static bool p2p_device_validate_conn_wfd(struct p2p_device *dev,
+						const uint8_t *ie,
+						ssize_t ie_size)
+{
+	struct p2p_wfd_properties wfd;
+
+	if (!dev->conn_own_wfd)
+		return true;
+
+	/*
+	 * WFD IEs are optional in Association Request/Response and P2P Public
+	 * Action frames for R2 devices and required for R1 devices.
+	 * Wi-Fi Display Technical Specification v2.1.0 section 5.2:
+	 * "A WFD R2 Device shall include the WFD IE in Beacon, Probe
+	 * Request/Response, Association Request/Response and P2P Public Action
+	 * frames in order to be interoperable with R1 devices. If a WFD R2
+	 * Device discovers that the peer device is also a WFD R2 Device, then
+	 * it may include the WFD IE in Association Request/Response and P2P
+	 * Public Action frames."
+	 */
+	if (!ie)
+		return dev->conn_own_wfd->r2;
+
+	if (!p2p_extract_wfd_properties(ie, ie_size, &wfd)) {
+		l_error("Could not parse the WFD IE contents");
+		return false;
+	}
+
+	if ((dev->conn_own_wfd->source && !wfd.sink) ||
+			(dev->conn_own_wfd->sink && !wfd.source)) {
+		l_error("Wrong role in peer's WFD IE");
+		return false;
+	}
+
+	if (wfd.r2 !=3D dev->conn_own_wfd->r2) {
+		l_error("Wrong version in peer's WFD IE");
+		return false;
+	}
+
+	/*
+	 * Ignore the session available state because it's not 100% clear
+	 * at what point the peer switches to SESSION_NOT_AVAILABLE in its
+	 * Device Information.
+	 * But we might want to check that other bits have not changed from
+	 * what the peer reported during discovery.
+	 * Wi-Fi Display Technical Specification v2.1.0 section 4.5.2.1:
+	 * "The content of the WFD Device Information subelement should be
+	 * immutable during the period of P2P connection establishment, with
+	 * [...] exceptions [...]"
+	 */
+
+	return true;
+}
+
 static bool p2p_go_negotiation_confirm_cb(const struct mmpdu_header *mpdu,
 					const void *body, size_t body_len,
 					int rssi, struct p2p_device *dev)
@@ -1533,6 +1617,12 @@ static bool p2p_go_negotiation_confirm_cb(const stru=
ct mmpdu_header *mpdu,
 		return true;
 	}
 =

+	/* Check whether WFD IE is required, validate it if present */
+	if (!p2p_device_validate_conn_wfd(dev, info.wfd, info.wfd_size)) {
+		p2p_connect_failed(dev);
+		return true;
+	}
+
 	dev->go_oper_freq =3D frequency;
 	memcpy(&dev->go_group_id, &info.group_id,
 		sizeof(struct p2p_group_id_attr));
@@ -1559,6 +1649,7 @@ static void p2p_device_go_negotiation_req_cb(const st=
ruct mmpdu_header *mpdu,
 	int r;
 	uint8_t *resp_body;
 	size_t resp_len;
+	uint8_t wfd_ie[32];
 	struct iovec iov[16];
 	int iov_len =3D 0;
 	struct p2p_peer *peer;
@@ -1667,6 +1758,18 @@ static void p2p_device_go_negotiation_req_cb(const s=
truct mmpdu_header *mpdu,
 		goto p2p_free;
 	}
 =

+	/* Check whether WFD IE is required, validate it if present */
+	if (!p2p_device_validate_conn_wfd(dev, req_info.wfd,
+						req_info.wfd_size)) {
+		p2p_connect_failed(dev);
+
+		if (l_queue_isempty(dev->discovery_users))
+			p2p_device_discovery_stop(dev);
+
+		status =3D P2P_STATUS_FAIL_INCOMPATIBLE_PARAMS;
+		goto p2p_free;
+	}
+
 	l_timeout_remove(dev->go_neg_req_timeout);
 	p2p_device_discovery_stop(dev);
 =

@@ -1696,7 +1799,14 @@ respond:
 	resp_info.device_info =3D dev->device_info;
 	resp_info.device_password_id =3D dev->conn_password_id;
 =

+	if (dev->conn_own_wfd) {
+		resp_info.wfd =3D wfd_ie;
+		resp_info.wfd_size =3D p2p_build_wfd_ie(dev->conn_own_wfd,
+							wfd_ie);
+	}
+
 	resp_body =3D p2p_build_go_negotiation_resp(&resp_info, &resp_len);
+	resp_info.wfd =3D NULL;
 	p2p_clear_go_negotiation_resp(&resp_info);
 =

 	if (!resp_body) {
@@ -1708,8 +1818,6 @@ respond:
 	iov[iov_len].iov_len =3D resp_len;
 	iov_len++;
 =

-	/* WFD and other service IEs go here */
-
 	iov[iov_len].iov_base =3D NULL;
 =

 	if (status =3D=3D P2P_STATUS_SUCCESS)
@@ -1775,6 +1883,7 @@ static bool p2p_go_negotiation_resp_cb(const struct m=
mpdu_header *mpdu,
 	struct p2p_go_negotiation_confirmation confirm_info =3D {};
 	uint8_t *confirm_body;
 	size_t confirm_len;
+	uint8_t wfd_ie[32];
 	int r;
 	struct iovec iov[16];
 	int iov_len =3D 0;
@@ -1855,6 +1964,13 @@ static bool p2p_go_negotiation_resp_cb(const struct =
mmpdu_header *mpdu,
 						&resp_info.operating_channel))
 		return true;
 =

+	/* Check whether WFD IE is required, validate it if present */
+	if (!p2p_device_validate_conn_wfd(dev, resp_info.wfd,
+						resp_info.wfd_size)) {
+		p2p_connect_failed(dev);
+		return true;
+	}
+
 	band =3D scan_oper_class_to_band(
 			(const uint8_t *) resp_info.operating_channel.country,
 			resp_info.operating_channel.oper_class);
@@ -1881,8 +1997,15 @@ static bool p2p_go_negotiation_resp_cb(const struct =
mmpdu_header *mpdu,
 	confirm_info.channel_list =3D resp_info.channel_list;
 	confirm_info.operating_channel =3D resp_info.operating_channel;
 =

+	if (dev->conn_own_wfd) {
+		confirm_info.wfd =3D wfd_ie;
+		confirm_info.wfd_size =3D p2p_build_wfd_ie(dev->conn_own_wfd,
+								wfd_ie);
+	}
+
 	confirm_body =3D p2p_build_go_negotiation_confirmation(&confirm_info,
 								&confirm_len);
+	confirm_info.wfd =3D NULL;
 	p2p_clear_go_negotiation_resp(&resp_info);
 =

 	if (!confirm_body) {
@@ -1894,8 +2017,6 @@ static bool p2p_go_negotiation_resp_cb(const struct m=
mpdu_header *mpdu,
 	iov[iov_len].iov_len =3D confirm_len;
 	iov_len++;
 =

-	/* WFD and other service IEs go here */
-
 	iov[iov_len].iov_base =3D NULL;
 =

 	p2p_peer_frame_xchg(dev->conn_peer, iov, dev->conn_peer->device_addr,
@@ -1922,6 +2043,7 @@ static void p2p_start_go_negotiation(struct p2p_devic=
e *dev)
 	struct p2p_go_negotiation_req info =3D {};
 	uint8_t *req_body;
 	size_t req_len;
+	uint8_t wfd_ie[32];
 	struct iovec iov[16];
 	int iov_len =3D 0;
 	/*
@@ -1960,7 +2082,13 @@ static void p2p_start_go_negotiation(struct p2p_devi=
ce *dev)
 	info.device_info =3D dev->device_info;
 	info.device_password_id =3D dev->conn_password_id;
 =

+	if (dev->conn_own_wfd) {
+		info.wfd =3D wfd_ie;
+		info.wfd_size =3D p2p_build_wfd_ie(dev->conn_own_wfd, wfd_ie);
+	}
+
 	req_body =3D p2p_build_go_negotiation_req(&info, &req_len);
+	info.wfd =3D NULL;
 	p2p_clear_go_negotiation_req(&info);
 =

 	if (!req_body) {
@@ -1972,8 +2100,6 @@ static void p2p_start_go_negotiation(struct p2p_devic=
e *dev)
 	iov[iov_len].iov_len =3D req_len;
 	iov_len++;
 =

-	/* WFD and other service IEs go here */
-
 	iov[iov_len].iov_base =3D NULL;
 =

 	p2p_peer_frame_xchg(dev->conn_peer, iov, dev->conn_peer->device_addr,
@@ -2024,6 +2150,12 @@ static bool p2p_provision_disc_resp_cb(const struct =
mmpdu_header *mpdu,
 		return true;
 	}
 =

+	/* Check whether WFD IE is required, validate it if present */
+	if (!p2p_device_validate_conn_wfd(dev, info.wfd, info.wfd_size)) {
+		p2p_connect_failed(dev);
+		return true;
+	}
+
 	/*
 	 * If we're not joining an existing group, continue with Group
 	 * Formation now.
@@ -2070,6 +2202,7 @@ static void p2p_start_provision_discovery(struct p2p_=
device *dev)
 	struct p2p_provision_discovery_req info =3D { .status =3D -1 };
 	uint8_t *req_body;
 	size_t req_len;
+	uint8_t wfd_ie[32];
 	struct iovec iov[16];
 	int iov_len =3D 0;
 =

@@ -2086,7 +2219,13 @@ static void p2p_start_provision_discovery(struct p2p=
_device *dev)
 =

 	info.wsc_config_method =3D dev->conn_config_method;
 =

+	if (dev->conn_own_wfd) {
+		info.wfd =3D wfd_ie;
+		info.wfd_size =3D p2p_build_wfd_ie(dev->conn_own_wfd, wfd_ie);
+	}
+
 	req_body =3D p2p_build_provision_disc_req(&info, &req_len);
+	info.wfd =3D NULL;
 	p2p_clear_provision_disc_req(&info);
 =

 	if (!req_body) {
@@ -2098,8 +2237,6 @@ static void p2p_start_provision_discovery(struct p2p_=
device *dev)
 	iov[iov_len].iov_len =3D req_len;
 	iov_len++;
 =

-	/* WFD and other service IEs go here */
-
 	iov[iov_len].iov_base =3D NULL;
 =

 	/*
@@ -2211,6 +2348,24 @@ static void p2p_peer_connect(struct p2p_peer *peer, =
const char *pin)
 		goto send_error;
 	}
 =

+	/*
+	 * Check WFD role compatibility.  At least one of the devices
+	 * (device A) must be non-dual-role and device B must implement the
+	 * role that A does not.  peer->wfd and p2p_own_wfd have both been
+	 * validated and we know each device implements at least one role.
+	 */
+	if (p2p_own_wfd && p2p_own_wfd->available && peer->wfd) {
+		if (!(
+				(!peer->wfd->source && p2p_own_wfd->source) ||
+				(!peer->wfd->sink && p2p_own_wfd->sink) ||
+				(!p2p_own_wfd->source && peer->wfd->source) ||
+				(!p2p_own_wfd->sink && peer->wfd->sink))) {
+			l_error("Incompatible WFD roles");
+			reply =3D dbus_error_not_supported(message);
+			goto send_error;
+		}
+	}
+
 	p2p_device_discovery_stop(dev);
 =

 	/* Generate the interface address for our P2P-Client connection */
@@ -2222,6 +2377,28 @@ static void p2p_peer_connect(struct p2p_peer *peer, =
const char *pin)
 	l_dbus_property_changed(dbus_get_bus(), p2p_device_get_path(dev),
 				IWD_P2P_INTERFACE, "AvailableConnections");
 =

+	if (p2p_own_wfd && p2p_own_wfd->available && peer->wfd) {
+		dev->conn_own_wfd =3D l_memdup(p2p_own_wfd, sizeof(*p2p_own_wfd));
+
+		/*
+		 * From now on we'll appear as SESSION_NOT_AVAILABLE to other
+		 * peers but as SESSION_AVAILABLE to conn_peer.
+		 */
+		p2p_own_wfd->available =3D false;
+
+		/* If peer is R1, fall back to R1 as well */
+		dev->conn_own_wfd->r2 =3D p2p_own_wfd->r2 && peer->wfd->r2;
+
+		/*
+		 * If we're a dual-role device, we have to select our role
+		 * for this connection now.
+		 */
+		if (p2p_own_wfd->source && p2p_own_wfd->sink) {
+			dev->conn_own_wfd->source =3D !peer->wfd->source;
+			dev->conn_own_wfd->sink =3D !peer->wfd->sink;
+		}
+	}
+
 	/*
 	 * Step 2, if peer is already a GO then send the Provision Discovery
 	 * before doing WSC.  If it's not then do Provision Discovery
-- =

2.25.1

--===============2984867239178356222==--

