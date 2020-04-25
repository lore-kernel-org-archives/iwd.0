Content-Type: multipart/mixed; boundary="===============8587291144599712061=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 08/11] p2p: Scan for the provision BSS
Date: Sat, 25 Apr 2020 11:09:31 +0200
Message-ID: <20200425090934.22285-8-andrew.zaborowski@intel.com>
In-Reply-To: <20200425090934.22285-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8587291144599712061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the next step after Provision Discovery or GO Negotiation that is
scanning for the WSC BSS that the GO has set up for client provisioning.
---
 src/p2p.c | 223 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 222 insertions(+), 1 deletion(-)

diff --git a/src/p2p.c b/src/p2p.c
index e41cc4f7..0e57b375 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -86,11 +86,13 @@ struct p2p_device {
 	char *conn_pin;
 	uint8_t conn_addr[6];
 	uint16_t conn_password_id;
+	struct scan_bss *conn_wsc_bss;
 =

 	struct l_timeout *config_timeout;
 	unsigned long go_config_delay;
 	struct l_timeout *go_neg_req_timeout;
 	uint8_t go_dialog_token;
+	unsigned int go_scan_retry;
 	uint32_t go_oper_freq;
 	struct p2p_group_id_attr go_group_id;
 	uint8_t go_interface_addr[6];
@@ -329,6 +331,10 @@ static void p2p_connect_failed(struct p2p_device *dev)
 	if (!peer)
 		return;
 =

+	/* Are we in the scan for the WSC provision bss */
+	if (dev->scan_id)
+		scan_cancel(dev->wdev_id, dev->scan_id);
+
 	if (peer->wsc.pending_connect)
 		dbus_pending_reply(&peer->wsc.pending_connect,
 				dbus_error_failed(peer->wsc.pending_connect));
@@ -420,6 +426,11 @@ static const struct frame_xchg_prefix p2p_frame_pd_res=
p =3D {
 	.len =3D 7,
 };
 =

+static void p2p_device_interface_create(struct p2p_device *dev)
+{
+	/* TODO */
+}
+
 static void p2p_scan_destroy(void *user_data)
 {
 	struct p2p_device *dev =3D user_data;
@@ -427,6 +438,215 @@ static void p2p_scan_destroy(void *user_data)
 	dev->scan_id =3D 0;
 }
 =

+static void p2p_provision_scan_start(struct p2p_device *dev);
+
+static bool p2p_provision_scan_notify(int err, struct l_queue *bss_list,
+					void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+	const struct l_queue_entry *entry;
+	static const uint8_t wildcard_addr[6] =3D
+		{ 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+
+	l_debug("err=3D%i, len(bss_list)=3D%i", err, l_queue_length(bss_list));
+
+	if (err) {
+		l_error("P2P provision scan failed: %s (%i)", strerror(-err),
+			-err);
+		p2p_connect_failed(dev);
+		return false;
+	}
+
+	for (entry =3D l_queue_get_entries(bss_list); entry;
+			entry =3D entry->next) {
+		struct scan_bss *bss =3D entry->data;
+		const uint8_t *group_id;
+		bool selected_reg;
+		struct p2p_capability_attr *capability;
+		enum wsc_device_password_id device_password_id;
+		const uint8_t *amacs;
+
+		/*
+		 * Check if we found our target GO, some of these checks may
+		 * need to be gradually relaxed as we discover non-compliant
+		 * implementations but at least print a debug statement when
+		 * something doesn't match.
+		 */
+
+		if (strncmp((const char *) bss->ssid, dev->go_group_id.ssid,
+				bss->ssid_len))
+			continue;
+
+		if (dev->go_group_id.ssid[bss->ssid_len] !=3D '\0')
+			continue;
+
+		if (!util_mem_is_zero(dev->go_interface_addr, 6) &&
+				memcmp(bss->addr, dev->go_interface_addr, 6))
+			l_debug("SSID matched but BSSID didn't match the GO's "
+				"intended interface addr, proceeding anyway");
+
+		if (!bss->wsc) {
+			l_error("SSID matched but no valid WSC IE");
+			continue;
+		}
+
+		if (bss->source_frame =3D=3D SCAN_BSS_PROBE_RESP) {
+			struct wsc_probe_response wsc_info;
+
+			if (!bss->p2p_probe_resp_info) {
+				l_error("SSID matched but no valid P2P IE");
+				continue;
+			}
+
+			if (wsc_parse_probe_response(bss->wsc, bss->wsc_size,
+							&wsc_info) < 0) {
+				l_error("SSID matched but can't parse WSC "
+					"Probe Response info");
+				continue;
+			}
+
+			group_id =3D bss->p2p_probe_resp_info->
+				device_info.device_addr;
+			selected_reg =3D wsc_info.selected_registrar;
+			capability =3D &bss->p2p_probe_resp_info->capability;
+			device_password_id =3D wsc_info.device_password_id;
+			amacs =3D wsc_info.authorized_macs;
+		} else if (bss->source_frame =3D=3D SCAN_BSS_BEACON) {
+			struct wsc_beacon wsc_info;
+
+			if (!bss->p2p_beacon_info) {
+				l_error("SSID matched but no valid P2P IE");
+				continue;
+			}
+
+			if (wsc_parse_beacon(bss->wsc, bss->wsc_size,
+						&wsc_info) < 0) {
+				l_error("SSID matched but can't parse WSC "
+					"Beacon info");
+				continue;
+			}
+
+			group_id =3D bss->p2p_beacon_info->device_addr;
+			selected_reg =3D wsc_info.selected_registrar;
+			capability =3D &bss->p2p_beacon_info->capability;
+			device_password_id =3D wsc_info.device_password_id;
+			amacs =3D wsc_info.authorized_macs;
+		} else
+			continue;
+
+		if (memcmp(group_id, dev->go_group_id.device_addr, 6)) {
+			l_error("SSID matched but Group ID address didn't");
+			continue;
+		}
+
+		if (!selected_reg) {
+			/*
+			 * Debug level because this will sometimes happen
+			 * while the target is setting up the GO mode in the
+			 * course of normal operation, and gets set to true
+			 * in a few seconds, we just need to keep scanning.
+			 */
+			l_debug("SSID matched but not a Selected Reg");
+			continue;
+		}
+
+		if (dev->conn_peer->group && (capability->group_caps &
+					P2P_GROUP_CAP_GROUP_FORMATION)) {
+			l_error("SSID matched but not in Group Formation");
+			continue;
+		}
+
+		if (!dev->conn_peer->group && !(capability->group_caps &
+					P2P_GROUP_CAP_GROUP_FORMATION))
+			/*
+			 * We have to ignore this one for interoperability
+			 * with some devices.
+			 */
+			l_debug("SSID matched but GO not in Group Formation, "
+				"proceeding anyway");
+
+		if (capability->group_caps & P2P_GROUP_CAP_GROUP_LIMIT) {
+			l_error("SSID matched but group already full");
+			continue;
+		}
+
+		if (device_password_id !=3D dev->conn_password_id) {
+			l_error("SSID matched wrong Password ID");
+			continue;
+		}
+
+		if (!util_mem_is_zero(amacs, 30)) {
+			bool amacs_match =3D false;
+			int i;
+
+			for (i =3D 0; i < 5; i++, amacs +=3D 6)
+				if (!memcmp(amacs, dev->addr, 6) ||
+						!memcmp(amacs, wildcard_addr, 6))
+					amacs_match =3D true;
+
+			if (!amacs_match) {
+				l_error("SSID matched we're not in AMacs");
+				continue;
+			}
+		}
+
+		l_debug("GO found in the scan results");
+
+		dev->conn_wsc_bss =3D bss;
+		p2p_device_interface_create(dev);
+		l_queue_remove(bss_list, bss);
+		l_queue_destroy(bss_list,
+				(l_queue_destroy_func_t) scan_bss_free);
+		return true;
+	}
+
+	/* Retry a few times if the WSC AP not found or not ready */
+	dev->go_scan_retry++;
+
+	if (dev->go_scan_retry > 15) {
+		p2p_connect_failed(dev);
+		return false;
+	}
+
+	p2p_provision_scan_start(dev);
+	return false;
+}
+
+static void p2p_provision_scan_start(struct p2p_device *dev)
+{
+	struct scan_parameters params =3D {};
+	uint8_t buf[256];
+
+	params.flush =3D true;
+	params.no_cck_rates =3D true;
+	params.ssid =3D dev->go_group_id.ssid;
+	params.extra_ie =3D p2p_build_scan_ies(dev, buf, sizeof(buf),
+						&params.extra_ie_size);
+	L_WARN_ON(!params.extra_ie);
+
+	/*
+	 * Initially scan just the Operating Channel the GO reported
+	 * during the negotiation.  In theory there's no guarantee that
+	 * it is going to be on that channel so we should fall back
+	 * to scanning all the channels listed in the Channel List
+	 * attribute.  For simplicity we just do a full scan in that
+	 * scenario -- for most target P2P devices we wouldn't be saving
+	 * ourselves any work anyway as the Channel List is going to
+	 * contain all of the 2.4 and 5G channels.
+	 */
+	if (dev->go_scan_retry < 12) {
+		params.freqs =3D scan_freq_set_new();
+		scan_freq_set_add(params.freqs, dev->go_oper_freq);
+	}
+
+	dev->scan_id =3D scan_active_full(dev->wdev_id, &params, NULL,
+					p2p_provision_scan_notify, dev,
+					p2p_scan_destroy);
+
+	if (params.freqs)
+		scan_freq_set_free(params.freqs);
+}
+
 static void p2p_start_client_provision(struct p2p_device *dev)
 {
 	char bssid_str[18];
@@ -437,7 +657,8 @@ static void p2p_start_client_provision(struct p2p_devic=
e *dev)
 		util_address_to_string(dev->go_group_id.device_addr),
 		bssid_str);
 =

-	/* TODO: start client provisioning */
+	dev->go_scan_retry =3D 0;
+	p2p_provision_scan_start(dev);
 }
 =

 static void p2p_config_timeout_destroy(void *user_data)
-- =

2.25.1

--===============8587291144599712061==--

