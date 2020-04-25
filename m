Content-Type: multipart/mixed; boundary="===============6235075287391542428=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 05/11] p2p: Handle the Information Not Available response code
Date: Sat, 25 Apr 2020 11:09:28 +0200
Message-ID: <20200425090934.22285-5-andrew.zaborowski@intel.com>
In-Reply-To: <20200425090934.22285-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6235075287391542428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handle the scenario where the peer's P2P state machine doesn't know
whether a connection has been authorized by the user and needs some time
to ask the user or a higher software layer whether to accept a
connection.  In that case their GO Negotiation Response to our GO
Negotiation Request will have the status code "Fail: Information Not
Available" and we need to give the peer 120s to start a new GO
Negotiation with us.  In this patch we handle the GO Negotiation
responder side where we parse the Request frame, build and send the
Response and finally parse the Confirmation.  The existing code so far
only did the initiator side.
---
 src/p2p.c | 379 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 374 insertions(+), 5 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index bf44ceda..dece0d29 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -89,6 +89,8 @@ struct p2p_device {
 =

 	struct l_timeout *config_timeout;
 	unsigned long go_config_delay;
+	struct l_timeout *go_neg_req_timeout;
+	uint8_t go_dialog_token;
 	uint32_t go_oper_freq;
 	struct p2p_group_id_attr go_group_id;
 	uint8_t go_interface_addr[6];
@@ -300,6 +302,7 @@ static void p2p_connection_reset(struct p2p_device *dev)
 				IWD_P2P_INTERFACE, "AvailableConnections");
 =

 	l_timeout_remove(dev->config_timeout);
+	l_timeout_remove(dev->go_neg_req_timeout);
 =

 	frame_watch_group_remove(dev->wdev_id, FRAME_GROUP_CONNECT);
 	frame_xchg_stop(dev->wdev_id);
@@ -381,6 +384,15 @@ static void p2p_peer_frame_xchg(struct p2p_peer *peer,=
 struct iovec *tx_body,
 	l_free(frame);
 }
 =

