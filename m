Content-Type: multipart/mixed; boundary="===============6943632121713792546=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/7] ft: refactor FT-over-DS into two stages
Date: Tue, 27 Apr 2021 12:49:43 -0700
Message-ID: <20210427194945.49731-5-prestwoj@gmail.com>
In-Reply-To: <20210427194945.49731-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6943632121713792546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

FT-over-DS followed the same pattern as FT-over-Air which worked,
but really limited how the protocol could be used. FT-over-DS is
unique in that we can authenticate to many APs by sending out
FT action frames and parsing the results. Once parsed IWD can
immediately Reassociate, or do so at a later time.

To take advantage of this IWD need to separate FT-over-DS into
two stages: action frame and reassociation.

The initial action frame stage is started by netdev. The target
BSS is sent an FT action frame and a new cache entry is created
in ft.c. Once the response is received the entry is updated
with all the needed data to Reassociate. To limit the record
keeping on netdev each FT-over-DS entry holds a userdata pointer
so netdev doesn't need to maintain its own list of data for
callbacks.

Once the action response is parsed netdev will call back signalling
the action frame sequence was completed (either successfully or not).
At this point the 'normal' FT procedure can start using the
FT-over-DS auth-proto.
---
 src/ft.c      |  95 ++++--------------
 src/ft.h      |   1 -
 src/netdev.c  | 262 ++++++++++++++++++++++++++++++++++++--------------
 src/netdev.h  |  11 ++-
 src/station.c |   3 +-
 5 files changed, 224 insertions(+), 148 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index d9387e9b..9a204dae 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -177,40 +177,6 @@ static bool ft_parse_authentication_resp_frame(const u=
int8_t *data, size_t len,
 	return true;
 }
 =

-static bool ft_parse_action_resp_frame(const uint8_t *frame, size_t frame_=
len,
-					const uint8_t *spa, const uint8_t *aa,
-					uint16_t *out_status,
-					const uint8_t **out_ies,
-					size_t *out_ies_len)
-{
-	uint16_t status =3D 0;
-
-	/* Category FT */
-	if (frame[0] !=3D 6)
-		return false;
-
-	/* FT Action */
-	if (frame[1] !=3D 2)
-		return false;
-
-	if (memcmp(frame + 2, spa, 6))
-		return false;
-	if (memcmp(frame + 8, aa, 6))
-		return false;
-
-	status =3D l_get_le16(frame + 14);
-
-	if (out_status)
-		*out_status =3D status;
-
-	if (status =3D=3D 0 && out_ies) {
-		*out_ies =3D frame + 16;
-		*out_ies_len =3D frame_len - 16;
-	}
-
-	return true;
-}
-
 static bool ft_parse_associate_resp_frame(const uint8_t *frame, size_t fra=
me_len,
 				uint16_t *out_status, const uint8_t **rsne,
 				const uint8_t **mde, const uint8_t **fte)
@@ -802,34 +768,6 @@ bool ft_over_ds_prepare_handshake(struct handshake_sta=
te *hs,
 	return true;
 }
 =

-static int ft_rx_action(struct auth_proto *ap, const uint8_t *frame,
-				size_t frame_len)
-{
-	struct ft_sm *ft =3D l_container_of(ap, struct ft_sm, ap);
-	uint16_t status_code =3D MMPDU_STATUS_CODE_UNSPECIFIED;
-	const uint8_t *ies =3D NULL;
-	size_t ies_len;
-	int ret;
-
-	if (!ft_parse_action_resp_frame(frame, frame_len, ft->hs->spa,
-						ft->hs->aa, &status_code,
-						&ies, &ies_len))
-		return -EBADMSG;
-
-	/* AP Rejected the authenticate / associate */
-	if (status_code !=3D 0)
-		goto auth_error;
-
-	ret =3D ft_process_ies(ft->hs, ies, ies_len);
-	if (ret < 0)
-		goto auth_error;
-
-	return ft_tx_reassociate(ft);
-
-auth_error:
-	return (int)status_code;
-}
-
 static int ft_rx_authenticate(struct auth_proto *ap, const uint8_t *frame,
 				size_t frame_len)
 {
@@ -1006,6 +944,13 @@ static void ft_sm_free(struct auth_proto *ap)
 	l_free(ft);
 }
 =

