Content-Type: multipart/mixed; boundary="===============2182138604461847909=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 09/18] p2putil: Extract WFD IE payloads from P2P Action frames
Date: Sat, 11 Jul 2020 03:00:44 +0200
Message-ID: <20200711010053.224223-9-andrew.zaborowski@intel.com>
In-Reply-To: <20200711010053.224223-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2182138604461847909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/p2putil.c | 75 ++++++++++++++++++++++++++++++++++++---------------
 src/p2putil.h | 14 ++++++++++
 2 files changed, 68 insertions(+), 21 deletions(-)

diff --git a/src/p2putil.c b/src/p2putil.c
index ef69f88d..d581a2a3 100644
--- a/src/p2putil.c
+++ b/src/p2putil.c
@@ -984,6 +984,8 @@ int p2p_parse_go_negotiation_req(const uint8_t *pdu, si=
ze_t len,
 	d.go_intent =3D go_intent.intent;
 	d.go_tie_breaker =3D go_intent.tie_breaker;
 =

+	d.wfd =3D ie_tlv_extract_wfd_payload(pdu + 1, len - 1, &d.wfd_size);
+
 	memcpy(out, &d, sizeof(d));
 	return 0;
 =

@@ -1043,6 +1045,8 @@ int p2p_parse_go_negotiation_resp(const uint8_t *pdu,=
 size_t len,
 	d.go_intent =3D go_intent.intent;
 	d.go_tie_breaker =3D go_intent.tie_breaker;
 =

+	d.wfd =3D ie_tlv_extract_wfd_payload(pdu + 1, len - 1, &d.wfd_size);
+
 	memcpy(out, &d, sizeof(d));
 	return 0;
 =

@@ -1072,12 +1076,16 @@ int p2p_parse_go_negotiation_confirmation(const uin=
t8_t *pdu, size_t len,
 			REQUIRED(CHANNEL_LIST, &d.channel_list),
 			OPTIONAL(P2P_GROUP_ID, &d.group_id),
 			-1);
+	if (r < 0)
+		goto error;
 =

-	if (r >=3D 0)
-		memcpy(out, &d, sizeof(d));
-	else
-		p2p_clear_go_negotiation_confirmation(&d);
+	d.wfd =3D ie_tlv_extract_wfd_payload(pdu + 1, len - 1, &d.wfd_size);
+
+	memcpy(out, &d, sizeof(d));
+	return 0;
 =

+error:
+	p2p_clear_go_negotiation_confirmation(&d);
 	return r;
 }
 =

@@ -1109,27 +1117,30 @@ int p2p_parse_invitation_req(const uint8_t *pdu, si=
ze_t len,
 			REQUIRED(P2P_DEVICE_INFO, &d.device_info),
 			-1);
 	if (r < 0)
-		goto done;
+		goto error;
 =

 	/* A WSC IE is optional */
 	wsc_data =3D ie_tlv_extract_wsc_payload(pdu + 1, len - 1, &wsc_len);
-	if (!wsc_data)
-		goto done;
-
-	r =3D wsc_parse_attrs(wsc_data, wsc_len, &wsc_version2, NULL, 0, NULL,
+	if (wsc_data) {
+		r =3D wsc_parse_attrs(
+			wsc_data, wsc_len, &wsc_version2, NULL, 0, NULL,
 			WSC_REQUIRED(DEVICE_PASSWORD_ID, &d.device_password_id),
 			WSC_ATTR_INVALID);
-	l_free(wsc_data);
+		l_free(wsc_data);
 =

-	if (r >=3D 0 && !wsc_version2)
-		r =3D -EINVAL;
+		if (r >=3D 0 && !wsc_version2) {
+			r =3D -EINVAL;
+			goto error;
+		}
+	}
 =

-done:
-	if (r >=3D 0)
-		memcpy(out, &d, sizeof(d));
-	else
-		p2p_clear_invitation_req(&d);
+	d.wfd =3D ie_tlv_extract_wfd_payload(pdu + 1, len - 1, &d.wfd_size);
 =

+	memcpy(out, &d, sizeof(d));
+	return 0;
+
+error:
+	p2p_clear_invitation_req(&d);
 	return r;
 }
 =

@@ -1154,12 +1165,16 @@ int p2p_parse_invitation_resp(const uint8_t *pdu, s=
ize_t len,
 			OPTIONAL(P2P_GROUP_BSSID, &d.group_bssid),
 			OPTIONAL(CHANNEL_LIST, &d.channel_list),
 			-1);
+	if (r < 0)
+		goto error;
 =

-	if (r >=3D 0)
-		memcpy(out, &d, sizeof(d));
-	else
-		p2p_clear_invitation_resp(&d);
+	d.wfd =3D ie_tlv_extract_wfd_payload(pdu + 1, len - 1, &d.wfd_size);
 =

+	memcpy(out, &d, sizeof(d));
+	return 0;
+
+error:
+	p2p_clear_invitation_resp(&d);
 	return r;
 }
 =

@@ -1277,6 +1292,8 @@ int p2p_parse_provision_disc_req(const uint8_t *pdu, =
size_t len,
 		goto error;
 	}
 =

+	d.wfd =3D ie_tlv_extract_wfd_payload(pdu + 1, len - 1, &d.wfd_size);
+
 	memcpy(out, &d, sizeof(d));
 	return 0;
 =

