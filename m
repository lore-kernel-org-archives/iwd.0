Content-Type: multipart/mixed; boundary="===============5977833675253239238=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/8] p2p: Add GO-side of GO Negotiation (initiator)
Date: Fri, 11 Sep 2020 21:50:59 +0200
Message-ID: <20200911195103.385070-4-andrew.zaborowski@intel.com>
In-Reply-To: <20200911195103.385070-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5977833675253239238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allow the possibility of becoming the Group-owner when we build the GO
Negotiation Request, parse GO Negotiation Response and build the GO
Negotiation Confirmation, i.e. if we're the initiator of the
negotiation.

Until now the code assumed we can't become the GO or we'd report error.
---
 src/p2p.c | 181 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 144 insertions(+), 37 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index d2ae169d..832e1a20 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -82,6 +82,7 @@ struct p2p_device {
 	unsigned int listen_duration;
 	struct l_queue *discovery_users;
 	struct l_queue *peer_list;
+	unsigned int next_tie_breaker;
 =

 	struct p2p_peer *conn_peer;
 	uint16_t conn_config_method;
@@ -106,9 +107,10 @@ struct p2p_device {
 	uint8_t conn_go_dialog_token;
 	unsigned int conn_go_scan_retry;
 	uint32_t conn_go_oper_freq;
-	struct p2p_group_id_attr go_group_id;
 	uint8_t conn_peer_interface_addr[6];
 =

+	struct p2p_group_id_attr go_group_id;
+
 	bool enabled : 1;
 	bool have_roc_cookie : 1;
 	/*
@@ -119,6 +121,8 @@ struct p2p_device {
 	 * netdev_disconnect, or similar, finishes.
 	 */
 	bool disconnecting : 1;
+	bool is_go : 1;
+	bool conn_go_tie_breaker : 1;
 };
 =

 struct p2p_discovery_user {
@@ -163,6 +167,12 @@ static unsigned int p2p_wfd_disconnect_watch;
 static const int channels_social[] =3D { 1, 6, 11 };
 static const int channels_scan_2_4_other[] =3D { 2, 3, 4, 5, 7, 8, 9, 10 };
 =

+/*
+ * The client side generally receives more testing and we know of fewer
+ * problematic drivers so set a low default Group Owner intent value.
+ */
+#define P2P_GO_INTENT 2
+
 enum {
 	FRAME_GROUP_DEFAULT =3D 0,
 	FRAME_GROUP_LISTEN,
@@ -501,6 +511,7 @@ static void p2p_connection_reset(struct p2p_device *dev)
 =

 	explicit_bzero(dev->conn_psk, 32);
 	dev->conn_retry_count =3D 0;
+	dev->is_go =3D false;
 =

 	if (dev->enabled && !dev->start_stop_cmd_id &&
 			!l_queue_isempty(dev->discovery_users))
@@ -1694,6 +1705,18 @@ static bool p2p_go_negotiation_confirm_cb(const stru=
ct mmpdu_header *mpdu,
 	return true;
 }
 =

+static void p2p_set_group_id(struct p2p_device *dev)
+{
+	const char *name =3D dev->device_info.device_name;
+	char buf[2];
+
+	/* SSID format following section 3.2.1 */
+	p2p_get_random_string(buf, 2);
+	snprintf(dev->go_group_id.ssid, sizeof(dev->go_group_id.ssid),
+			"DIRECT-%c%c-%.22s", buf[0], buf[1], name);
+	memcpy(dev->go_group_id.device_addr, dev->addr, 6);
+}
+
 static void p2p_device_go_negotiation_req_cb(const struct mmpdu_header *mp=
du,
 						const void *body,
 						size_t body_len, int rssi,
@@ -1885,10 +1908,18 @@ static void p2p_go_negotiation_confirm_done(int err=
or, void *user_data)
 	}
 =

 	/*
-	 * Frame was ACKed.  For simplicity wait idly the maximum amount of
-	 * time indicated by the peer in the GO Negotiation Response's
-	 * Configuration Timeout attribute and start the provisioning phase.
+	 * Frame was ACKed.  On the GO start setting the group up right
+	 * away and we'll add the client's Configuation Timeout to the
+	 * WSC start timeout's value.  On the client wait idly the
+	 * maximum amount of time indicated by the peer in the GO
+	 * Negotiation Response's Configuration Timeout attribute and
+	 * start the provisioning phase.
 	 */
+	if (dev->is_go) {
+		p2p_device_interface_create(dev);
+		return;
+	}
+
 	dev->conn_peer_config_timeout =3D l_timeout_create_ms(
 						dev->conn_config_delay,
 						p2p_config_timeout, dev,
@@ -1974,17 +2005,17 @@ static bool p2p_go_negotiation_resp_cb(const struct=
 mmpdu_header *mpdu,
 	 * shall be toggled from the corresponding GO Negotiation Request
 	 * frame."
 	 */
-	if (!resp_info.go_tie_breaker) {
+	if (resp_info.go_tie_breaker =3D=3D dev->conn_go_tie_breaker) {
 		l_error("GO Negotiation Response tie breaker value wrong");
-
-		if (resp_info.go_intent =3D=3D 0) {
-			/* Can't continue */
-			p2p_connect_failed(dev);
-			goto p2p_free;
-		}
+		/* Proceed anyway */
+		dev->conn_go_tie_breaker =3D !resp_info.go_tie_breaker;
 	}
 =

-	if (resp_info.capability.group_caps & P2P_GROUP_CAP_PERSISTENT_GROUP) {
+	dev->is_go =3D P2P_GO_INTENT * 2 + dev->conn_go_tie_breaker >
+		resp_info.go_intent * 2;
+
+	if ((resp_info.capability.group_caps & P2P_GROUP_CAP_PERSISTENT_GROUP)
+			&& !dev->is_go) {
 		l_error("Persistent groups not supported");
 		p2p_connect_failed(dev);
 		goto p2p_free;
@@ -2002,6 +2033,44 @@ static bool p2p_go_negotiation_resp_cb(const struct =
mmpdu_header *mpdu,
 		goto p2p_free;
 	}
 =

+	if (dev->is_go) {
+		const struct l_queue_entry *entry;
+		const struct p2p_channel_entries *entries;
+		int i;
+
+		/*
+		 * Check that our listen channel is in the set supported by the
+		 * Client.
+		 * TODO: if it's not, look for a different channel.
+		 */
+		for (entry =3D l_queue_get_entries(
+					resp_info.channel_list.channel_entries);
+				entry; entry =3D entry->next) {
+			entries =3D entry->data;
+
+			if (entries->oper_class =3D=3D dev->listen_oper_class)
+				break;
+		}
+
+		if (!entry) {
+			l_error("Our Operating Class not listed in "
+				"the GO Negotiation Response");
+			p2p_connect_failed(dev);
+			goto p2p_free;
+		}
+
+		for (i =3D 0; i < entries->n_channels; i++)
+			if (entries->channels[i] =3D=3D dev->listen_channel)
+				break;
+
+		if (i =3D=3D entries->n_channels) {
+			l_error("Our listen channel not listed in "
+				"the GO Negotiation Response");
+			p2p_connect_failed(dev);
+			goto p2p_free;
+		}
+	}
+
 	/* Check whether WFD IE is required, validate it if present */
 	if (!p2p_device_validate_conn_wfd(dev, resp_info.wfd,
 						resp_info.wfd_size)) {
@@ -2009,33 +2078,63 @@ static bool p2p_go_negotiation_resp_cb(const struct=
 mmpdu_header *mpdu,
 		goto p2p_free;
 	}
 =

-	band =3D scan_oper_class_to_band(
+	memcpy(dev->conn_peer_interface_addr, resp_info.intended_interface_addr,
+		6);
+
+	if (dev->is_go) {
+		struct l_queue *channel_list =3D l_queue_new();
+		struct p2p_channel_entries *channel_entries =3D
+			l_malloc(sizeof(struct p2p_channel_entries) + 1);
+
+		p2p_set_group_id(dev);
+
+		dev->conn_config_delay =3D
+			resp_info.config_timeout.client_config_timeout * 10;
+
+		channel_entries->oper_class =3D dev->listen_oper_class;
+		channel_entries->n_channels =3D 1;
+		channel_entries->channels[0] =3D dev->listen_channel;
+		l_queue_push_tail(channel_list, channel_entries);
+
+		/* Build and send the GO Negotiation Confirmation */
+		confirm_info.capability =3D dev->capability;
+		memcpy(confirm_info.operating_channel.country,
+			dev->listen_country, 3);
+		confirm_info.operating_channel.oper_class =3D dev->listen_oper_class;
+		confirm_info.operating_channel.channel_num =3D dev->listen_channel;
+		memcpy(confirm_info.channel_list.country, dev->listen_country, 3);
+		confirm_info.channel_list.channel_entries =3D channel_list;
+		memcpy(&confirm_info.group_id, &dev->go_group_id,
+			sizeof(struct p2p_group_id_attr));
+	} else {
+		band =3D scan_oper_class_to_band(
 			(const uint8_t *) resp_info.operating_channel.country,
 			resp_info.operating_channel.oper_class);
-	frequency =3D scan_channel_to_freq(
+		frequency =3D scan_channel_to_freq(
 					resp_info.operating_channel.channel_num,
 					band);
-	if (!frequency) {
-		l_error("Bad operating channel in GO Negotiation Response");
-		p2p_connect_failed(dev);
-		return true;
-	}
+		if (!frequency) {
+			l_error("Bad operating channel in GO Negotiation Response");
+			p2p_connect_failed(dev);
+			goto p2p_free;
+		}
 =

-	dev->conn_config_delay =3D
+		dev->conn_config_delay =3D
 			resp_info.config_timeout.go_config_timeout * 10;
-	dev->conn_go_oper_freq =3D frequency;
-	memcpy(&dev->go_group_id, &resp_info.group_id,
-		sizeof(struct p2p_group_id_attr));
-	memcpy(dev->conn_peer_interface_addr,
-		resp_info.intended_interface_addr, 6);
+		dev->conn_go_oper_freq =3D frequency;
+		memcpy(&dev->go_group_id, &resp_info.group_id,
+			sizeof(struct p2p_group_id_attr));
+
+		/* Build and send the GO Negotiation Confirmation */
+		confirm_info.capability.device_caps =3D 0;	/* Reserved */
+		confirm_info.capability.group_caps =3D 0;		/* Reserved */
+		confirm_info.operating_channel =3D resp_info.operating_channel;
+		confirm_info.channel_list =3D resp_info.channel_list;
+		resp_info.channel_list.channel_entries =3D NULL;
+	}
 =

-	/* Build and send the GO Negotiation Confirmation */
 	confirm_info.dialog_token =3D resp_info.dialog_token;
 	confirm_info.status =3D P2P_STATUS_SUCCESS;
-	confirm_info.capability.device_caps =3D 0;	/* Reserved */
-	confirm_info.capability.group_caps =3D 0;		/* Reserved */
-	confirm_info.channel_list =3D resp_info.channel_list;
-	confirm_info.operating_channel =3D resp_info.operating_channel;
 =

 	if (dev->conn_own_wfd) {
 		confirm_info.wfd =3D wfd_ie;
@@ -2046,6 +2145,7 @@ static bool p2p_go_negotiation_resp_cb(const struct m=
mpdu_header *mpdu,
 	confirm_body =3D p2p_build_go_negotiation_confirmation(&confirm_info,
 								&confirm_len);
 	confirm_info.wfd =3D NULL;
+	p2p_clear_go_negotiation_confirmation(&confirm_info);
 =

 	if (!confirm_body) {
 		p2p_connect_failed(dev);
@@ -2099,10 +2199,12 @@ static void p2p_start_go_negotiation(struct p2p_dev=
ice *dev)
 	 */
 	unsigned int resp_timeout =3D 600;
 =

+	dev->conn_go_tie_breaker =3D dev->next_tie_breaker++ & 1;
+
 	info.dialog_token =3D 1;
 	info.capability =3D dev->capability;
-	info.go_intent =3D 0;	/* Don't want to be the GO */
-	info.go_tie_breaker =3D 0;
+	info.go_intent =3D P2P_GO_INTENT;
+	info.go_tie_breaker =3D dev->conn_go_tie_breaker;
 	info.config_timeout.go_config_timeout =3D 50;	/* 500ms */
 	info.config_timeout.client_config_timeout =3D 50;	/* 500ms */
 	memcpy(info.listen_channel.country, dev->listen_country, 3);
@@ -2111,11 +2213,9 @@ static void p2p_start_go_negotiation(struct p2p_devi=
ce *dev)
 	memcpy(info.intended_interface_addr, dev->conn_addr, 6);
 =

 	/*
-	 * In theory we support an empty set of operating channels for
-	 * our potential group as a GO but we have to include our
-	 * supported channels because the peer can only choose their
-	 * own channels from our list.  Use the listen channel as the
-	 * preferred operating channel because we have no preference.
+	 * Even if P2P_GO_INTENT is 0, we have to include our supported
+	 * channels because the peer can only choose their own channels
+	 * from our list.
 	 */
 	p2p_device_fill_channel_list(dev, &info.channel_list);
 	memcpy(info.operating_channel.country, dev->listen_country, 3);
@@ -3615,6 +3715,13 @@ struct p2p_device *p2p_device_update_from_genl(struc=
t l_genl_msg *msg,
 	gethostname(hostname, sizeof(hostname));
 	dev->connections_left =3D 1;
 =

+	/*
+	 * Section 3.1.4.2: "The Tie breaker bit in a first GO Negotiation
+	 * Request frame (for instance after power up) shall be set to 0 or 1
+	 * randomly, such that both values occur equally on average."
+	 */
+	dev->next_tie_breaker =3D l_getrandom_uint32();
+
 	/* TODO: allow masking capability bits through a setting? */
 	dev->capability.device_caps =3D P2P_DEVICE_CAP_CONCURRENT_OP;
 	dev->capability.group_caps =3D 0;
-- =

2.25.1

--===============5977833675253239238==--