+static bool ft_over_ds_start(struct auth_proto *ap)
+{
+	struct ft_sm *ft =3D l_container_of(ap, struct ft_sm, ap);
+
+	return ft_tx_reassociate(ft) =3D=3D 0;
+}
+
 bool ft_build_authenticate_ies(struct handshake_state *hs,
 				const uint8_t *new_snonce, uint8_t *buf,
 				size_t *len)
@@ -1096,10 +1041,9 @@ static bool ft_start(struct auth_proto *ap)
 	return true;
 }
 =

-static struct auth_proto *ft_sm_new(struct handshake_state *hs,
+struct auth_proto *ft_over_air_sm_new(struct handshake_state *hs,
 				ft_tx_authenticate_func_t tx_auth,
 				ft_tx_associate_func_t tx_assoc,
-				bool over_air,
 				void *user_data)
 {
 	struct ft_sm *ft =3D l_new(struct ft_sm, 1);
@@ -1109,7 +1053,7 @@ static struct auth_proto *ft_sm_new(struct handshake_=
state *hs,
 	ft->hs =3D hs;
 	ft->user_data =3D user_data;
 =

-	ft->ap.rx_authenticate =3D (over_air) ? ft_rx_authenticate : ft_rx_action;
+	ft->ap.rx_authenticate =3D ft_rx_authenticate;
 	ft->ap.rx_associate =3D ft_rx_associate;
 	ft->ap.start =3D ft_start;
 	ft->ap.free =3D ft_sm_free;
@@ -1117,20 +1061,21 @@ static struct auth_proto *ft_sm_new(struct handshak=
e_state *hs,
 	return &ft->ap;
 }
 =

-struct auth_proto *ft_over_air_sm_new(struct handshake_state *hs,
-				ft_tx_authenticate_func_t tx_auth,
-				ft_tx_associate_func_t tx_assoc,
-				void *user_data)
-{
-	return ft_sm_new(hs, tx_auth, tx_assoc, true, user_data);
-}
-
 struct auth_proto *ft_over_ds_sm_new(struct handshake_state *hs,
-				ft_tx_authenticate_func_t tx_auth,
 				ft_tx_associate_func_t tx_assoc,
 				void *user_data)
 {
-	return ft_sm_new(hs, tx_auth, tx_assoc, false, user_data);
+	struct ft_sm *ft =3D l_new(struct ft_sm, 1);
+
+	ft->tx_assoc =3D tx_assoc;
+	ft->hs =3D hs;
+	ft->user_data =3D user_data;
+
+	ft->ap.rx_associate =3D ft_rx_associate;
+	ft->ap.start =3D ft_over_ds_start;
+	ft->ap.free =3D ft_sm_free;
+
+	return &ft->ap;
 }
 =

 static int ft_init(void)
diff --git a/src/ft.h b/src/ft.h
index 27d91dd4..be52abaa 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -45,7 +45,6 @@ struct auth_proto *ft_over_air_sm_new(struct handshake_st=
ate *hs,
 				void *user_data);
 =

 struct auth_proto *ft_over_ds_sm_new(struct handshake_state *hs,
-				ft_tx_authenticate_func_t tx_auth,
 				ft_tx_associate_func_t tx_assoc,
 				void *user_data);
 =

diff --git a/src/netdev.c b/src/netdev.c
index 2dae07df..d0f9cae8 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -187,6 +187,14 @@ struct netdev_watch {
 	void *user_data;
 };
 =

+struct netdev_ft_over_ds_info {
+	struct netdev *netdev;
+	uint8_t addr[ETH_ALEN];
+	struct l_timeout *timeout;
+	netdev_ft_over_ds_cb_t cb;
+	void *user_data;
+};
+
 static struct l_netlink *rtnl =3D NULL;
 static struct l_genl_family *nl80211;
 static struct l_queue *netdev_list;
@@ -742,6 +750,8 @@ static void netdev_connect_free(struct netdev *netdev)
 		l_genl_family_cancel(nl80211, netdev->disconnect_cmd_id);
 		netdev->disconnect_cmd_id =3D 0;
 	}
+
+	ft_over_ds_entry_remove_all(netdev->addr);
 }
 =

 static void netdev_connect_failed(struct netdev *netdev,
@@ -1259,6 +1269,12 @@ static void netdev_connect_ok(struct netdev *netdev)
 =

 	netdev->operational =3D true;
 =

+	/*
+	 * Remove all entries in case station sends out a batch of FT-over-DS
+	 * action frames after connecting.
+	 */
+	ft_over_ds_entry_remove_all(netdev->addr);
+
 	if (netdev->fw_roam_bss) {
 		if (netdev->event_filter)
 			netdev->event_filter(netdev, NETDEV_EVENT_ROAMED,
@@ -3630,10 +3646,25 @@ static void prepare_ft(struct netdev *netdev, struc=
t scan_bss *target_bss)
 {
 	struct netdev_handshake_state *nhs;
 =

+	/*
+	 * We reuse the handshake_state object and reset what's needed.
+	 * Could also create a new object and copy most of the state but
+	 * we would end up doing more work.
+	 */
+	memcpy(netdev->prev_snonce, netdev->handshake->snonce, 32);
+
 	memcpy(netdev->prev_bssid, netdev->handshake->aa, 6);
 	netdev->prev_frequency =3D netdev->frequency;
 	netdev->frequency =3D target_bss->frequency;
 =

+	handshake_state_set_authenticator_address(netdev->handshake,
+							target_bss->addr);
+
+	if (target_bss->rsne)
+		handshake_state_set_authenticator_ie(netdev->handshake,
+							target_bss->rsne);
+	memcpy(netdev->handshake->mde + 2, target_bss->mde, 3);
+
 	netdev->associated =3D false;
 	netdev->operational =3D false;
 	netdev->in_ft =3D true;
@@ -3676,44 +3707,59 @@ static void prepare_ft(struct netdev *netdev, struc=
t scan_bss *target_bss)
 	}
 }
 =

-static void netdev_ft_request_cb(struct l_genl_msg *msg, void *user_data)
+static void netdev_ft_over_ds_auth_failed(struct netdev_ft_over_ds_info *i=
nfo,
+						uint16_t status)
 {
-	struct netdev *netdev =3D user_data;
-	int err =3D l_genl_msg_get_error(msg);
-
-	if (err < 0) {
-		l_error("Could not send CMD_FRAME (%d)", err);
-		netdev_connect_failed(netdev,
-					NETDEV_RESULT_AUTHENTICATION_FAILED,
-					MMPDU_STATUS_CODE_UNSPECIFIED);
+	if (info->timeout) {
+		l_timeout_remove(info->timeout);
+		info->timeout =3D NULL;
 	}
+
+	if (info->cb)
+		info->cb(info->netdev, status, info->addr, info->user_data);
+
+	ft_over_ds_entry_remove(info->netdev->addr, info->addr);
 }
 =

 static void netdev_ft_response_frame_event(const struct mmpdu_header *hdr,
 					const void *body, size_t body_len,
 					int rssi, void *user_data)
 {
+	struct netdev *netdev =3D user_data;
+	struct netdev_ft_over_ds_info *info =3D NULL;
 	int ret;
 	uint16_t status_code =3D MMPDU_STATUS_CODE_UNSPECIFIED;
-	struct netdev *netdev =3D user_data;
+	const uint8_t *aa;
+
+	ret =3D ft_over_ds_parse_action_response(netdev->addr, body,
+						body_len, &aa);
+	if (ret < 0)
+		return;
 =

-	if (!netdev->ap || !netdev->in_ft)
+	info =3D ft_over_ds_entry_get_userdata(netdev->addr, aa);
+	if (!info)
 		return;
 =

-	ret =3D auth_proto_rx_authenticate(netdev->ap, body, body_len);
-	if (ret < 0)
-		goto ft_error;
-	else if (ret > 0) {
+	if (info->timeout) {
+		l_timeout_remove(info->timeout);
+		info->timeout =3D NULL;
+	}
+
+	/* Now make sure the packet contained a success status code */
+	if (ret > 0) {
 		status_code =3D (uint16_t)ret;
 		goto ft_error;
 	}
 =

+	if (info->cb)
+		info->cb(netdev, 0, info->addr, info->user_data);
+
 	return;
 =

 ft_error:
-	netdev_connect_failed(netdev, NETDEV_RESULT_AUTHENTICATION_FAILED,
-				status_code);
-	return;
+	l_debug("FT-over-DS to "MAC" failed", MAC_STR(info->addr));
+
+	netdev_ft_over_ds_auth_failed(info, status_code);
 }
 =

 static void netdev_qos_map_frame_event(const struct mmpdu_header *hdr,
@@ -3738,29 +3784,6 @@ static void netdev_qos_map_frame_event(const struct =
mmpdu_header *hdr,
 	netdev_send_qos_map_set(netdev, body + 4, body_len - 4);
 }
 =

-static void netdev_ft_over_ds_tx_authenticate(struct iovec *iov,
-					size_t iov_len, void *user_data)
-{
-	struct netdev *netdev =3D user_data;
-	uint8_t ft_req[14];
-	struct handshake_state *hs =3D netdev->handshake;
-	struct iovec iovs[iov_len + 1];
-
-	ft_req[0] =3D 6; /* FT category */
-	ft_req[1] =3D 1; /* FT Request action */
-	memcpy(ft_req + 2, netdev->addr, 6);
-	memcpy(ft_req + 8, hs->aa, 6);
-
-	iovs[0].iov_base =3D ft_req;
-	iovs[0].iov_len =3D sizeof(ft_req);
-	memcpy(iovs + 1, iov, sizeof(*iov) * iov_len);
-
-	netdev_send_action_framev(netdev, netdev->prev_bssid, iovs, iov_len + 1,
-					netdev->prev_frequency,
-					netdev_ft_request_cb,
-					netdev);
-}
-
 static bool netdev_ft_work_ready(struct wiphy_radio_work_item *item)
 {
 	struct netdev *netdev =3D l_container_of(item, struct netdev, work);
@@ -3781,8 +3804,7 @@ static const struct wiphy_radio_work_item_ops ft_work=
_ops =3D {
 	.do_work =3D netdev_ft_work_ready,
 };
 =

-static int fast_transition(struct netdev *netdev, struct scan_bss *target_=
bss,
-				bool over_air,
+int netdev_fast_transition(struct netdev *netdev, struct scan_bss *target_=
bss,
 				netdev_connect_cb_t cb)
 {
 	if (!netdev->operational)
@@ -3795,32 +3817,13 @@ static int fast_transition(struct netdev *netdev, s=
truct scan_bss *target_bss,
 =

 	prepare_ft(netdev, target_bss);
 =

-	/*
-	 * We reuse the handshake_state object and reset what's needed.
-	 * Could also create a new object and copy most of the state but
-	 * we would end up doing more work.
-	 */
-	memcpy(netdev->prev_snonce, netdev->handshake->snonce, 32);
 	handshake_state_new_snonce(netdev->handshake);
 =

-	handshake_state_set_authenticator_address(netdev->handshake,
-							target_bss->addr);
-
-	if (target_bss->rsne)
-		handshake_state_set_authenticator_ie(netdev->handshake,
-							target_bss->rsne);
-	memcpy(netdev->handshake->mde + 2, target_bss->mde, 3);
-
 	netdev->connect_cb =3D cb;
 =

-	if (over_air)
-		netdev->ap =3D ft_over_air_sm_new(netdev->handshake,
+	netdev->ap =3D ft_over_air_sm_new(netdev->handshake,
 					netdev_ft_tx_authenticate,
 					netdev_ft_tx_associate, netdev);
-	else
-		netdev->ap =3D ft_over_ds_sm_new(netdev->handshake,
-					netdev_ft_over_ds_tx_authenticate,
-					netdev_ft_tx_associate, netdev);
 =

 	wiphy_radio_work_insert(netdev->wiphy, &netdev->work, 1,
 				&ft_work_ops);
@@ -3828,17 +3831,136 @@ static int fast_transition(struct netdev *netdev, =
struct scan_bss *target_bss,
 	return 0;
 }
 =

-int netdev_fast_transition(struct netdev *netdev, struct scan_bss *target_=
bss,
-				netdev_connect_cb_t cb)
+int netdev_fast_transition_over_ds(struct netdev *netdev,
+					struct scan_bss *target_bss,
+					netdev_connect_cb_t cb,
+					void *user_data)
+{
+	struct netdev_ft_over_ds_info *info;
+
+	if (!netdev->operational)
+		return -ENOTCONN;
+
+	if (!netdev->handshake->mde || !target_bss->mde_present ||
+			l_get_le16(netdev->handshake->mde + 2) !=3D
+			l_get_le16(target_bss->mde))
+		return -EINVAL;
+
+	info =3D ft_over_ds_entry_get_userdata(netdev->addr, target_bss->addr);
+	if (!info)
+		return -ENOENT;
+
+	prepare_ft(netdev, target_bss);
+
+	if (!ft_over_ds_prepare_handshake(netdev->handshake, target_bss))
+		return -ENOENT;
+
+	netdev->connect_cb =3D cb;
+	netdev->user_data =3D user_data;
+
+	netdev->ap =3D ft_over_ds_sm_new(netdev->handshake,
+					netdev_ft_tx_associate,
+					netdev);
+
+	wiphy_radio_work_insert(netdev->wiphy, &netdev->work, 1,
+				&ft_work_ops);
+
+	return 0;
+}
+
+static void netdev_ft_request_cb(struct l_genl_msg *msg, void *user_data)
 {
-	return fast_transition(netdev, target_bss, true, cb);
+	struct netdev_ft_over_ds_info *info =3D user_data;
+
+	if (l_genl_msg_get_error(msg) < 0) {
+		l_error("Could not send CMD_FRAME for FT-over-DS");
+		netdev_ft_over_ds_auth_failed(info,
+					MMPDU_STATUS_CODE_UNSPECIFIED);
+	}
 }
 =

-int netdev_fast_transition_over_ds(struct netdev *netdev,
-					struct scan_bss *target_bss,
-					netdev_connect_cb_t cb)
+static void netdev_ft_over_ds_timeout(struct l_timeout *timeout,
+					void *user_data)
+{
+	struct netdev_ft_over_ds_info *info =3D user_data;
+
+	netdev_ft_over_ds_auth_failed(info, MMPDU_STATUS_CODE_UNSPECIFIED);
+}
+
+static void netdev_ft_over_ds_info_destroy(void *user_data)
 {
-	return fast_transition(netdev, target_bss, false, cb);
+	struct netdev_ft_over_ds_info *info =3D user_data;
+
+	if (info->timeout)
+		l_timeout_remove(info->timeout);
+
+	l_free(info);
+}
+
+int netdev_fast_transition_over_ds_action(struct netdev *netdev,
+						struct scan_bss *target_bss,
+						netdev_ft_over_ds_cb_t cb,
+						void *user_data)
+{
+	struct netdev_ft_over_ds_info *info;
+	uint8_t ft_req[14];
+	struct handshake_state *hs =3D netdev->handshake;
+	struct iovec iovs[5];
+	uint8_t buf[512];
+	size_t len;
+	uint8_t snonce[32];
+
+	if (!netdev->operational)
+		return -ENOTCONN;
+
+	if (!netdev->handshake->mde || !target_bss->mde_present ||
+			l_get_le16(netdev->handshake->mde + 2) !=3D
+			l_get_le16(target_bss->mde))
+		return -EINVAL;
+
+	l_debug("");
+
+	l_getrandom(snonce, 32);
+
+	info =3D l_new(struct netdev_ft_over_ds_info, 1);
+	info->netdev =3D netdev;
+	memcpy(info->addr, target_bss->addr, ETH_ALEN);
+	info->cb =3D cb;
+	info->user_data =3D user_data;
+
+	if (!ft_over_ds_entry_create(netdev->index, hs, target_bss, snonce,
+					info, netdev_ft_over_ds_info_destroy)) {
+		l_free(info);
+		return -EALREADY;
+	}
+
+	ft_req[0] =3D 6; /* FT category */
+	ft_req[1] =3D 1; /* FT Request action */
+	memcpy(ft_req + 2, netdev->addr, 6);
+	memcpy(ft_req + 8, info->addr, 6);
+
+	iovs[0].iov_base =3D ft_req;
+	iovs[0].iov_len =3D sizeof(ft_req);
+
+	if (!ft_build_authenticate_ies(hs, snonce, buf, &len))
+		goto failed;
+
+	iovs[1].iov_base =3D buf;
+	iovs[1].iov_len =3D len;
+
+	info->timeout =3D l_timeout_create_ms(300, netdev_ft_over_ds_timeout,
+						info, NULL);
+
+	netdev_send_action_framev(netdev, netdev->handshake->aa, iovs, 2,
+					netdev->frequency,
+					netdev_ft_request_cb,
+					info);
+
+	return 0;
+
+failed:
+	l_free(info);
+	return -EIO;
 }
 =

 static void netdev_preauth_cb(const uint8_t *pmk, void *user_data)
diff --git a/src/netdev.h b/src/netdev.h
index 7b321bfb..bebde242 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -124,6 +124,10 @@ typedef void (*netdev_get_station_cb_t)(
 =

 const char *netdev_iftype_to_string(uint32_t iftype);
 =

+typedef void (*netdev_ft_over_ds_cb_t)(struct netdev *netdev,
+					uint16_t status, const uint8_t *bssid,
+					void *user_data);
+
 struct wiphy *netdev_get_wiphy(struct netdev *netdev);
 const uint8_t *netdev_get_address(struct netdev *netdev);
 uint32_t netdev_get_ifindex(struct netdev *netdev);
@@ -157,9 +161,14 @@ int netdev_reassociate(struct netdev *netdev, struct s=
can_bss *target_bss,
 			netdev_connect_cb_t cb, void *user_data);
 int netdev_fast_transition(struct netdev *netdev, struct scan_bss *target_=
bss,
 				netdev_connect_cb_t cb);
+int netdev_fast_transition_over_ds_action(struct netdev *netdev,
+					struct scan_bss *target_bss,
+					netdev_ft_over_ds_cb_t cb,
+					void *user_data);
 int netdev_fast_transition_over_ds(struct netdev *netdev,
 					struct scan_bss *target_bss,
-					netdev_connect_cb_t cb);
+					netdev_connect_cb_t cb,
+					void *user_data);
 int netdev_preauthenticate(struct netdev *netdev, struct scan_bss *target_=
bss,
 				netdev_preauthenticate_cb_t cb,
 				void *user_data);
diff --git a/src/station.c b/src/station.c
index 064872c6..9254ec90 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1840,7 +1840,8 @@ static void station_transition_start(struct station *=
station,
 		if ((hs->mde[4] & 1) && (station->ap_directed_roaming ||
 				station->signal_low)) {
 			if (netdev_fast_transition_over_ds(station->netdev, bss,
-					station_fast_transition_cb) < 0) {
+					station_fast_transition_cb,
+					station) < 0) {
 				station_roam_failed(station);
 				return;
 			}
-- =

2.26.2

--===============6943632121713792546==--

