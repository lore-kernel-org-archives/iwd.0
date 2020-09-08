Content-Type: multipart/mixed; boundary="===============2478654411478206286=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 07/17] p2p: Consistently use the conn_ prefix for variables
Date: Wed, 09 Sep 2020 01:49:23 +0200
Message-ID: <20200908234933.301439-7-andrew.zaborowski@intel.com>
In-Reply-To: <20200908234933.301439-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2478654411478206286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prefix all the struct p2p_device members that are part of the connection
state with the "conn_" string for consistency.  If we needed to support
multiple client connections, these members are the ones that would
probably land in a separate structure, without that prefix.
---
 src/p2p.c | 89 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 41 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index 5ab03c87..d2ae169d 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -100,14 +100,14 @@ struct p2p_device {
 	uint8_t conn_psk[32];
 	int conn_retry_count;
 =

-	struct l_timeout *config_timeout;
-	unsigned long go_config_delay;
-	struct l_timeout *go_neg_req_timeout;
-	uint8_t go_dialog_token;
-	unsigned int go_scan_retry;
-	uint32_t go_oper_freq;
+	struct l_timeout *conn_peer_config_timeout;
+	unsigned long conn_config_delay;
+	struct l_timeout *conn_go_neg_req_timeout;
+	uint8_t conn_go_dialog_token;
+	unsigned int conn_go_scan_retry;
+	uint32_t conn_go_oper_freq;
 	struct p2p_group_id_attr go_group_id;
-	uint8_t go_interface_addr[6];
+	uint8_t conn_peer_interface_addr[6];
 =

 	bool enabled : 1;
 	bool have_roc_cookie : 1;
@@ -425,8 +425,8 @@ static void p2p_connection_reset(struct p2p_device *dev)
 	l_dbus_property_changed(dbus_get_bus(), p2p_device_get_path(dev),
 				IWD_P2P_INTERFACE, "AvailableConnections");
 =

-	l_timeout_remove(dev->config_timeout);
-	l_timeout_remove(dev->go_neg_req_timeout);
+	l_timeout_remove(dev->conn_peer_config_timeout);
+	l_timeout_remove(dev->conn_go_neg_req_timeout);
 	l_timeout_remove(dev->conn_dhcp_timeout);
 =

 	if (dev->conn_netconfig) {
@@ -911,8 +911,8 @@ static void p2p_peer_provision_done(int err, struct wsc=
_credentials_info *creds,
 =

 	dev->conn_enrollee =3D NULL;
 =

-	l_timeout_remove(dev->config_timeout);
-	l_timeout_remove(dev->go_neg_req_timeout);
+	l_timeout_remove(dev->conn_peer_config_timeout);
+	l_timeout_remove(dev->conn_go_neg_req_timeout);
 =

 	if (err < 0) {
 		if (err =3D=3D -ECANCELED && peer->wsc.pending_cancel) {
@@ -1159,8 +1159,9 @@ static bool p2p_provision_scan_notify(int err, struct=
 l_queue *bss_list,
 		if (dev->go_group_id.ssid[bss->ssid_len] !=3D '\0')
 			continue;
 =

-		if (!util_mem_is_zero(dev->go_interface_addr, 6) &&
-				memcmp(bss->addr, dev->go_interface_addr, 6))
+		if (!util_mem_is_zero(dev->conn_peer_interface_addr, 6) &&
+				memcmp(bss->addr, dev->conn_peer_interface_addr,
+					6))
 			l_debug("SSID matched but BSSID didn't match the GO's "
 				"intended interface addr, proceeding anyway");
 =

@@ -1280,9 +1281,9 @@ static bool p2p_provision_scan_notify(int err, struct=
 l_queue *bss_list,
 	}
 =

 	/* Retry a few times if the WSC AP not found or not ready */
-	dev->go_scan_retry++;
+	dev->conn_go_scan_retry++;
 =

-	if (dev->go_scan_retry > 15) {
+	if (dev->conn_go_scan_retry > 15) {
 		p2p_connect_failed(dev);
 		return false;
 	}
@@ -1320,9 +1321,9 @@ static void p2p_provision_scan_start(struct p2p_devic=
e *dev)
 	 * ourselves any work anyway as the Channel List is going to
 	 * contain all of the 2.4 and 5G channels.
 	 */
-	if (dev->go_scan_retry < 12) {
+	if (dev->conn_go_scan_retry < 12) {
 		params.freqs =3D scan_freq_set_new();
-		scan_freq_set_add(params.freqs, dev->go_oper_freq);
+		scan_freq_set_add(params.freqs, dev->conn_go_oper_freq);
 	}
 =

 	dev->scan_id =3D scan_active_full(dev->wdev_id, &params, NULL,
@@ -1337,13 +1338,14 @@ static void p2p_start_client_provision(struct p2p_d=
evice *dev)
 {
 	char bssid_str[18];
 =

-	memcpy(bssid_str, util_address_to_string(dev->go_interface_addr), 18);
-	l_debug("freq=3D%u ssid=3D%s group_addr=3D%s bssid=3D%s", dev->go_oper_fr=
eq,
-		dev->go_group_id.ssid,
+	memcpy(bssid_str, util_address_to_string(dev->conn_peer_interface_addr),
+		18);
+	l_debug("freq=3D%u ssid=3D%s group_addr=3D%s bssid=3D%s",
+		dev->conn_go_oper_freq, dev->go_group_id.ssid,
 		util_address_to_string(dev->go_group_id.device_addr),
 		bssid_str);
 =

-	dev->go_scan_retry =3D 0;
+	dev->conn_go_scan_retry =3D 0;
 	p2p_provision_scan_start(dev);
 }
 =

@@ -1351,14 +1353,14 @@ static void p2p_config_timeout_destroy(void *user_d=
ata)
 {
 	struct p2p_device *dev =3D user_data;
 =

-	dev->config_timeout =3D NULL;
+	dev->conn_peer_config_timeout =3D NULL;
 }
 =

 static void p2p_config_timeout(struct l_timeout *timeout, void *user_data)
 {
 	struct p2p_device *dev =3D user_data;
 =

-	l_timeout_remove(dev->config_timeout);
+	l_timeout_remove(dev->conn_peer_config_timeout);
 =

 	/* Ready to start WSC */
 	p2p_start_client_provision(dev);
@@ -1643,7 +1645,7 @@ static bool p2p_go_negotiation_confirm_cb(const struc=
t mmpdu_header *mpdu,
 		return true;
 	}
 =

-	if (info.dialog_token !=3D dev->go_dialog_token) {
+	if (info.dialog_token !=3D dev->conn_go_dialog_token) {
 		l_error("GO Negotiation Response dialog token doesn't match");
 		p2p_connect_failed(dev);
 		return true;
@@ -1676,7 +1678,7 @@ static bool p2p_go_negotiation_confirm_cb(const struc=
t mmpdu_header *mpdu,
 		return true;
 	}
 =

-	dev->go_oper_freq =3D frequency;
+	dev->conn_go_oper_freq =3D frequency;
 	memcpy(&dev->go_group_id, &info.group_id,
 		sizeof(struct p2p_group_id_attr));
 =

@@ -1685,7 +1687,8 @@ static bool p2p_go_negotiation_confirm_cb(const struc=
t mmpdu_header *mpdu,
 	 * of time indicated by the peer in the GO Negotiation Response's
 	 * Configuration Timeout attribute and start the provisioning phase.
 	 */
-	dev->config_timeout =3D l_timeout_create_ms(dev->go_config_delay,
+	dev->conn_peer_config_timeout =3D l_timeout_create_ms(
+						dev->conn_config_delay,
 						p2p_config_timeout, dev,
 						p2p_config_timeout_destroy);
 	return true;
@@ -1737,7 +1740,7 @@ static void p2p_device_go_negotiation_req_cb(const st=
ruct mmpdu_header *mpdu,
 	if (body_len < 8)
 		return;
 =

-	if (!dev->go_neg_req_timeout || peer !=3D dev->conn_peer) {
+	if (!dev->conn_go_neg_req_timeout || peer !=3D dev->conn_peer) {
 		status =3D P2P_STATUS_FAIL_INFO_NOT_AVAIL;
 		goto respond;
 	}
@@ -1803,12 +1806,13 @@ static void p2p_device_go_negotiation_req_cb(const =
struct mmpdu_header *mpdu,
 		goto p2p_free;
 	}
 =

-	l_timeout_remove(dev->go_neg_req_timeout);
+	l_timeout_remove(dev->conn_go_neg_req_timeout);
 	p2p_device_discovery_stop(dev);
 =

-	dev->go_dialog_token =3D req_info.dialog_token;
-	dev->go_config_delay =3D req_info.config_timeout.go_config_timeout * 10;
-	memcpy(dev->go_interface_addr, req_info.intended_interface_addr, 6);
+	dev->conn_go_dialog_token =3D req_info.dialog_token;
+	dev->conn_config_delay =3D req_info.config_timeout.go_config_timeout * 10;
+	memcpy(dev->conn_peer_interface_addr, req_info.intended_interface_addr,
+		6);
 =

 p2p_free:
 	tie_breaker =3D !req_info.go_tie_breaker;
@@ -1816,7 +1820,7 @@ p2p_free:
 =

 respond:
 	/* Build and send the GO Negotiation Response */
-	resp_info.dialog_token =3D dev->go_dialog_token;
+	resp_info.dialog_token =3D dev->conn_go_dialog_token;
 	resp_info.status =3D status;
 	resp_info.capability.device_caps =3D dev->capability.device_caps;
 	resp_info.capability.group_caps =3D 0;	/* Reserved */
@@ -1885,7 +1889,8 @@ static void p2p_go_negotiation_confirm_done(int error=
, void *user_data)
 	 * time indicated by the peer in the GO Negotiation Response's
 	 * Configuration Timeout attribute and start the provisioning phase.
 	 */
-	dev->config_timeout =3D l_timeout_create_ms(dev->go_config_delay,
+	dev->conn_peer_config_timeout =3D l_timeout_create_ms(
+						dev->conn_config_delay,
 						p2p_config_timeout, dev,
 						p2p_config_timeout_destroy);
 }
@@ -1894,7 +1899,7 @@ static void p2p_go_neg_req_timeout_destroy(void *user=
_data)
 {
 	struct p2p_device *dev =3D user_data;
 =

-	dev->go_neg_req_timeout =3D NULL;
+	dev->conn_go_neg_req_timeout =3D NULL;
 }
 =

 static void p2p_go_neg_req_timeout(struct l_timeout *timeout, void *user_d=
ata)
@@ -1952,7 +1957,7 @@ static bool p2p_go_negotiation_resp_cb(const struct m=
mpdu_header *mpdu,
 			l_error("P2P_STATUS_FAIL_INFO_NOT_AVAIL: Will wait for "
 				"a new GO Negotiation Request before declaring "
 				"failure");
-			dev->go_neg_req_timeout =3D l_timeout_create(120,
+			dev->conn_go_neg_req_timeout =3D l_timeout_create(120,
 						p2p_go_neg_req_timeout, dev,
 						p2p_go_neg_req_timeout_destroy);
 			p2p_device_discovery_start(dev);
@@ -2016,11 +2021,13 @@ static bool p2p_go_negotiation_resp_cb(const struct=
 mmpdu_header *mpdu,
 		return true;
 	}
 =

-	dev->go_config_delay =3D resp_info.config_timeout.go_config_timeout * 10;
-	dev->go_oper_freq =3D frequency;
+	dev->conn_config_delay =3D
+			resp_info.config_timeout.go_config_timeout * 10;
+	dev->conn_go_oper_freq =3D frequency;
 	memcpy(&dev->go_group_id, &resp_info.group_id,
 		sizeof(struct p2p_group_id_attr));
-	memcpy(dev->go_interface_addr, resp_info.intended_interface_addr, 6);
+	memcpy(dev->conn_peer_interface_addr,
+		resp_info.intended_interface_addr, 6);
 =

 	/* Build and send the GO Negotiation Confirmation */
 	confirm_info.dialog_token =3D resp_info.dialog_token;
@@ -2207,8 +2214,8 @@ static bool p2p_provision_disc_resp_cb(const struct m=
mpdu_header *mpdu,
 	 * We might want to make sure that Group Formation is false but the
 	 * Capability attribute is also optional.
 	 */
-	dev->go_oper_freq =3D dev->conn_peer->bss->frequency;
-	memset(dev->go_interface_addr, 0, 6);
+	dev->conn_go_oper_freq =3D dev->conn_peer->bss->frequency;
+	memset(dev->conn_peer_interface_addr, 0, 6);
 	memcpy(dev->go_group_id.device_addr, dev->conn_peer->device_addr, 6);
 	l_strlcpy(dev->go_group_id.ssid,
 			(const char *) dev->conn_peer->bss->ssid,
@@ -3264,7 +3271,7 @@ static void p2p_device_probe_cb(const struct mmpdu_he=
ader *mpdu,
 		return;
 =

 	from_conn_peer =3D
-		dev->go_neg_req_timeout && dev->conn_peer &&
+		dev->conn_go_neg_req_timeout && dev->conn_peer &&
 		!memcmp(mpdu->address_2, dev->conn_peer->bss->addr, 6);
 =

 	wsc_payload =3D ie_tlv_extract_wsc_payload(body, body_len, &wsc_len);
-- =

2.25.1

--===============2478654411478206286==--