@@ -1355,6 +1372,8 @@ int p2p_parse_provision_disc_resp(const uint8_t *pdu,=
 size_t len,
 		goto error;
 	}
 =

+	d.wfd =3D ie_tlv_extract_wfd_payload(pdu + 1, len - 1, &d.wfd_size);
+
 	memcpy(out, &d, sizeof(d));
 	return 0;
 =

@@ -1523,41 +1542,55 @@ void p2p_clear_go_negotiation_req(struct p2p_go_neg=
otiation_req *data)
 {
 	p2p_clear_channel_list_attr(&data->channel_list);
 	p2p_clear_device_info_attr(&data->device_info);
+	l_free(data->wfd);
+	data->wfd =3D NULL;
 }
 =

 void p2p_clear_go_negotiation_resp(struct p2p_go_negotiation_resp *data)
 {
 	p2p_clear_channel_list_attr(&data->channel_list);
 	p2p_clear_device_info_attr(&data->device_info);
+	l_free(data->wfd);
+	data->wfd =3D NULL;
 }
 =

 void p2p_clear_go_negotiation_confirmation(
 				struct p2p_go_negotiation_confirmation *data)
 {
 	p2p_clear_channel_list_attr(&data->channel_list);
+	l_free(data->wfd);
+	data->wfd =3D NULL;
 }
 =

 void p2p_clear_invitation_req(struct p2p_invitation_req *data)
 {
 	p2p_clear_channel_list_attr(&data->channel_list);
 	p2p_clear_device_info_attr(&data->device_info);
+	l_free(data->wfd);
+	data->wfd =3D NULL;
 }
 =

 void p2p_clear_invitation_resp(struct p2p_invitation_resp *data)
 {
 	p2p_clear_channel_list_attr(&data->channel_list);
+	l_free(data->wfd);
+	data->wfd =3D NULL;
 }
 =

 void p2p_clear_provision_disc_req(struct p2p_provision_discovery_req *data)
 {
 	p2p_clear_channel_list_attr(&data->channel_list);
 	p2p_clear_device_info_attr(&data->device_info);
+	l_free(data->wfd);
+	data->wfd =3D NULL;
 }
 =

 void p2p_clear_provision_disc_resp(struct p2p_provision_discovery_resp *da=
ta)
 {
 	p2p_clear_channel_list_attr(&data->channel_list);
 	p2p_clear_device_info_attr(&data->device_info);
+	l_free(data->wfd);
+	data->wfd =3D NULL;
 }
 =

 void p2p_clear_notice_of_absence(struct p2p_notice_of_absence *data)
diff --git a/src/p2putil.h b/src/p2putil.h
index c609ab16..6aad5574 100644
--- a/src/p2putil.h
+++ b/src/p2putil.h
@@ -377,6 +377,8 @@ struct p2p_go_negotiation_req {
 	struct p2p_device_info_attr device_info;
 	struct p2p_channel_attr operating_channel;
 	enum wsc_device_password_id device_password_id;
+	uint8_t *wfd;
+	ssize_t wfd_size;
 };
 =

 struct p2p_go_negotiation_resp {
@@ -392,6 +394,8 @@ struct p2p_go_negotiation_resp {
 	struct p2p_device_info_attr device_info;
 	struct p2p_group_id_attr group_id;
 	enum wsc_device_password_id device_password_id;
+	uint8_t *wfd;
+	ssize_t wfd_size;
 };
 =

 struct p2p_go_negotiation_confirmation {
@@ -401,6 +405,8 @@ struct p2p_go_negotiation_confirmation {
 	struct p2p_channel_attr operating_channel;
 	struct p2p_channel_list_attr channel_list;
 	struct p2p_group_id_attr group_id;
+	uint8_t *wfd;
+	ssize_t wfd_size;
 };
 =

 struct p2p_invitation_req {
@@ -413,6 +419,8 @@ struct p2p_invitation_req {
 	struct p2p_group_id_attr group_id;
 	struct p2p_device_info_attr device_info;
 	enum wsc_device_password_id device_password_id;
+	uint8_t *wfd;
+	ssize_t wfd_size;
 };
 =

 struct p2p_invitation_resp {
@@ -422,6 +430,8 @@ struct p2p_invitation_resp {
 	struct p2p_channel_attr operating_channel;
 	uint8_t group_bssid[6];
 	struct p2p_channel_list_attr channel_list;
+	uint8_t *wfd;
+	ssize_t wfd_size;
 };
 =

 struct p2p_device_discoverability_req {
@@ -453,6 +463,8 @@ struct p2p_provision_discovery_req {
 	enum p2p_asp_coordination_transport_protocol transport_protocol;
 	struct p2p_group_id_attr persistent_group_info;
 	uint16_t wsc_config_method;
+	uint8_t *wfd;
+	ssize_t wfd_size;
 };
 =

 struct p2p_provision_discovery_resp {
@@ -472,6 +484,8 @@ struct p2p_provision_discovery_resp {
 	struct p2p_group_id_attr persistent_group_info;
 	struct p2p_session_info_data_attr session_info;
 	uint16_t wsc_config_method;
+	uint8_t *wfd;
+	ssize_t wfd_size;
 };
 =

 struct p2p_notice_of_absence {
-- =

2.25.1

--===============2182138604461847909==--

