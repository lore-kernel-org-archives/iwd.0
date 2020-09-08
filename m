Content-Type: multipart/mixed; boundary="===============6314783057427544884=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 15/17] p2p: Parse P2P IEs and WFD IEs in Association Requests
Date: Wed, 09 Sep 2020 01:49:31 +0200
Message-ID: <20200908234933.301439-15-andrew.zaborowski@intel.com>
In-Reply-To: <20200908234933.301439-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6314783057427544884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Roughly validate the IEs and save some information for use in our own
IEs. p2p_extract_wfd_properties and p2p_device_validate_conn_wfd are
being moved unchanged to be usable in p2p_group_event without forward
declarations and to be next to p2p_build_wfd_ie.
---
 src/p2p.c | 386 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 229 insertions(+), 157 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index db4b0750..50559bae 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -109,6 +109,8 @@ struct p2p_device {
 	unsigned int conn_go_scan_retry;
 	uint32_t conn_go_oper_freq;
 	uint8_t conn_peer_interface_addr[6];
+	struct p2p_capability_attr conn_client_capability;
+	struct p2p_device_info_attr conn_client_dev_info;
 =

 	struct p2p_group_id_attr go_group_id;
 	struct ap_state *group;
@@ -329,6 +331,163 @@ static size_t p2p_build_wfd_ie(const struct p2p_wfd_p=
roperties *wfd,
 	return size;
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
 /* TODO: convert to iovecs */
 static uint8_t *p2p_build_scan_ies(struct p2p_device *dev, uint8_t *buf,
 					size_t buf_len, size_t *out_len)
@@ -682,9 +841,72 @@ static void p2p_group_event(enum ap_event_type type, c=
onst void *event_data,
 		break;
 =

 	case AP_EVENT_STATION_ADDED:
+	{
+		const struct ap_event_station_added_data *data =3D event_data;
+		L_AUTO_FREE_VAR(uint8_t *, p2p_data) =3D NULL;
+		ssize_t p2p_data_len;
+		L_AUTO_FREE_VAR(uint8_t *, wfd_data) =3D NULL;
+		ssize_t wfd_data_len;
+		struct p2p_association_req req_info;
+		int r;
+
+		p2p_data =3D ie_tlv_extract_p2p_payload(data->assoc_ies,
+							data->assoc_ies_len,
+							&p2p_data_len);
+		if (!p2p_data) {
+			l_error("Missing or invalid P2P IEs: %s (%i)",
+				strerror(-p2p_data_len), (int) -p2p_data_len);
+			goto invalid_ie;
+		}
+
+		/*
+		 * We don't need to validate most of the Association Request
+		 * P2P IE contents as we already have all the information there
+		 * may be but we need to save some of the attributes because
+		 * section 3.2.3 requires that our Group Info includes
+		 * specifically the data from the association, not any of the
+		 * earlier exchanges:
+		 * "When a P2P Client associates with a P2P Group Owner, it
+		 * provides [...] the P2P Device Info attribute (see Section
+		 * 4.1.15) and the P2P Capability attribute (see Section 4.1.4)
+		 * in the P2P IE in the Association Request frame.  This
+		 * information shall be used by the P2P Group Owner for Group
+		 * Information Advertisement.
+		 */
+		r =3D p2p_parse_association_req(p2p_data, p2p_data_len,
+						&req_info);
+		if (r < 0) {
+			l_error("Can't parse P2P Association Request: %s (%i)",
+				strerror(-r), -r);
+			goto invalid_ie;
+		}
+
+		/*
+		 * Most of this duplicates the information we already have in
+		 * dev->conn_peer.
+		 */
+		dev->conn_client_capability =3D req_info.capability;
+		dev->conn_client_dev_info =3D req_info.device_info;
+		p2p_clear_association_req(&req_info);
+
+		if (dev->conn_own_wfd)
+			wfd_data =3D ie_tlv_extract_p2p_payload(data->assoc_ies,
+							data->assoc_ies_len,
+							&wfd_data_len);
+
+		if (!p2p_device_validate_conn_wfd(dev, wfd_data,
+							wfd_data_len))
+			goto invalid_ie;
+
+		/* Take the chance to update WFD attributes for Session Info */
+		if (wfd_data)
+			p2p_extract_wfd_properties(wfd_data, wfd_data_len,
+							dev->conn_peer->wfd);
+
 		dev->conn_peer_added =3D true;
 		p2p_peer_connect_done(dev);
 		break;
+	}
 =

 	case AP_EVENT_STATION_REMOVED:
 		dev->conn_peer_added =3D false;
@@ -700,6 +922,13 @@ static void p2p_group_event(enum ap_event_type type, c=
onst void *event_data,
 	case AP_EVENT_PBC_MODE_EXIT:
 		break;
 	};
+
+	return;
+
+invalid_ie:
+	ap_station_disconnect(dev->group, dev->conn_peer_interface_addr,
+				MMPDU_REASON_CODE_INVALID_IE);
+	p2p_connect_failed(dev);
 }
 =

 static const struct ap_ops p2p_go_ops =3D {
@@ -1583,163 +1812,6 @@ static void p2p_device_fill_channel_list(struct p2p=
_device *dev,
 	l_queue_push_tail(attr->channel_entries, channel_entry);
 }
 =

-static bool p2p_extract_wfd_properties(const uint8_t *ie, size_t ie_size,
-					struct p2p_wfd_properties *out)
-{
-	struct wfd_subelem_iter iter;
-	const uint8_t *devinfo =3D NULL;
-	const uint8_t *ext_caps =3D NULL;
-	const uint8_t *r2 =3D NULL;
-
-	if (!ie)
-		return false;
-
-	wfd_subelem_iter_init(&iter, ie, ie_size);
-
-	while (wfd_subelem_iter_next(&iter)) {
-		enum wfd_subelem_type type =3D wfd_subelem_iter_get_type(&iter);
-		size_t len =3D wfd_subelem_iter_get_length(&iter);
-		const uint8_t *data =3D wfd_subelem_iter_get_data(&iter);
-
-		switch (type) {
-#define SUBELEM_CHECK(var, expected_len, name)		\
-			if (len !=3D expected_len) {	\
-				l_debug(name " length wrong in WFD IE");\
-				return false;		\
-			}				\
-							\
-			if (var) {			\
-				l_debug("Duplicate" name " in WFD IE");\
-				return false;		\
-			}				\
-							\
-			var =3D data;
-		case WFD_SUBELEM_WFD_DEVICE_INFORMATION:
-			SUBELEM_CHECK(devinfo, 6, "Device Information");
-			break;
-		case WFD_SUBELEM_EXTENDED_CAPABILITY:
-			SUBELEM_CHECK(ext_caps, 2, "Extended Capability");
-			break;
-		case WFD_SUBELEM_R2_DEVICE_INFORMATION:
-			SUBELEM_CHECK(r2, 2, "R2 Device Information");
-			break;
-#undef SUBELEM_CHECK
-		default:
-			/* Skip unknown IEs */
-			break;
-		}
-	}
-
-	if (devinfo) {
-		uint16_t capability =3D l_get_be16(devinfo + 0);
-		bool source;
-		bool sink;
-		uint16_t port;
-
-		source =3D (capability & WFD_DEV_INFO_DEVICE_TYPE) =3D=3D
-			WFD_DEV_INFO_TYPE_SOURCE ||
-			(capability & WFD_DEV_INFO_DEVICE_TYPE) =3D=3D
-			WFD_DEV_INFO_TYPE_DUAL_ROLE;
-		sink =3D (capability & WFD_DEV_INFO_DEVICE_TYPE) =3D=3D
-			WFD_DEV_INFO_TYPE_PRIMARY_SINK ||
-			(capability & WFD_DEV_INFO_DEVICE_TYPE) =3D=3D
-			WFD_DEV_INFO_TYPE_DUAL_ROLE;
-
-		if (!source && !sink)
-			return false;
-
-		port =3D l_get_be16(devinfo + 2);
-
-		if (source && port =3D=3D 0) {
-			l_debug("0 port number in WFD IE Device Information");
-			return false;
-		}
-
-		memset(out, 0, sizeof(*out));
-		out->available =3D
-			(capability & WFD_DEV_INFO_SESSION_AVAILABILITY) =3D=3D
-			WFD_DEV_INFO_SESSION_AVAILABLE;
-		out->source =3D source;
-		out->sink =3D sink;
-		out->port =3D port;
-		out->cp =3D capability & WFD_DEV_INFO_CONTENT_PROTECTION_SUPPORT;
-		out->audio =3D !sink ||
-			!(capability & WFD_DEV_INFO_NO_AUDIO_AT_PRIMARY_SINK);
-	} else {
-		l_error("Device Information missing in WFD IE");
-		return false;
-	}
-
-	if (ext_caps && (l_get_be16(ext_caps) & 1))
-		out->uibc =3D 1;
-
-	if (r2) {
-		uint8_t role =3D l_get_be16(r2) & 3;
-
-		if ((out->source && role !=3D 0 && role !=3D 3) ||
-				(out->sink && role !=3D 1 && role !=3D 3))
-			l_debug("Invalid role in WFD R2 Device Information");
-		else
-			out->r2 =3D true;
-	}
-
-	return true;
-}
-
-static bool p2p_device_validate_conn_wfd(struct p2p_device *dev,
-						const uint8_t *ie,
-						ssize_t ie_size)
-{
-	struct p2p_wfd_properties wfd;
-
-	if (!dev->conn_own_wfd)
-		return true;
-
-	/*
-	 * WFD IEs are optional in Association Request/Response and P2P Public
-	 * Action frames for R2 devices and required for R1 devices.
-	 * Wi-Fi Display Technical Specification v2.1.0 section 5.2:
-	 * "A WFD R2 Device shall include the WFD IE in Beacon, Probe
-	 * Request/Response, Association Request/Response and P2P Public Action
-	 * frames in order to be interoperable with R1 devices. If a WFD R2
-	 * Device discovers that the peer device is also a WFD R2 Device, then
-	 * it may include the WFD IE in Association Request/Response and P2P
-	 * Public Action frames."
-	 */
-	if (!ie)
-		return dev->conn_own_wfd->r2;
-
-	if (!p2p_extract_wfd_properties(ie, ie_size, &wfd)) {
-		l_error("Could not parse the WFD IE contents");
-		return false;
-	}
-
-	if ((dev->conn_own_wfd->source && !wfd.sink) ||
-			(dev->conn_own_wfd->sink && !wfd.source)) {
-		l_error("Wrong role in peer's WFD IE");
-		return false;
-	}
-
-	if (wfd.r2 !=3D dev->conn_own_wfd->r2) {
-		l_error("Wrong version in peer's WFD IE");
-		return false;
-	}
-
-	/*
-	 * Ignore the session available state because it's not 100% clear
-	 * at what point the peer switches to SESSION_NOT_AVAILABLE in its
-	 * Device Information.
-	 * But we might want to check that other bits have not changed from
-	 * what the peer reported during discovery.
-	 * Wi-Fi Display Technical Specification v2.1.0 section 4.5.2.1:
-	 * "The content of the WFD Device Information subelement should be
-	 * immutable during the period of P2P connection establishment, with
-	 * [...] exceptions [...]"
-	 */
-
-	return true;
-}
-
 static bool p2p_go_negotiation_confirm_cb(const struct mmpdu_header *mpdu,
 					const void *body, size_t body_len,
 					int rssi, struct p2p_device *dev)
-- =

2.25.1

--===============6314783057427544884==--

