Content-Type: multipart/mixed; boundary="===============0966735023476772611=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 12/19] p2p: Handle GO Negotiation Response, send Confirmation
Date: Thu, 23 Apr 2020 18:24:40 +0200
Message-ID: <20200423162447.15750-12-andrew.zaborowski@intel.com>
In-Reply-To: <20200423162447.15750-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0966735023476772611==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Parse the GO Negotiation Response frame and if no errors found send the
GO Negotiation Confirmation.  If that gets ACKed wait for the GO to set
up the group.
---
 src/p2p.c | 198 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 196 insertions(+), 2 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index 89faa87e..f64cbaa8 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -88,6 +88,12 @@ struct p2p_device {
 	uint8_t conn_addr[6];
 	uint16_t conn_password_id;
 =

+	struct l_timeout *config_timeout;
+	unsigned long go_config_delay;
+	uint32_t go_oper_freq;
+	struct p2p_group_id_attr go_group_id;
+	uint8_t go_interface_addr[6];
+
 	bool enabled : 1;
 };
 =

@@ -294,6 +300,8 @@ static void p2p_connection_reset(struct p2p_device *dev)
 	l_dbus_property_changed(dbus_get_bus(), p2p_device_get_path(dev),
 				IWD_P2P_INTERFACE, "AvailableConnections");
 =

+	l_timeout_remove(dev->config_timeout);
+
 	frame_watch_group_remove(dev->wdev_id, FRAME_GROUP_CONNECT);
 	frame_xchg_stop(dev->wdev_id);
 =

@@ -390,6 +398,53 @@ static void p2p_scan_destroy(void *user_data)
 	dev->scan_id =3D 0;
 }
 =

