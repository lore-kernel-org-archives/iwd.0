Content-Type: multipart/mixed; boundary="===============8120518604426498995=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 6/9] ap: Support FILS IP Address Assignment IE
Date: Mon, 23 Aug 2021 16:14:27 +0200
Message-ID: <20210823141430.223543-6-andrew.zaborowski@intel.com>
In-Reply-To: <20210823141430.223543-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8120518604426498995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handle the 802.11ai FILS IP Address Assignment IEs in Association
Request frames when netconfig is enabled.  Only IPv4 is supported.
Like the P2P IP Allocation mechanism, since the payload format and logic
is independent from the rest of the FILS standard this is enabled
unconditionally for clients who want to use it even though we don't
actually do FILS in AP mode.
---
 src/ap.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 98 insertions(+), 16 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index e91f8b00..edffe906 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -119,6 +119,7 @@ struct sta_state {
 	uint8_t wsc_uuid_e[16];
 	bool wsc_v2;
 	struct l_dhcp_lease *ip_alloc_lease;
+	bool ip_alloc_sent;
 };
 =

 struct ap_wsc_pbc_probe_record {
@@ -907,6 +908,25 @@ error:
 	ap_del_station(sta, MMPDU_REASON_CODE_UNSPECIFIED, true);
 }
 =