+static const struct frame_xchg_prefix p2p_frame_go_neg_req =3D {
+	/* Management -> Public Action -> P2P -> GO Negotiation Request */
+	.data =3D (uint8_t []) {
+		0x04, 0x09, 0x50, 0x6f, 0x9a, 0x09,
+		P2P_ACTION_GO_NEGOTIATION_REQ
+	},
+	.len =3D 7,
+};
+
 static const struct frame_xchg_prefix p2p_frame_go_neg_resp =3D {
 	/* Management -> Public Action -> P2P -> GO Negotiation Response */
 	.data =3D (uint8_t []) {
@@ -390,6 +402,15 @@ static const struct frame_xchg_prefix p2p_frame_go_neg=
_resp =3D {
 	.len =3D 7,
 };
 =

+static const struct frame_xchg_prefix p2p_frame_go_neg_confirm =3D {
+	/* Management -> Public Action -> P2P -> GO Negotiation Confirm */
+	.data =3D (uint8_t []) {
+		0x04, 0x09, 0x50, 0x6f, 0x9a, 0x09,
+		P2P_ACTION_GO_NEGOTIATION_CONFIRM
+	},
+	.len =3D 7,
+};
+
 static void p2p_scan_destroy(void *user_data)
 {
 	struct p2p_device *dev =3D user_data;
@@ -427,6 +448,26 @@ static void p2p_config_timeout(struct l_timeout *timeo=
ut, void *user_data)
 	p2p_start_client_provision(dev);
 }
 =

+static void p2p_go_negotiation_resp_done(int error, void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+
+	if (error)
+		l_error("Sending the GO Negotiation Response failed: %s (%i)",
+			strerror(-error), -error);
+	else
+		l_error("No GO Negotiation Confirmation frame received");
+
+	p2p_connect_failed(dev);
+}
+
+static void p2p_go_negotiation_resp_err_done(int error, void *user_data)
+{
+	if (error)
+		l_error("Sending the GO Negotiation Response failed: %s (%i)",
+			strerror(-error), -error);
+}
+
 /*
  * Called by GO Negotiation Response and Confirmation receive handlers,
  * in both cases the channel lists are required to be subsets of our
@@ -503,6 +544,236 @@ static void p2p_device_fill_channel_list(struct p2p_d=
evice *dev,
 	l_queue_push_tail(attr->channel_entries, channel_entry);
 }
 =

+static bool p2p_go_negotiation_confirm_cb(const struct mmpdu_header *mpdu,
+					const void *body, size_t body_len,
+					int rssi, struct p2p_device *dev)
+{
+	struct p2p_go_negotiation_confirmation info;
+	int r;
+	enum scan_band band;
+	uint32_t frequency;
+
+	l_debug("");
+
+	if (body_len < 8) {
+		l_error("GO Negotiation Confirmation frame too short");
+		p2p_connect_failed(dev);
+		return true;
+	}
+
+	r =3D p2p_parse_go_negotiation_confirmation(body + 7, body_len - 7,
+							&info);
+	if (r < 0) {
+		l_error("GO Negotiation Confirmation parse error %s (%i)",
+			strerror(-r), -r);
+		p2p_connect_failed(dev);
+		return true;
+	}
+
+	if (info.dialog_token !=3D dev->go_dialog_token) {
+		l_error("GO Negotiation Response dialog token doesn't match");
+		p2p_connect_failed(dev);
+		return true;
+	}
+
+	if (info.status !=3D P2P_STATUS_SUCCESS) {
+		l_error("GO Negotiation Confirmation status %i", info.status);
+		p2p_connect_failed(dev);
+		return true;
+	}
+
+	if (!p2p_device_validate_channel_list(dev, &info.channel_list,
+						&info.operating_channel))
+		return true;
+
+	band =3D scan_oper_class_to_band(
+			(const uint8_t *) info.operating_channel.country,
+			info.operating_channel.oper_class);
+	frequency =3D scan_channel_to_freq(info.operating_channel.channel_num,
+						band);
+	if (!frequency) {
+		l_error("Bad operating channel in GO Negotiation Confirmation");
+		p2p_connect_failed(dev);
+		return true;
+	}
+
+	dev->go_oper_freq =3D frequency;
+	memcpy(&dev->go_group_id, &info.group_id,
+		sizeof(struct p2p_group_id_attr));
+
+	/*
+	 * Confirmation received.  For simplicity wait idly the maximum amount
+	 * of time indicated by the peer in the GO Negotiation Response's
+	 * Configuration Timeout attribute and start the provisioning phase.
+	 */
+	dev->config_timeout =3D l_timeout_create_ms(dev->go_config_delay,
+						p2p_config_timeout, dev,
+						p2p_config_timeout_destroy);
+	return true;
+}
+
+static void p2p_device_go_negotiation_req_cb(const struct mmpdu_header *mp=
du,
+						const void *body,
+						size_t body_len, int rssi,
+						void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+	struct p2p_go_negotiation_req req_info;
+	struct p2p_go_negotiation_resp resp_info =3D {};
+	int r;
+	uint8_t *resp_body;
+	size_t resp_len;
+	struct iovec iov[16];
+	int iov_len =3D 0;
+	struct p2p_peer *peer;
+	enum p2p_attr_status_code status =3D P2P_STATUS_SUCCESS;
+	bool tie_breaker =3D false;
+
+	l_debug("");
+
+	/*
+	 * Check the Destination Address and the BSSID. Section 2.4.3:
+	 * "When communication is not within a P2P Group, e.g. during
+	 * [...] GO Negotiation [...], a P2P Device shall use the
+	 * P2P Device Address of the intended destination as the BSSID in
+	 * Request, or Confirmation frames and its own P2P Device Address
+	 * as the BSSID in Response frames."
+	 *
+	 * Some drivers (brcmfmac) will report the BSSID as all zeros and
+	 * some Wi-Fi Display dongles will pass their own address as the
+	 * BSSID in the GO Negotiation Request so allow all three possible
+	 * values.
+	 */
+	if (memcmp(mpdu->address_1, dev->addr, 6) ||
+			(memcmp(mpdu->address_3, dev->addr, 6) &&
+			 memcmp(mpdu->address_3, mpdu->address_2, 6) &&
+			 !util_mem_is_zero(mpdu->address_3, 6)))
+		return;
+
+	peer =3D l_queue_find(dev->peer_list, p2p_peer_match, mpdu->address_2);
+	if (!peer)
+		return;
+
+	if (body_len < 8)
+		return;
+
+	if (!dev->go_neg_req_timeout || peer !=3D dev->conn_peer) {
+		status =3D P2P_STATUS_FAIL_INFO_NOT_AVAIL;
+		goto respond;
+	}
+
+	if (memcmp(mpdu->address_2, dev->conn_peer->bss->addr, 6)) {
+		status =3D P2P_STATUS_FAIL_UNABLE_TO_ACCOMMODATE_REQUEST;
+		goto respond;
+	}
+
+	r =3D p2p_parse_go_negotiation_req(body + 7, body_len - 7, &req_info);
+	if (r < 0) {
+		l_error("GO Negotiation Request parse error %s (%i)",
+			strerror(-r), -r);
+		p2p_connect_failed(dev);
+		status =3D P2P_STATUS_FAIL_INVALID_PARAMS;
+		goto respond;
+	}
+
+	if (req_info.go_intent =3D=3D 0 && !req_info.go_tie_breaker) {
+		l_error("Can't negotiate client role and GO operation not "
+			"supported");
+
+		if (peer->wsc.pending_connect) {
+			struct l_dbus_message *reply =3D
+				dbus_error_not_supported(
+						peer->wsc.pending_connect);
+
+			dbus_pending_reply(&peer->wsc.pending_connect, reply);
+		}
+
+		p2p_connect_failed(dev);
+		status =3D P2P_STATUS_FAIL_INCOMPATIBLE_PARAMS;
+		goto p2p_free;
+	}
+
+	if (req_info.capability.group_caps & P2P_GROUP_CAP_PERSISTENT_GROUP) {
+		if (peer->wsc.pending_connect) {
+			struct l_dbus_message *reply =3D
+				dbus_error_not_supported(
+						peer->wsc.pending_connect);
+
+			dbus_pending_reply(&peer->wsc.pending_connect, reply);
+		}
+
+		p2p_connect_failed(dev);
+		l_error("Persistent groups not supported");
+		status =3D P2P_STATUS_FAIL_INCOMPATIBLE_PARAMS;
+		goto p2p_free;
+	}
+
+	if (req_info.device_password_id !=3D dev->conn_password_id) {
+		p2p_connect_failed(dev);
+		l_error("Incompatible Password ID in the GO Negotiation Req");
+		status =3D P2P_STATUS_FAIL_INCOMPATIBLE_PROVISIONING;
+		goto p2p_free;
+	}
+
+	l_timeout_remove(dev->go_neg_req_timeout);
+	p2p_device_discovery_stop(dev);
+
+	dev->go_dialog_token =3D req_info.dialog_token;
+	dev->go_config_delay =3D req_info.config_timeout.go_config_timeout * 10;
+	memcpy(dev->go_interface_addr, req_info.intended_interface_addr, 6);
+
+p2p_free:
+	tie_breaker =3D !req_info.go_tie_breaker;
+	p2p_clear_go_negotiation_req(&req_info);
+
+respond:
+	/* Build and send the GO Negotiation Response */
+	resp_info.dialog_token =3D dev->go_dialog_token;
+	resp_info.status =3D status;
+	resp_info.capability.device_caps =3D dev->capability.device_caps;
+	resp_info.capability.group_caps =3D 0;	/* Reserved */
+	resp_info.go_intent =3D 0;		/* Don't want to be the GO */
+	resp_info.go_tie_breaker =3D tie_breaker;
+	resp_info.config_timeout.go_config_timeout =3D 50;	/* 500ms */
+	resp_info.config_timeout.client_config_timeout =3D 50;	/* 500ms */
+
+	if (dev->conn_peer)
+		memcpy(resp_info.intended_interface_addr, dev->conn_addr, 6);
+
+	p2p_device_fill_channel_list(dev, &resp_info.channel_list);
+	resp_info.device_info =3D dev->device_info;
+	resp_info.device_password_id =3D dev->conn_password_id;
+
+	resp_body =3D p2p_build_go_negotiation_resp(&resp_info, &resp_len);
+	p2p_clear_go_negotiation_resp(&resp_info);
+
+	if (!resp_body) {
+		p2p_connect_failed(dev);
+		return;
+	}
+
+	iov[iov_len].iov_base =3D resp_body;
+	iov[iov_len].iov_len =3D resp_len;
+	iov_len++;
+
+	/* WFD and other service IEs go here */
+
+	iov[iov_len].iov_base =3D NULL;
+
+	if (status =3D=3D P2P_STATUS_SUCCESS)
+		p2p_peer_frame_xchg(peer, iov, dev->addr, 0, 600, 0, true,
+					FRAME_GROUP_CONNECT,
+					p2p_go_negotiation_resp_done,
+					&p2p_frame_go_neg_confirm,
+					p2p_go_negotiation_confirm_cb, NULL);
+	else
+		p2p_peer_frame_xchg(peer, iov, dev->addr, 0, 0, 0, true,
+					FRAME_GROUP_CONNECT,
+					p2p_go_negotiation_resp_err_done, NULL);
+
+	l_debug("GO Negotiation Response sent with status %i", status);
+}
+
 static void p2p_go_negotiation_confirm_done(int error, void *user_data)
 {
 	struct p2p_device *dev =3D user_data;
@@ -525,6 +796,25 @@ static void p2p_go_negotiation_confirm_done(int error,=
 void *user_data)
 						p2p_config_timeout_destroy);
 }
 =

