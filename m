Content-Type: multipart/mixed; boundary="===============0941359382562079090=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 17/17] p2p: Build P2P and WFD IEs for group's management frames
Date: Wed, 09 Sep 2020 01:49:33 +0200
Message-ID: <20200908234933.301439-17-andrew.zaborowski@intel.com>
In-Reply-To: <20200908234933.301439-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0941359382562079090==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handle our P2P group's ops.write_mgmt_frame_ies callbacks to build and
attach the necessary P2P IE and WFD IEs to the (Re)Association Response,
Probe Response and Beacon frames sent by the GO.
---
 src/p2p.c | 191 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 180 insertions(+), 11 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index 50559bae..7717d838 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -158,6 +158,10 @@ struct p2p_wfd_properties {
 	bool uibc;
 	bool cp;
 	bool r2;
+	uint16_t raw_dev_info;
+	uint8_t associated_bssid[6];
+	uint8_t raw_coupled_sink_status;
+	uint8_t coupled_sink_mac[6];
 };
 =

 static struct l_queue *p2p_device_list;
@@ -272,9 +276,9 @@ static void p2p_peer_put(void *user_data)
 static void p2p_device_discovery_start(struct p2p_device *dev);
 static void p2p_device_discovery_stop(struct p2p_device *dev);
 =

-/* Callers should reserve 32 bytes */
+/* Callers should reserve 32 bytes, 64 with non-NULL @wfd_clients */
 static size_t p2p_build_wfd_ie(const struct p2p_wfd_properties *wfd,
-				uint8_t *buf)
+				const struct p2p_peer *wfd_client, uint8_t *buf)
 {
 	/*
 	 * Wi-Fi Display Technical Specification v2.1.0
@@ -319,6 +323,30 @@ static size_t p2p_build_wfd_ie(const struct p2p_wfd_pr=
operties *wfd,
 		buf[size++] =3D 0x01;	/* UIBC Support */
 	}
 =