+static bool ap_sta_get_dhcp4_lease(struct sta_state *sta)
+{
+	if (sta->ip_alloc_lease)
+		return true;
+
+	if (!sta->ap->netconfig_dhcp)
+		return false;
+
+	sta->ip_alloc_lease =3D l_dhcp_server_discover(sta->ap->netconfig_dhcp,
+							0, NULL, sta->addr);
+	if (!sta->ip_alloc_lease) {
+		l_error("l_dhcp_server_discover() failed, see IWD_DHCP_DEBUG "
+			"output");
+		return false;
+	}
+
+	return true;
+}
+
 static void ap_handshake_event(struct handshake_state *hs,
 		enum handshake_event event, void *user_data, ...)
 {
@@ -919,6 +939,9 @@ static void ap_handshake_event(struct handshake_state *=
hs,
 	switch (event) {
 	case HANDSHAKE_EVENT_COMPLETE:
 		if (sta->ip_alloc_lease) {
+			if (hs->support_ip_allocation)
+				sta->ip_alloc_sent =3D true;
+
 			/*
 			 * Move the lease from offered to active state if the
 			 * client has actually used it.  In any case drop our
@@ -926,7 +949,7 @@ static void ap_handshake_event(struct handshake_state *=
hs,
 			 * and if we want to keep our reference we'd need to
 			 * react to relevant server events.
 			 */
-			if (hs->support_ip_allocation)
+			if (sta->ip_alloc_sent)
 				l_dhcp_server_request(ap->netconfig_dhcp,
 							sta->ip_alloc_lease);
 =

@@ -948,16 +971,8 @@ static void ap_handshake_event(struct handshake_state =
*hs,
 		L_AUTO_FREE_VAR(char *, lease_netmask_str) =3D NULL;
 		char own_addr_str[INET_ADDRSTRLEN];
 =

-		if (!sta->ip_alloc_lease)
-			sta->ip_alloc_lease =3D l_dhcp_server_discover(
-							ap->netconfig_dhcp,
-							0, NULL, sta->addr);
-
-		if (!sta->ip_alloc_lease) {
-			l_error("l_dhcp_server_discover() failed, see "
-				"IWD_DHCP_DEBUG output");
+		if (!ap_sta_get_dhcp4_lease(sta))
 			break;
-		}
 =

 		lease_addr_str =3D l_dhcp_lease_get_address(sta->ip_alloc_lease);
 		lease_netmask_str =3D
@@ -1377,14 +1392,16 @@ static uint32_t ap_assoc_resp(struct ap_state *ap, =
struct sta_state *sta,
 				const uint8_t *dest,
 				enum mmpdu_reason_code status_code,
 				bool reassoc, const struct mmpdu_header *req,
-				size_t req_len, frame_xchg_cb_t callback)
+				size_t req_len,
+				const struct ie_fils_ip_addr_request_info *
+				ip_req_info, frame_xchg_cb_t callback)
 {
 	const uint8_t *addr =3D netdev_get_address(ap->netdev);
 	enum mpdu_management_subtype stype =3D reassoc ?
 		MPDU_MANAGEMENT_SUBTYPE_REASSOCIATION_RESPONSE :
 		MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_RESPONSE;
 	L_AUTO_FREE_VAR(uint8_t *, mpdu_buf) =3D
-		l_malloc(128 + ap_get_extra_ies_len(ap, stype, req, req_len));
+		l_malloc(256 + ap_get_extra_ies_len(ap, stype, req, req_len));
 	struct mmpdu_header *mpdu =3D (void *) mpdu_buf;
 	struct mmpdu_association_response *resp;
 	size_t ies_len =3D 0;
@@ -1430,6 +1447,57 @@ static uint32_t ap_assoc_resp(struct ap_state *ap, s=
truct sta_state *sta,
 	ies_len +=3D ap_write_extra_ies(ap, stype, req, req_len,
 					resp->ies + ies_len);
 =

+	if (ip_req_info) {
+		struct ie_fils_ip_addr_response_info ip_resp_info =3D {};
+
+		if (ip_req_info->ipv4 && sta && ap_sta_get_dhcp4_lease(sta)) {
+			L_AUTO_FREE_VAR(char *, lease_addr_str) =3D
+				l_dhcp_lease_get_address(sta->ip_alloc_lease);
+			L_AUTO_FREE_VAR(char *, lease_netmask_str) =3D
+				l_dhcp_lease_get_netmask(sta->ip_alloc_lease);
+			uint32_t lease_lifetime =3D
+				l_dhcp_lease_get_lifetime(sta->ip_alloc_lease);
+			L_AUTO_FREE_VAR(char *, lease_gateway_str) =3D
+				l_dhcp_lease_get_gateway(sta->ip_alloc_lease);
+			char **lease_dns_str_list =3D
+				l_dhcp_lease_get_dns(sta->ip_alloc_lease);
+
+			ip_resp_info.ipv4_addr =3D IP4_FROM_STR(lease_addr_str);
+			ip_resp_info.ipv4_prefix_len =3D
+				__builtin_popcount(IP4_FROM_STR(
+							lease_netmask_str));
+
+			if (lease_lifetime !=3D 0xffffffff)
+				ip_resp_info.ipv4_lifetime =3D lease_lifetime;
+
+			if (lease_gateway_str)
+				ip_resp_info.ipv4_gateway =3D
+					IP4_FROM_STR(lease_gateway_str);
+
+			if (lease_dns_str_list && lease_dns_str_list[0])
+				ip_resp_info.ipv4_dns =3D
+					IP4_FROM_STR(lease_dns_str_list[0]);
+
+			l_strv_free(lease_dns_str_list);
+			sta->ip_alloc_sent =3D true;
+		} else if (ip_req_info->ipv4 || ip_req_info->ipv6) {
+			/*
+			 * 802.11ai-2016 Section 11.47.3.3: "If the AP is unable
+			 * to assign an IP address in the (Re)Association
+			 * Response frame, then the AP sets the IP address
+			 * assignment pending flag in the IP Address Response
+			 * Control field of the FILS IP Address Assignment
+			 * element to 1 and sets the IP address request timeout
+			 * to 0 in (Re)Association Response frame."
+			 */
+			ip_resp_info.response_pending =3D 1;
+			ip_resp_info.response_timeout =3D 0;
+		}
+
+		ie_build_fils_ip_addr_response(&ip_resp_info, resp->ies + ies_len);
+		ies_len +=3D 2 + resp->ies[ies_len + 1];
+	}
+
 	return ap_send_mgmt_frame(ap, mpdu, resp->ies + ies_len - mpdu_buf,
 					callback, sta);
 }
@@ -1518,6 +1586,8 @@ static void ap_assoc_reassoc(struct sta_state *sta, b=
ool reassoc,
 	struct ie_tlv_iter iter;
 	uint8_t *wsc_data =3D NULL;
 	ssize_t wsc_data_len;
+	bool fils_ip_req =3D false;
+	struct ie_fils_ip_addr_request_info fils_ip_req_info;
 =

 	if (sta->assoc_resp_cmd_id)
 		return;
@@ -1564,6 +1634,17 @@ static void ap_assoc_reassoc(struct sta_state *sta, =
bool reassoc,
 =

 			rsn =3D (const uint8_t *) ie_tlv_iter_get_data(&iter) - 2;
 			break;
+
+		case IE_TYPE_FILS_IP_ADDRESS:
+			if (fils_ip_req || ie_parse_fils_ip_addr_request(&iter,
+						&fils_ip_req_info) < 0) {
+				l_debug("Can't parse FILS IP Address Assignment"
+					" IE, ignoring it");
+				break;
+			}
+
+			fils_ip_req =3D true;
+			break;
 		}
 =

 	if (!rates || !ssid || (!wsc_data && !rsn) ||
@@ -1696,7 +1777,8 @@ static void ap_assoc_reassoc(struct sta_state *sta, b=
ool reassoc,
 =

 	sta->assoc_resp_cmd_id =3D ap_assoc_resp(ap, sta, sta->addr, 0, reassoc,
 						req, (void *) ies + ies_len -
-						(void *) req,
+						(void *) req, fils_ip_req ?
+						&fils_ip_req_info : NULL,
 						ap_success_assoc_resp_cb);
 	if (!sta->assoc_resp_cmd_id)
 		l_error("Sending success (Re)Association Response failed");
@@ -1729,7 +1811,7 @@ bad_frame:
 =

 	if (!ap_assoc_resp(ap, sta, sta->addr, err, reassoc,
 				req, (void *) ies + ies_len - (void *) req,
-				ap_fail_assoc_resp_cb))
+				NULL, ap_fail_assoc_resp_cb))
 		l_error("Sending error (Re)Association Response failed");
 }
 =

@@ -1754,7 +1836,7 @@ static void ap_assoc_req_cb(const struct mmpdu_header=
 *hdr, const void *body,
 		if (!ap_assoc_resp(ap, NULL, from,
 				MMPDU_REASON_CODE_STA_REQ_ASSOC_WITHOUT_AUTH,
 				false, hdr, body + body_len - (void *) hdr,
-				ap_fail_assoc_resp_cb))
+				NULL, ap_fail_assoc_resp_cb))
 			l_error("Sending error Association Response failed");
 =

 		return;
@@ -1802,7 +1884,7 @@ static void ap_reassoc_req_cb(const struct mmpdu_head=
er *hdr, const void *body,
 bad_frame:
 	if (!ap_assoc_resp(ap, NULL, from, err, true,
 				hdr, body + body_len - (void *) hdr,
-				ap_fail_assoc_resp_cb))
+				NULL, ap_fail_assoc_resp_cb))
 		l_error("Sending error Reassociation Response failed");
 }
 =

-- =

2.30.2

--===============8120518604426498995==--

