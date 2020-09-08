Content-Type: multipart/mixed; boundary="===============1535977411886627201=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 10/17] p2p: Add GO-side of GO Negotiation (responder)
Date: Wed, 09 Sep 2020 01:49:26 +0200
Message-ID: <20200908234933.301439-10-andrew.zaborowski@intel.com>
In-Reply-To: <20200908234933.301439-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1535977411886627201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allow the possibility of becoming the Group-owner when we parse the GO
Negotiation Request, build GO Negotiation Response and parse the GO
Negotiation Confirmation, i.e. if we're responding to a negotiation
initiated by the peer after it needed to request user action.

Until now the code assumed we can't become the GO or we'd report error.
---
 src/p2p.c | 217 ++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 169 insertions(+), 48 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index 62dfef09..8e7da6d7 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1636,8 +1636,6 @@ static bool p2p_go_negotiation_confirm_cb(const struc=
t mmpdu_header *mpdu,
 {
 	struct p2p_go_negotiation_confirmation info;
 	int r;
-	enum scan_band band;
-	uint32_t frequency;
 =

 	l_debug("");
 =

@@ -1668,40 +1666,79 @@ static bool p2p_go_negotiation_confirm_cb(const str=
uct mmpdu_header *mpdu,
 		return true;
 	}
 =

-	if (!p2p_device_validate_channel_list(dev, &info.channel_list,
-						&info.operating_channel))
-		return true;
-
-	band =3D scan_oper_class_to_band(
-			(const uint8_t *) info.operating_channel.country,
-			info.operating_channel.oper_class);
-	frequency =3D scan_channel_to_freq(info.operating_channel.channel_num,
-						band);
-	if (!frequency) {
-		l_error("Bad operating channel in GO Negotiation Confirmation");
+	/* Check whether WFD IE is required, validate it if present */
+	if (!p2p_device_validate_conn_wfd(dev, info.wfd, info.wfd_size)) {
 		p2p_connect_failed(dev);
 		return true;
 	}
 =

-	/* Check whether WFD IE is required, validate it if present */
-	if (!p2p_device_validate_conn_wfd(dev, info.wfd, info.wfd_size)) {
+	/*
+	 * In both scenarios the Channel List is a subset of what we previously
+	 * sent in the GO Negotiation Response and must contain the Operating
+	 * Channel.
+	 */
+	if (!p2p_device_validate_channel_list(dev, &info.channel_list,
+						&info.operating_channel)) {
 		p2p_connect_failed(dev);
 		return true;
 	}
 =

-	dev->conn_go_oper_freq =3D frequency;
-	memcpy(&dev->go_group_id, &info.group_id,
-		sizeof(struct p2p_group_id_attr));
-
 	/*
-	 * Confirmation received.  For simplicity wait idly the maximum amount
-	 * of time indicated by the peer in the GO Negotiation Response's
-	 * Configuration Timeout attribute and start the provisioning phase.
+	 * Not validating .capability.group_caps, it's either reserved
+	 * (dev->is_go) or has to be identical to that in the GO Negotiation
+	 * Request (!dev->is_go).
 	 */
-	dev->conn_peer_config_timeout =3D l_timeout_create_ms(
+
+	if (dev->is_go) {
+		if (memcmp(info.operating_channel.country,
+				dev->listen_country, 3) ||
+				info.operating_channel.oper_class !=3D
+				dev->listen_oper_class ||
+				info.operating_channel.channel_num !=3D
+				dev->listen_channel) {
+			l_error("Bad operating channel in GO Negotiation "
+				"Confirmation");
+			p2p_connect_failed(dev);
+			return true;
+		}
+
+		/*
+		 * Start setting the group up right away and we'll add the
+		 * client's Configuation Timeout to the WSC start timeout's
+		 * value.
+		 */
+		p2p_device_interface_create(dev);
+	} else {
+		enum scan_band band =3D scan_oper_class_to_band(
+			(const uint8_t *) info.operating_channel.country,
+			info.operating_channel.oper_class);
+		uint32_t frequency =3D scan_channel_to_freq(
+					info.operating_channel.channel_num,
+					band);
+
+		if (!frequency) {
+			l_error("Bad operating channel in GO Negotiation "
+				"Confirmation");
+			p2p_connect_failed(dev);
+			return true;
+		}
+
+		dev->conn_go_oper_freq =3D frequency;
+		memcpy(&dev->go_group_id, &info.group_id,
+			sizeof(struct p2p_group_id_attr));
+
+		/*
+		 * Confirmation received.  For simplicity wait idly the maximum
+		 * amount of time indicated by the peer in the GO Negotiation
+		 * Request's Configuration Timeout attribute and start the
+		 * provisioning phase.
+		 */
+		dev->conn_peer_config_timeout =3D l_timeout_create_ms(
 						dev->conn_config_delay,
 						p2p_config_timeout, dev,
 						p2p_config_timeout_destroy);
+	}
+
 	return true;
 }
 =

@@ -1732,7 +1769,6 @@ static void p2p_device_go_negotiation_req_cb(const st=
ruct mmpdu_header *mpdu,
 	int iov_len =3D 0;
 	struct p2p_peer *peer;
 	enum p2p_attr_status_code status =3D P2P_STATUS_SUCCESS;
-	bool tie_breaker =3D false;
 =

 	l_debug("");
 =

@@ -1781,24 +1817,12 @@ static void p2p_device_go_negotiation_req_cb(const =
struct mmpdu_header *mpdu,
 		goto respond;
 	}
 =

-	if (req_info.go_intent =3D=3D 0 && !req_info.go_tie_breaker) {
-		l_error("Can't negotiate client role and GO operation not "
-			"supported");
-
-		if (peer->wsc.pending_connect) {
-			struct l_dbus_message *reply =3D
-				dbus_error_not_supported(
-						peer->wsc.pending_connect);
-
-			dbus_pending_reply(&peer->wsc.pending_connect, reply);
-		}
-
-		p2p_connect_failed(dev);
-		status =3D P2P_STATUS_FAIL_INCOMPATIBLE_PARAMS;
-		goto p2p_free;
-	}
+	dev->conn_go_tie_breaker =3D !req_info.go_tie_breaker;
+	dev->is_go =3D P2P_GO_INTENT * 2 + dev->conn_go_tie_breaker >
+		req_info.go_intent * 2;
 =

-	if (req_info.capability.group_caps & P2P_GROUP_CAP_PERSISTENT_GROUP) {
+	if ((req_info.capability.group_caps & P2P_GROUP_CAP_PERSISTENT_GROUP) &&
+			!dev->is_go) {
 		if (peer->wsc.pending_connect) {
 			struct l_dbus_message *reply =3D
 				dbus_error_not_supported(
@@ -1820,6 +1844,70 @@ static void p2p_device_go_negotiation_req_cb(const s=
truct mmpdu_header *mpdu,
 		goto p2p_free;
 	}
 =

+	if (!p2p_device_validate_channel_list(dev, &req_info.channel_list,
+						&req_info.operating_channel)) {
+		p2p_connect_failed(dev);
+		status =3D P2P_STATUS_FAIL_INCOMPATIBLE_PARAMS;
+		goto p2p_free;
+	}
+
+	if (dev->is_go) {
+		const struct l_queue_entry *entry;
+		const struct p2p_channel_entries *entries;
+		int i;
+
+		/*
+		 * Section 3.1.4.2.1: "The Channel List attribute shall
+		 * indicate the channels that the P2P Device can support as
+		 * Operating Channel of the P2P Group if it becomes P2P Group
+		 * Owner."
+		 * Section 3.1.4.2.2: "The channels indicated in the Channel
+		 * List shall only include channels from the Channel List
+		 * attribute in the GO Negotiation Request frame. [...]
+		 * The channel indicated in the Operating Channel attribute
+		 * shall be one of the channels in the Channel List attribute
+		 * in the GO Negotiation Response frame."
+		 *
+		 * Since the sender is not becoming the GO this shouldn't
+		 * affect us but following 3.1.4.2.2 our operating channel
+		 * should be one of those listed in the GO Negotiation
+		 * Response which in turn are the subset of those in the
+		 * Request.  So effectively the list in the Request limits
+		 * the peer's set of supported operating channels both as the
+		 * GO and the Client.  Check that our listen channel is in
+		 * that set.
+		 * TODO: if it's not, look for a different channel.
+		 */
+		for (entry =3D l_queue_get_entries(
+					req_info.channel_list.channel_entries);
+				entry; entry =3D entry->next) {
+			entries =3D entry->data;
+
+			if (entries->oper_class =3D=3D dev->listen_oper_class)
+				break;
+		}
+
+		if (!entry) {
+			l_error("Our Operating Class not listed in "
+				"the GO Negotiation Request");
+			p2p_connect_failed(dev);
+			status =3D P2P_STATUS_FAIL_NO_COMMON_CHANNELS;
+			goto p2p_free;
+		}
+
+		for (i =3D 0; i < entries->n_channels; i++)
+			if (entries->channels[i] =3D=3D dev->listen_channel)
+				break;
+
+		if (i =3D=3D entries->n_channels) {
+			l_error("Our listen channel not listed in "
+				"the GO Negotiation Request");
+			p2p_connect_failed(dev);
+			status =3D P2P_STATUS_FAIL_NO_COMMON_CHANNELS;
+			goto p2p_free;
+		}
+	}
+
 	/* Check whether WFD IE is required, validate it if present */
 	if (!p2p_device_validate_conn_wfd(dev, req_info.wfd,
 						req_info.wfd_size)) {
@@ -1832,29 +1920,62 @@ static void p2p_device_go_negotiation_req_cb(const =
struct mmpdu_header *mpdu,
 	p2p_device_discovery_stop(dev);
 =

 	dev->conn_go_dialog_token =3D req_info.dialog_token;
-	dev->conn_config_delay =3D req_info.config_timeout.go_config_timeout * 10;
 	memcpy(dev->conn_peer_interface_addr, req_info.intended_interface_addr,
 		6);
 =

+	if (dev->is_go && dev->conn_peer) {
+		p2p_set_group_id(dev);
+
+		dev->conn_config_delay =3D
+			req_info.config_timeout.client_config_timeout * 10;
+	} else {
+		dev->conn_config_delay =3D
+			req_info.config_timeout.go_config_timeout * 10;
+	}
+
 p2p_free:
-	tie_breaker =3D !req_info.go_tie_breaker;
+	dev->conn_go_tie_breaker =3D !req_info.go_tie_breaker;
 	p2p_clear_go_negotiation_req(&req_info);
 =

 respond:
 	/* Build and send the GO Negotiation Response */
 	resp_info.dialog_token =3D dev->conn_go_dialog_token;
 	resp_info.status =3D status;
-	resp_info.capability.device_caps =3D dev->capability.device_caps;
-	resp_info.capability.group_caps =3D 0;	/* Reserved */
-	resp_info.go_intent =3D 0;		/* Don't want to be the GO */
-	resp_info.go_tie_breaker =3D tie_breaker;
+
+	if (dev->is_go && dev->conn_peer) {
+		struct l_queue *channel_list =3D l_queue_new();
+		struct p2p_channel_entries *channel_entries =3D
+			l_malloc(sizeof(struct p2p_channel_entries) + 1);
+
+		resp_info.capability =3D dev->capability;
+		memcpy(resp_info.operating_channel.country,
+			dev->listen_country, 3);
+		resp_info.operating_channel.oper_class =3D dev->listen_oper_class;
+		resp_info.operating_channel.channel_num =3D dev->listen_channel;
+		memcpy(&resp_info.group_id, &dev->go_group_id,
+			sizeof(struct p2p_group_id_attr));
+
+		channel_entries->oper_class =3D dev->listen_oper_class;
+		channel_entries->n_channels =3D 1;
+		channel_entries->channels[0] =3D dev->listen_channel;
+		l_queue_push_tail(channel_list, channel_entries);
+
+		memcpy(resp_info.channel_list.country, dev->listen_country, 3);
+		resp_info.channel_list.channel_entries =3D channel_list;
+	} else {
+		resp_info.capability.device_caps =3D dev->capability.device_caps;
+		resp_info.capability.group_caps =3D 0;	/* Reserved */
+		p2p_device_fill_channel_list(dev, &resp_info.channel_list);
+	}
+
+	resp_info.go_intent =3D P2P_GO_INTENT;
+	resp_info.go_tie_breaker =3D dev->conn_go_tie_breaker;
 	resp_info.config_timeout.go_config_timeout =3D 50;	/* 500ms */
 	resp_info.config_timeout.client_config_timeout =3D 50;	/* 500ms */
 =

 	if (dev->conn_peer)
 		memcpy(resp_info.intended_interface_addr, dev->conn_addr, 6);
 =

-	p2p_device_fill_channel_list(dev, &resp_info.channel_list);
 	resp_info.device_info =3D dev->device_info;
 	resp_info.device_info.wsc_config_methods =3D dev->conn_config_method;
 	resp_info.device_password_id =3D dev->conn_password_id;
-- =

2.25.1

--===============1535977411886627201==--