+	/*
+	 * Wi-Fi Display Technical Specification v2.1.0 section 5.2.3:
+	 * "If a WFD Capable GO has at least one associated client that is
+	 * WFD capable, the WFD capable GO shall include the WFD Session
+	 * Information subelement in the WFD IE in the Probe Response
+	 * frames it transmits."
+	 */
+	if (wfd_client && !L_WARN_ON(!wfd_client->wfd)) {
+		buf[size++] =3D WFD_SUBELEM_SESION_INFORMATION;
+		buf[size++] =3D 0;		/* WFD Subelement length */
+		buf[size++] =3D 23;
+		memcpy(buf + size, wfd_client->device_addr, 6);
+		size +=3D 6;
+		memcpy(buf + size, wfd_client->wfd->associated_bssid, 6);
+		size +=3D 6;
+		buf[size++] =3D wfd_client->wfd->raw_dev_info >> 8;
+		buf[size++] =3D wfd_client->wfd->raw_dev_info & 255;
+		buf[size++] =3D wfd_client->wfd->throughput >> 8;
+		buf[size++] =3D wfd_client->wfd->throughput & 255;
+		buf[size++] =3D wfd_client->wfd->raw_coupled_sink_status;
+		memcpy(buf + size, wfd_client->wfd->coupled_sink_mac, 6);
+		size +=3D 6;
+	}
+
 	if (wfd->r2) {
 		buf[size++] =3D WFD_SUBELEM_R2_DEVICE_INFORMATION;
 		buf[size++] =3D 0;	/* WFD Subelement length */
@@ -336,6 +364,8 @@ static bool p2p_extract_wfd_properties(const uint8_t *i=
e, size_t ie_size,
 {
 	struct wfd_subelem_iter iter;
 	const uint8_t *devinfo =3D NULL;
+	const uint8_t *associated_bssid =3D NULL;
+	const uint8_t *coupled_sink_info =3D NULL;
 	const uint8_t *ext_caps =3D NULL;
 	const uint8_t *r2 =3D NULL;
 =

@@ -365,6 +395,13 @@ static bool p2p_extract_wfd_properties(const uint8_t *=
ie, size_t ie_size,
 		case WFD_SUBELEM_WFD_DEVICE_INFORMATION:
 			SUBELEM_CHECK(devinfo, 6, "Device Information");
 			break;
+		case WFD_SUBELEM_ASSOCIATED_BSSID:
+			SUBELEM_CHECK(associated_bssid, 6, "Associated BSSID");
+			break;
+		case WFD_SUBELEM_COUPLED_SINK_INFORMATION:
+			SUBELEM_CHECK(coupled_sink_info, 7,
+					"Coupled Sink Information");
+			break;
 		case WFD_SUBELEM_EXTENDED_CAPABILITY:
 			SUBELEM_CHECK(ext_caps, 2, "Extended Capability");
 			break;
@@ -413,11 +450,20 @@ static bool p2p_extract_wfd_properties(const uint8_t =
*ie, size_t ie_size,
 		out->cp =3D capability & WFD_DEV_INFO_CONTENT_PROTECTION_SUPPORT;
 		out->audio =3D !sink ||
 			!(capability & WFD_DEV_INFO_NO_AUDIO_AT_PRIMARY_SINK);
+		out->raw_dev_info =3D l_get_be16(devinfo);
 	} else {
 		l_error("Device Information missing in WFD IE");
 		return false;
 	}
 =

+	if (associated_bssid)
+		memcpy(out->associated_bssid, associated_bssid, 6);
+
+	if (coupled_sink_info) {
+		out->raw_coupled_sink_status =3D coupled_sink_info[0];
+		memcpy(out->coupled_sink_mac, coupled_sink_info + 1, 6);
+	}
+
 	if (ext_caps && (l_get_be16(ext_caps) & 1))
 		out->uibc =3D 1;
 =

@@ -554,7 +600,7 @@ static uint8_t *p2p_build_scan_ies(struct p2p_device *d=
ev, uint8_t *buf,
 		return NULL;
 =

 	if (p2p_own_wfd)
-		wfd_ie_size =3D p2p_build_wfd_ie(p2p_own_wfd, wfd_ie);
+		wfd_ie_size =3D p2p_build_wfd_ie(p2p_own_wfd, NULL, wfd_ie);
 	else
 		wfd_ie_size =3D 0;
 =

@@ -917,7 +963,9 @@ static void p2p_group_event(enum ap_event_type type, co=
nst void *event_data,
 		/* Don't validate the P2P IE or WFD IE at this stage */
 		break;
 	case AP_EVENT_REGISTRATION_SUCCESS:
+		/* Update the Group Formation bit in our beacons */
 		dev->capability.group_caps &=3D ~P2P_GROUP_CAP_GROUP_FORMATION;
+		ap_update_beacon(dev->group);
 		break;
 	case AP_EVENT_PBC_MODE_EXIT:
 		break;
@@ -931,8 +979,126 @@ invalid_ie:
 	p2p_connect_failed(dev);
 }
 =

+static size_t p2p_group_get_ies_len(enum mpdu_management_subtype type,
+					void *user_data)
+{
+	switch (type) {
+	case MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_RESPONSE:
+	case MPDU_MANAGEMENT_SUBTYPE_REASSOCIATION_RESPONSE:
+	case MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE:
+	case MPDU_MANAGEMENT_SUBTYPE_BEACON:
+		return 256;
+	default:
+		return 0;
+	}
+}
+
+static size_t p2p_group_write_ies(enum mpdu_management_subtype type,
+					uint8_t *out_buf, void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+	uint8_t *ptr =3D out_buf;
+	L_AUTO_FREE_VAR(uint8_t *, p2p_ie) =3D NULL;
+	size_t p2p_ie_len;
+	struct p2p_wfd_properties *wfd =3D NULL;
+	const struct p2p_peer *wfd_client =3D NULL;
+
+	switch (type) {
+	case MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_RESPONSE:
+	case MPDU_MANAGEMENT_SUBTYPE_REASSOCIATION_RESPONSE:
+	{
+		/*
+		 * Wi-Fi P2P Technical Specification v1.7 Section 4.2.5:
+		 * "If neither P2P attribute is required according to the
+		 * conditions in Table 55, then a P2P IE containing no P2P
+		 * attributes is included."
+		 * This is going to be our case.
+		 */
+		struct p2p_association_resp info =3D {};
+
+		p2p_ie =3D p2p_build_association_resp(&info, &p2p_ie_len);
+
+		if (dev->conn_own_wfd && !dev->conn_own_wfd->r2)
+			wfd =3D dev->conn_own_wfd;
+
+		break;
+	}
+
+	case MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE:
+	{
+		/*
+		 * 3.2.2: "A P2P Group Owner shall not include a P2P IE
+		 * in the Probe Response frame if the received Probe Request
+		 * frame does not contain a P2P IE."
+		 * For simplicity include it always, same applies to the
+		 * WFD IE too.
+		 */
+		struct p2p_probe_resp info =3D {};
+
+		info.capability =3D dev->capability;
+		info.device_info =3D dev->device_info;
+
+		if (dev->conn_peer_added) {
+			struct p2p_client_info_descriptor client =3D {};
+
+			memcpy(client.device_addr,
+				dev->conn_client_dev_info.device_addr, 6);
+			memcpy(client.interface_addr,
+				dev->conn_peer_interface_addr, 6);
+			client.device_caps =3D
+				dev->conn_client_capability.device_caps;
+			client.wsc_config_methods =3D
+				dev->conn_client_dev_info.wsc_config_methods;
+			client.primary_device_type =3D
+				dev->conn_client_dev_info.primary_device_type;
+			l_strlcpy(client.device_name,
+					dev->conn_client_dev_info.device_name,
+					sizeof(client.device_name));
+
+			info.group_clients =3D l_queue_new();
+			l_queue_push_tail(info.group_clients,
+					l_memdup(&client, sizeof(client)));
+		}
+
+		p2p_ie =3D p2p_build_probe_resp(&info, &p2p_ie_len);
+		p2p_clear_probe_resp(&info);
+
+		if (dev->conn_own_wfd)
+			wfd_client =3D dev->conn_peer;
+
+		wfd =3D p2p_own_wfd;
+		break;
+	}
+
+	case MPDU_MANAGEMENT_SUBTYPE_BEACON:
+	{
+		struct p2p_beacon info =3D {};
+
+		info.capability =3D dev->capability;
+		memcpy(info.device_addr, dev->addr, 6);
+		p2p_ie =3D p2p_build_beacon(&info, &p2p_ie_len);
+
+		wfd =3D p2p_own_wfd;
+		break;
+	}
+
+	default:
+		return 0;
+	}
+
+	memcpy(ptr, p2p_ie, p2p_ie_len);
+	ptr +=3D p2p_ie_len;
+
+	if (wfd)
+		ptr +=3D p2p_build_wfd_ie(wfd, wfd_client, ptr);
+
+	return ptr - out_buf;
+}
+
 static const struct ap_ops p2p_go_ops =3D {
 	.handle_event =3D p2p_group_event,
+	.get_mgmt_frame_ies_len =3D p2p_group_get_ies_len,
+	.write_mgmt_frame_ies =3D p2p_group_write_ies,
 };
 =

 static void p2p_group_start(struct p2p_device *dev)
@@ -1190,7 +1356,7 @@ static void p2p_try_connect_group(struct p2p_device *=
dev)
 	if (dev->conn_own_wfd) {
 		ie_iov[ie_num].iov_base =3D wfd_ie;
 		ie_iov[ie_num].iov_len =3D p2p_build_wfd_ie(dev->conn_own_wfd,
-								wfd_ie);
+								NULL, wfd_ie);
 		ie_num++;
 	}
 =

@@ -1336,7 +1502,7 @@ static void p2p_provision_connect(struct p2p_device *=
dev)
 	if (dev->conn_own_wfd) {
 		iov[iov_num].iov_base =3D wfd_ie;
 		iov[iov_num].iov_len =3D p2p_build_wfd_ie(dev->conn_own_wfd,
-							wfd_ie);
+							NULL, wfd_ie);
 		iov_num++;
 	}
 =

@@ -2165,7 +2331,7 @@ respond:
 	if (dev->conn_own_wfd) {
 		resp_info.wfd =3D wfd_ie;
 		resp_info.wfd_size =3D p2p_build_wfd_ie(dev->conn_own_wfd,
-							wfd_ie);
+							NULL, wfd_ie);
 	}
 =

 	resp_body =3D p2p_build_go_negotiation_resp(&resp_info, &resp_len);
@@ -2441,7 +2607,7 @@ static bool p2p_go_negotiation_resp_cb(const struct m=
mpdu_header *mpdu,
 	if (dev->conn_own_wfd) {
 		confirm_info.wfd =3D wfd_ie;
 		confirm_info.wfd_size =3D p2p_build_wfd_ie(dev->conn_own_wfd,
-								wfd_ie);
+								NULL, wfd_ie);
 	}
 =

 	confirm_body =3D p2p_build_go_negotiation_confirmation(&confirm_info,
@@ -2528,7 +2694,8 @@ static void p2p_start_go_negotiation(struct p2p_devic=
e *dev)
 =

 	if (dev->conn_own_wfd) {
 		info.wfd =3D wfd_ie;
-		info.wfd_size =3D p2p_build_wfd_ie(dev->conn_own_wfd, wfd_ie);
+		info.wfd_size =3D p2p_build_wfd_ie(dev->conn_own_wfd,
+							NULL, wfd_ie);
 	}
 =

 	req_body =3D p2p_build_go_negotiation_req(&info, &req_len);
@@ -2665,7 +2832,8 @@ static void p2p_start_provision_discovery(struct p2p_=
device *dev)
 =

 	if (dev->conn_own_wfd) {
 		info.wfd =3D wfd_ie;
-		info.wfd_size =3D p2p_build_wfd_ie(dev->conn_own_wfd, wfd_ie);
+		info.wfd_size =3D p2p_build_wfd_ie(dev->conn_own_wfd,
+							NULL, wfd_ie);
 	}
 =

 	req_body =3D p2p_build_provision_disc_req(&info, &req_len);
@@ -3631,11 +3799,12 @@ static void p2p_device_send_probe_resp(struct p2p_d=
evice *dev,
 	if (to_conn_peer && dev->conn_own_wfd) {
 		iov[iov_len].iov_base =3D wfd_ie;
 		iov[iov_len].iov_len =3D p2p_build_wfd_ie(dev->conn_own_wfd,
-							wfd_ie);
+							NULL, wfd_ie);
 		iov_len++;
 	} else if (p2p_own_wfd) {
 		iov[iov_len].iov_base =3D wfd_ie;
-		iov[iov_len].iov_len =3D p2p_build_wfd_ie(p2p_own_wfd, wfd_ie);
+		iov[iov_len].iov_len =3D p2p_build_wfd_ie(p2p_own_wfd,
+							NULL, wfd_ie);
 		iov_len++;
 	}
 =

-- =

2.25.1

--===============0941359382562079090==--