+static void p2p_go_neg_req_timeout_destroy(void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+
+	dev->go_neg_req_timeout =3D NULL;
+}
+
+static void p2p_go_neg_req_timeout(struct l_timeout *timeout, void *user_d=
ata)
+{
+	struct p2p_device *dev =3D user_data;
+
+	l_debug("");
+
+	p2p_connect_failed(dev);
+
+	if (l_queue_isempty(dev->discovery_users))
+		p2p_device_discovery_stop(dev);
+}
+
 static bool p2p_go_negotiation_resp_cb(const struct mmpdu_header *mpdu,
 					const void *body, size_t body_len,
 					int rssi, struct p2p_device *dev)
@@ -565,6 +855,18 @@ static bool p2p_go_negotiation_resp_cb(const struct mm=
pdu_header *mpdu,
 	}
 =

 	if (resp_info.status !=3D P2P_STATUS_SUCCESS) {
+		if (resp_info.status =3D=3D P2P_STATUS_FAIL_INFO_NOT_AVAIL) {
+			/* Give the peer 120s to restart the GO Negotiation */
+			l_error("P2P_STATUS_FAIL_INFO_NOT_AVAIL: Will wait for "
+				"a new GO Negotiation Request before declaring "
+				"failure");
+			dev->go_neg_req_timeout =3D l_timeout_create(120,
+						p2p_go_neg_req_timeout, dev,
+						p2p_go_neg_req_timeout_destroy);
+			p2p_device_discovery_start(dev);
+			return true;
+		}
+
 		l_error("GO Negotiation Response status %i", resp_info.status);
 		p2p_connect_failed(dev);
 		return true;
@@ -1003,6 +1305,60 @@ static void p2p_device_roc_start(struct p2p_device *=
dev)
 	if (duration > 1000)
 		duration =3D 1000;
 =

+	/*
+	 * Be on our listen channel, even if we're still in the 120s
+	 * waiting period after a locally-initiated GO Negotiation and
+	 * waiting for the peer's GO Negotiation Request.  It's not
+	 * totally clear that this is how the spec intended this
+	 * mechanism to work.  On one hand 3.1.4.1 says this:
+	 * "A P2P Device may start Group Owner Negotiation by sending a
+	 * GO Negotiation Request frame after receiving a Probe Request
+	 * frame from the target P2P Device."
+	 * and the Appendix D. scenarios also show GO Negotiation happening
+	 * on the initiator's listen channel directly after the reception
+	 * of the Probe Request from the target.  But:
+	 *  1. in 3.1.4.1 that is a MAY and doesn't exclude starting GO
+	 *     Negotiation also on the target's listen channel.
+	 *  2. not all devices use the search state so we may never
+	 *     receive a Probe Request and may end up waiting indefinitely.
+	 *  3. the time the peer spends on each channel in the scan state
+	 *     may be too short for the peer to receive the GO Negotiation
+	 *     Request after the Probe Request before moving to the next
+	 *     channel.
+	 *  4. since we know the target is going to spend some time on
+	 *     their own listen channel, using that channel should work in
+	 *     every case.
+	 *
+	 * We also have this in 3.1.4.1:
+	 * "When the P2P Devices arrive on a common channel and begin Group
+	 * Owner Negotiation, they shall stay on that channel until Group
+	 * Owner Negotiation completes."
+	 * telling us that the whole negotiation should be happening on
+	 * one channel seemingly supporting the new GO Negotiation being on
+	 * the same channel as the original failed GO Negotiation.
+	 * However the rest of the spec makes it clear they are not treated
+	 * as a single GO Negotiation:
+	 * 3.1.4.2:
+	 * "Group Owner Negotiation is a three way frame exchange"
+	 * 3.1.4.2.2:
+	 * "Group Formation ends on transmission or reception of a GO
+	 * Negotiation Response frame with the Status Code set to a value
+	 * other than Success."
+	 *
+	 * 3.1.4.1 implies frame exchanges happen on the target device's
+	 * Listen Channel, not our Listen Channel:
+	 * "Prior to beginning the Group Formation Procedure the P2P Device
+	 * shall arrive on a common channel with the target P2P Device.
+	 * The Find Phase in In-band Device Discovery or Out-of-Band Device
+	 * Discovery may be used for this purpose. In the former case, the
+	 * P2P Device only needs to scan the Listen Channel of the target
+	 * P2P Device, as opposed to all of the Social Channels."
+	 *
+	 * All in all we transmit our Negotiation Requests on the peer's
+	 * listen channel since it is bound to spend more time on that
+	 * channel than on any other channel and then we listen for a
+	 * potential GO Negotiation restart on our listen channel.
+	 */
 	listen_freq =3D scan_channel_to_freq(dev->listen_channel,
 						SCAN_BAND_2_4_GHZ);
 =

@@ -1435,14 +1791,21 @@ static void p2p_device_discovery_start(struct p2p_d=
evice *dev)
 	 * 3.1.2.1.1: "The Listen Channel shall be chosen at the beginning of
 	 * the In-band Device Discovery"
 	 *
-	 * (Unless we're waiting for a GO Negotiation Request from a peer on
-	 * a known channel)
+	 * But keep the old channel if we're still waiting for the peer to
+	 * restart the GO Negotiation because there may not be enough time
+	 * for the peer to update our Listen Channel value before the user
+	 * accepts the connection.  In that case the GO Negotiation Request
+	 * would be sent on the old channel.
 	 */
-	dev->listen_channel =3D channels_social[l_getrandom_uint32() %
-					L_ARRAY_SIZE(channels_social)];
+	if (!(dev->listen_channel && dev->conn_peer))
+		dev->listen_channel =3D channels_social[l_getrandom_uint32() %
+						L_ARRAY_SIZE(channels_social)];
 =

 	frame_watch_add(dev->wdev_id, FRAME_GROUP_LISTEN, 0x0040,
 			(uint8_t *) "", 0, p2p_device_probe_cb, dev, NULL);
+	frame_watch_add(dev->wdev_id, FRAME_GROUP_LISTEN, 0x00d0,
+			p2p_frame_go_neg_req.data, p2p_frame_go_neg_req.len,
+			p2p_device_go_negotiation_req_cb, dev, NULL);
 =

 	p2p_device_scan_start(dev);
 }
@@ -1989,7 +2352,13 @@ static struct l_dbus_message *p2p_device_release_dis=
covery(struct l_dbus *dbus,
 =

 	p2p_discovery_user_free(user);
 =

-	if (l_queue_isempty(dev->discovery_users))
+	/*
+	 * If dev->conn_peer is non-NULL, we may be scanning as a way to
+	 * listen for a GO Negotiation Request from the target peer.  In
+	 * that case we don't stop the device discovery when the list
+	 * becomes empty.
+	 */
+	if (l_queue_isempty(dev->discovery_users) && !dev->conn_peer)
 		p2p_device_discovery_stop(dev);
 =

 	return l_dbus_message_new_method_return(message);
-- =

2.25.1

--===============6235075287391542428==--