+static void p2p_start_client_provision(struct p2p_device *dev)
+{
+	char bssid_str[18];
+
+	memcpy(bssid_str, util_address_to_string(dev->go_interface_addr), 18);
+	l_debug("freq=3D%u ssid=3D%s group_addr=3D%s bssid=3D%s", dev->go_oper_fr=
eq,
+		dev->go_group_id.ssid,
+		util_address_to_string(dev->go_group_id.device_addr),
+		bssid_str);
+
+	/* TODO: start client provisioning */
+}
+
+static void p2p_config_timeout_destroy(void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+
+	dev->config_timeout =3D NULL;
+}
+
+static void p2p_config_timeout(struct l_timeout *timeout, void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+
+	l_timeout_remove(dev->config_timeout);
+
+	/* Ready to start WSC */
+	p2p_start_client_provision(dev);
+}
+
+/*
+ * Called by GO Negotiation Response and Confirmation receive handlers,
+ * in both cases the channel lists are required to be subsets of our
+ * own supported channels and the Operating Channel must appear in the
+ * channel list.
+ */
+static bool p2p_device_validate_channel_list(struct p2p_device *dev,
+				const struct p2p_channel_list_attr *attr,
+				const struct p2p_channel_attr *oper_channel)
+{
+	if (l_queue_isempty(attr->channel_entries))
+		return false;
+
+	/* TODO */
+	return true;
+}
+
 /*
  * It seems that sending more than about 42 channels in a frame's Channel
  * List attribute will baffle some devices enough that they will ignore
@@ -449,12 +504,151 @@ static void p2p_device_fill_channel_list(struct p2p_=
device *dev,
 	l_queue_push_tail(attr->channel_entries, channel_entry);
 }
 =

+static void p2p_go_negotiation_confirm_done(int error, void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+
+	if (error) {
+		/* TODO: we should probably ignore the missing ACK error */
+		l_error("Sending the GO Negotiation Confirm failed: %s (%i)",
+			strerror(-error), -error);
+		p2p_connect_failed(dev);
+		return;
+	}
+
+	/*
+	 * Frame was ACKed.  For simplicity wait idly the maximum amount of
+	 * time indicated by the peer in the GO Negotiation Response's
+	 * Configuration Timeout attribute and start the provisioning phase.
+	 */
+	dev->config_timeout =3D l_timeout_create_ms(dev->go_config_delay,
+						p2p_config_timeout, dev,
+						p2p_config_timeout_destroy);
+}
+
 static bool p2p_go_negotiation_resp_cb(const struct mmpdu_header *mpdu,
 					const void *body, size_t body_len,
 					int rssi, struct p2p_device *dev)
 {
-	/* TODO: handle the GO Negotiation Response frame */
-	return false;
+	struct p2p_go_negotiation_resp resp_info;
+	struct p2p_go_negotiation_confirmation confirm_info =3D {};
+	uint8_t *confirm_body;
+	size_t confirm_len;
+	int r;
+	struct iovec iov[16];
+	int iov_len =3D 0;
+	enum scan_band band;
+	uint32_t frequency;
+
+	l_debug("");
+
+	if (!dev->conn_peer)
+		return true;
+
+	if (body_len < 8) {
+		l_error("GO Negotiation Response frame too short");
+		p2p_connect_failed(dev);
+		return true;
+	}
+
+	r =3D p2p_parse_go_negotiation_resp(body + 7, body_len - 7, &resp_info);
+	if (r < 0) {
+		l_error("GO Negotiation Response parse error %s (%i)",
+			strerror(-r), -r);
+		p2p_connect_failed(dev);
+		return true;
+	}
+
+	if (resp_info.dialog_token !=3D 1) {
+		l_error("GO Negotiation Response dialog token doesn't match");
+		p2p_connect_failed(dev);
+		return true;
+	}
+
+	if (resp_info.status !=3D P2P_STATUS_SUCCESS) {
+		l_error("GO Negotiation Response status %i", resp_info.status);
+		p2p_connect_failed(dev);
+		return true;
+	}
+
+	/*
+	 * 3.1.4.2: "The Tie breaker bit in a GO Negotiation Response frame
+	 * shall be toggled from the corresponding GO Negotiation Request
+	 * frame."
+	 */
+	if (!resp_info.go_tie_breaker) {
+		l_error("GO Negotiation Response tie breaker value wrong");
+
+		if (resp_info.go_intent =3D=3D 0) {
+			/* Can't continue */
+			p2p_connect_failed(dev);
+			return true;
+		}
+	}
+
+	if (resp_info.capability.group_caps & P2P_GROUP_CAP_PERSISTENT_GROUP) {
+		l_error("Persistent groups not supported");
+		p2p_connect_failed(dev);
+		return true;
+	}
+
+	if (resp_info.device_password_id !=3D dev->conn_password_id) {
+		l_error("GO Negotiation Response WSC device password ID wrong");
+		p2p_connect_failed(dev);
+		return true;
+	}
+
+	if (!p2p_device_validate_channel_list(dev, &resp_info.channel_list,
+						&resp_info.operating_channel))
+		return true;
+
+	band =3D scan_oper_class_to_band(
+			(const uint8_t *) resp_info.operating_channel.country,
+			resp_info.operating_channel.oper_class);
+	frequency =3D scan_channel_to_freq(
+					resp_info.operating_channel.channel_num,
+					band);
+	if (!frequency) {
+		l_error("Bad operating channel in GO Negotiation Response");
+		p2p_connect_failed(dev);
+		return true;
+	}
+
+	dev->go_config_delay =3D resp_info.config_timeout.go_config_timeout * 10;
+	dev->go_oper_freq =3D frequency;
+	memcpy(&dev->go_group_id, &resp_info.group_id,
+		sizeof(struct p2p_group_id_attr));
+	memcpy(dev->go_interface_addr, resp_info.intended_interface_addr, 6);
+
+	/* Build and send the GO Negotiation Confirmation */
+	confirm_info.dialog_token =3D resp_info.dialog_token;
+	confirm_info.status =3D P2P_STATUS_SUCCESS;
+	confirm_info.capability.device_caps =3D 0;	/* Reserved */
+	confirm_info.capability.group_caps =3D 0;		/* Reserved */
+	confirm_info.channel_list =3D resp_info.channel_list;
+	confirm_info.operating_channel =3D resp_info.operating_channel;
+
+	confirm_body =3D p2p_build_go_negotiation_confirmation(&confirm_info,
+								&confirm_len);
+	p2p_clear_go_negotiation_resp(&resp_info);
+
+	if (!confirm_body) {
+		p2p_connect_failed(dev);
+		return true;
+	}
+
+	iov[iov_len].iov_base =3D confirm_body;
+	iov[iov_len].iov_len =3D confirm_len;
+	iov_len++;
+
+	/* WFD and other service IEs go here */
+
+	iov[iov_len].iov_base =3D NULL;
+
+	p2p_peer_frame_xchg(dev->conn_peer, iov, dev->conn_peer->device_addr,
+				0, 0, 0, false, FRAME_GROUP_CONNECT,
+				p2p_go_negotiation_confirm_done, NULL);
+	return true;
 }
 =

 static void p2p_go_negotiation_req_done(int error, void *user_data)
-- =

2.20.1

--===============0966735023476772611==--

