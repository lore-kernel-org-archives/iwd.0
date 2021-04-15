Content-Type: multipart/mixed; boundary="===============4855714082673111584=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/8] ft: netdev: refactor FT-over-DS to properly handle Auth
 failures
Date: Thu, 15 Apr 2021 15:45:06 -0700
Message-ID: <20210415224508.1823614-6-prestwoj@gmail.com>
In-Reply-To: <20210415224508.1823614-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4855714082673111584==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

FT-over-DS should be handled differently than FT-over-Air, at least in
terms of the initial action frame over-DS sends. This action frame can
actually be sent to multiple APs, even before IWD needs to roam. An
error condition while sending the frame or getting a response should
not be treated as fatal which it is currently.

To fix this FT-over-DS needed to be refactored and the initial action
frame was moved outside of the auth-proto mechanism and into netdev
itself. Since this is not a formal Authentication frame it did not fit
right with how auth-protos worked. In addition there was no feasible
way to separate failure in this path while still keeping the existing
connection alive (apart from storing loads of handshake data and
restoring it on failure).

To maintain the current connection while still starting the over-DS
process a new handshake object needs to be created
(ft_over_ds_handshake_new). This new handshake is held in netdev and
if there is any failure prior to Reassociation it can simply be freed
and thrown out. If FT-over-DS successfully authenticates then
the existing netdev handshake can be swapped for the new one, and
Reassociation can begin. For this an auth-proto is created for
FT-over-DS (ft_over_ds_sm_new). Once Reassociation starts the code path
behaves identically to FT-over-Air.

Some minor changes were also included like using frame-xchg rather
than sending the frame from netdev. This gets us free timeout handling
which reduced the complexity in netdev.

With this change, future improvements can be made much easier such
as starting FT-over-DS to multiple roam candidates immediate after
connecting. Then, once a roam is needed, IWD has already pre-authenticated
with these APs and can begin association immediately.
---
 src/ft.c     |  95 ++++++-------------------
 src/ft.h     |   1 -
 src/netdev.c | 191 ++++++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 170 insertions(+), 117 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index 7826653f..d1aaada7 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -159,40 +159,6 @@ static bool ft_parse_authentication_resp_frame(const u=
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
@@ -512,34 +478,6 @@ parse_error:
 	return -EBADMSG;
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
@@ -716,6 +654,13 @@ static void ft_sm_free(struct auth_proto *ap)
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
@@ -845,10 +790,9 @@ struct handshake_state *ft_over_ds_handshake_new(struc=
t netdev *netdev,
 	return hs;
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
@@ -858,7 +802,7 @@ static struct auth_proto *ft_sm_new(struct handshake_st=
ate *hs,
 	ft->hs =3D hs;
 	ft->user_data =3D user_data;
 =

-	ft->ap.rx_authenticate =3D (over_air) ? ft_rx_authenticate : ft_rx_action;
+	ft->ap.rx_authenticate =3D ft_rx_authenticate;
 	ft->ap.rx_associate =3D ft_rx_associate;
 	ft->ap.start =3D ft_start;
 	ft->ap.free =3D ft_sm_free;
@@ -866,18 +810,19 @@ static struct auth_proto *ft_sm_new(struct handshake_=
state *hs,
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
diff --git a/src/ft.h b/src/ft.h
index a22196b6..2dd806f2 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -46,6 +46,5 @@ struct auth_proto *ft_over_air_sm_new(struct handshake_st=
ate *hs,
 				void *user_data);
 =

 struct auth_proto *ft_over_ds_sm_new(struct handshake_state *hs,
-				ft_tx_authenticate_func_t tx_auth,
 				ft_tx_associate_func_t tx_assoc,
 				void *user_data);
diff --git a/src/netdev.c b/src/netdev.c
index 4c28fb25..95fa6909 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -119,6 +119,7 @@ struct netdev {
 	uint32_t rekey_offload_cmd_id;
 	uint32_t qos_map_cmd_id;
 	uint32_t mac_change_cmd_id;
+	uint32_t ft_action_cmd_id;
 	enum netdev_result result;
 	uint16_t last_code; /* reason or status, depending on result */
 	struct l_timeout *neighbor_report_timeout;
@@ -136,6 +137,14 @@ struct netdev {
 	uint32_t rssi_poll_cmd_id;
 	uint8_t set_mac_once[6];
 =

+	/*
+	 * TODO: It is possible to pre-authenticate with multiple FT-over-DS
+	 * targets so this could be changed to an array of BSS/handshake pairs,
+	 * but for now it is being limited to a single FT target
+	 */
+	struct scan_bss *ft_over_ds_target;
+	struct handshake_state *ft_over_ds_handshake;
+
 	struct scan_bss *fw_roam_bss;
 =

 	uint32_t set_powered_cmd_id;
@@ -675,6 +684,11 @@ static void netdev_connect_free(struct netdev *netdev)
 		netdev->handshake =3D NULL;
 	}
 =

+	if (netdev->ft_over_ds_handshake) {
+		handshake_state_free(netdev->ft_over_ds_handshake);
+		netdev->ft_over_ds_handshake =3D NULL;
+	}
+
 	if (netdev->neighbor_report_cb) {
 		netdev->neighbor_report_cb(netdev, -ENOTCONN, NULL, 0,
 						netdev->user_data);
@@ -810,6 +824,11 @@ static void netdev_free(void *data)
 		netdev->get_station_cmd_id =3D 0;
 	}
 =

+	if (netdev->ft_action_cmd_id) {
+		frame_xchg_cancel(netdev->ft_action_cmd_id);
+		netdev->ft_action_cmd_id =3D 0;
+	}
+
 	if (netdev->fw_roam_bss)
 		scan_bss_free(netdev->fw_roam_bss);
 =

@@ -3579,16 +3598,19 @@ static void prepare_ft(struct netdev *netdev, struc=
t scan_bss *target_bss)
 	}
 }
 =

-static void netdev_ft_request_cb(struct l_genl_msg *msg, void *user_data)
+static void netdev_ft_over_ds_auth_failed(struct netdev *netdev,
+						uint16_t status)
 {
-	struct netdev *netdev =3D user_data;
-
-	if (l_genl_msg_get_error(msg) < 0) {
-		l_error("Could not send CMD_FRAME");
-		netdev_connect_failed(netdev,
-					NETDEV_RESULT_AUTHENTICATION_FAILED,
-					MMPDU_STATUS_CODE_UNSPECIFIED);
+	if (netdev->ft_over_ds_handshake) {
+		netdev_handshake_state_free(netdev->ft_over_ds_handshake);
+		netdev->ft_over_ds_handshake =3D NULL;
 	}
+
+	netdev->ft_over_ds_target =3D NULL;
+
+	if (netdev->connect_cb)
+		netdev->connect_cb(netdev, NETDEV_RESULT_AUTHENTICATION_FAILED,
+					&status, netdev->user_data);
 }
 =

 static void netdev_ft_response_frame_event(const struct mmpdu_header *hdr,
@@ -3598,11 +3620,11 @@ static void netdev_ft_response_frame_event(const st=
ruct mmpdu_header *hdr,
 	int ret;
 	uint16_t status_code =3D MMPDU_STATUS_CODE_UNSPECIFIED;
 	struct netdev *netdev =3D user_data;
+	struct handshake_state *netdev_hs =3D netdev->handshake;
 =

-	if (!netdev->ap || !netdev->in_ft)
-		return;
-
-	ret =3D auth_proto_rx_authenticate(netdev->ap, body, body_len);
+	ret =3D ft_parse_action_response(netdev->ft_over_ds_handshake,
+					netdev->handshake,
+					body, body_len);
 	if (ret < 0)
 		goto ft_error;
 	else if (ret > 0) {
@@ -3610,12 +3632,36 @@ static void netdev_ft_response_frame_event(const st=
ruct mmpdu_header *hdr,
 		goto ft_error;
 	}
 =

+	/*
+	 * At this point the target handshake could be saved off for use later
+	 * if authenticating to multiple APs. As it stands now we actually want
+	 * to FT so begin this process immediately.
+	 */
+	prepare_ft(netdev, netdev->ft_over_ds_target);
+
+	netdev->handshake =3D netdev->ft_over_ds_handshake;
+
+	netdev->ap =3D ft_over_ds_sm_new(netdev->ft_over_ds_handshake,
+					netdev_ft_tx_associate, netdev);
+
+	if (!auth_proto_start(netdev->ap))
+		goto ft_error;
+
+	/* Past the point of no return, free the old handshake */
+	netdev_handshake_state_free(netdev_hs);
+
 	return;
 =

 ft_error:
-	netdev_connect_failed(netdev, NETDEV_RESULT_AUTHENTICATION_FAILED,
-				status_code);
-	return;
+	l_debug("FT-over-DS to "MAC" failed",
+				MAC_STR(netdev->ft_over_ds_target->addr));
+	/*
+	 * A failure here doesn't need to fully disconnect, hence why the
+	 * old netdev->handshake was saved
+	 */
+	netdev->handshake =3D netdev_hs;
+
+	netdev_ft_over_ds_auth_failed(netdev, status_code);
 }
 =

 static void netdev_qos_map_frame_event(const struct mmpdu_header *hdr,
@@ -3640,26 +3686,74 @@ static void netdev_qos_map_frame_event(const struct=
 mmpdu_header *hdr,
 	netdev_send_qos_map_set(netdev, body + 4, body_len - 4);
 }
 =

-static void netdev_ft_over_ds_tx_authenticate(struct iovec *iov,
-					size_t iov_len, void *user_data)
+static void netdev_ft_over_ds_timeout(int error, void *user_data)
 {
 	struct netdev *netdev =3D user_data;
-	uint8_t ft_req[14];
+
+	if (error =3D=3D 0)
+		return;
+
+	l_debug("Sending FT-over-DS action frame failed with %d", error);
+
+	netdev_ft_over_ds_auth_failed(netdev, MMPDU_STATUS_CODE_UNSPECIFIED);
+}
+
+static const struct frame_xchg_prefix netdev_ft_action_prefix =3D {
+	.data =3D (uint8_t []) {
+		0x06, 0x02,
+	},
+	.len =3D 2,
+};
+
+static bool netdev_ft_over_ds_ready(struct wiphy_radio_work_item *item)
+{
+	struct netdev *netdev =3D l_container_of(item, struct netdev, work);
+	uint8_t ft_req[40];
+	uint8_t *ptr =3D ft_req;
 	struct handshake_state *hs =3D netdev->handshake;
-	struct iovec iovs[iov_len + 1];
+	struct iovec iovs[5];
+	uint8_t buf[512];
+	size_t len;
 =

-	ft_req[0] =3D 6; /* FT category */
-	ft_req[1] =3D 1; /* FT Request action */
-	memcpy(ft_req + 2, netdev->addr, 6);
-	memcpy(ft_req + 8, hs->aa, 6);
+	memset(ft_req, 0, sizeof(ft_req));
+
+	l_put_le16(0x00d0, ptr + 0);
+	memcpy(ptr + 4, hs->aa, 6);
+	memcpy(ptr + 10, netdev->addr, 6);
+	memcpy(ptr + 16, hs->aa, 6);
+
+	ptr =3D ft_req + 24;
+
+	ptr[0] =3D 6; /* FT category */
+	ptr[1] =3D 1; /* FT Request action */
+	memcpy(ptr + 2, netdev->addr, 6);
+	memcpy(ptr + 8, netdev->ft_over_ds_target->addr, 6);
 =

 	iovs[0].iov_base =3D ft_req;
 	iovs[0].iov_len =3D sizeof(ft_req);
-	memcpy(iovs + 1, iov, sizeof(*iov) * iov_len);
 =

-	netdev_send_action_framev(netdev, netdev->prev_bssid, iovs, iov_len + 1,
-					netdev->prev_frequency,
-					netdev_ft_request_cb);
+	if (!ft_build_authenticate_ies(hs, netdev->ft_over_ds_handshake->snonce,
+			buf, &len))
+		goto failed;
+
+	iovs[1].iov_base =3D buf;
+	iovs[1].iov_len =3D len;
+
+	iovs[2].iov_base =3D NULL;
+
+	netdev->ft_action_cmd_id =3D frame_xchg_start(netdev->wdev_id, iovs,
+					netdev->frequency, 0, 300, 0, 0,
+					netdev_ft_over_ds_timeout, netdev, NULL,
+					&netdev_ft_action_prefix,
+					netdev_ft_response_frame_event, NULL);
+	if (!netdev->ft_action_cmd_id)
+		goto failed;
+
+	return true;
+
+failed:
+	netdev_ft_over_ds_auth_failed(netdev, MMPDU_STATUS_CODE_UNSPECIFIED);
+	return true;
 }
 =

 static bool netdev_ft_work_ready(struct wiphy_radio_work_item *item)
@@ -3682,8 +3776,11 @@ static const struct wiphy_radio_work_item_ops ft_wor=
k_ops =3D {
 	.do_work =3D netdev_ft_work_ready,
 };
 =

+static const struct wiphy_radio_work_item_ops ft_over_ds_work_ops =3D {
+	.do_work =3D netdev_ft_over_ds_ready,
+};
+
 static int fast_transition(struct netdev *netdev, struct scan_bss *target_=
bss,
-				bool over_air,
 				netdev_connect_cb_t cb)
 {
 	if (!netdev->operational)
@@ -3714,14 +3811,9 @@ static int fast_transition(struct netdev *netdev, st=
ruct scan_bss *target_bss,
 =

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
@@ -3732,14 +3824,36 @@ static int fast_transition(struct netdev *netdev, s=
truct scan_bss *target_bss,
 int netdev_fast_transition(struct netdev *netdev, struct scan_bss *target_=
bss,
 				netdev_connect_cb_t cb)
 {
-	return fast_transition(netdev, target_bss, true, cb);
+	return fast_transition(netdev, target_bss, cb);
 }
 =

 int netdev_fast_transition_over_ds(struct netdev *netdev,
 					struct scan_bss *target_bss,
 					netdev_connect_cb_t cb)
 {
-	return fast_transition(netdev, target_bss, false, cb);
+	if (!netdev->operational)
+		return -ENOTCONN;
+
+	if (!netdev->handshake->mde || !target_bss->mde_present ||
+			l_get_le16(netdev->handshake->mde + 2) !=3D
+			l_get_le16(target_bss->mde))
+		return -EINVAL;
+
+	/*
+	 * Create a new handshake to be used for the initial action frame and
+	 * response. Since failure could happen during these initial steps the
+	 * current handshake must be left pristine in order to maintain the
+	 * existing connection.
+	 */
+	netdev->ft_over_ds_handshake =3D ft_over_ds_handshake_new(netdev,
+								target_bss);
+	netdev->ft_over_ds_target =3D target_bss;
+	netdev->connect_cb =3D cb;
+
+	wiphy_radio_work_insert(netdev->wiphy, &netdev->work, 1,
+				&ft_over_ds_work_ops);
+
+	return 0;
 }
 =

 static void netdev_preauth_cb(const uint8_t *pmk, void *user_data)
@@ -5340,7 +5454,6 @@ struct netdev *netdev_create_from_genl(struct l_genl_=
msg *msg,
 	const uint8_t action_neighbor_report_prefix[2] =3D { 0x05, 0x05 };
 	const uint8_t action_sa_query_resp_prefix[2] =3D { 0x08, 0x01 };
 	const uint8_t action_sa_query_req_prefix[2] =3D { 0x08, 0x00 };
-	const uint8_t action_ft_response_prefix[] =3D  { 0x06, 0x02 };
 	const uint8_t action_qos_map_prefix[] =3D { 0x01, 0x04 };
 	struct l_io *pae_io =3D NULL;
 =

@@ -5428,10 +5541,6 @@ struct netdev *netdev_create_from_genl(struct l_genl=
_msg *msg,
 			sizeof(action_sa_query_req_prefix),
 			netdev_sa_query_req_frame_event, netdev, NULL);
 =

-	frame_watch_add(wdev, 0, 0x00d0, action_ft_response_prefix,
-			sizeof(action_ft_response_prefix),
-			netdev_ft_response_frame_event, netdev, NULL);
-
 	if (wiphy_supports_qos_set_map(netdev->wiphy))
 		frame_watch_add(wdev, 0, 0x00d0, action_qos_map_prefix,
 				sizeof(action_qos_map_prefix),
-- =

2.26.2

--===============4855714082673111584==--

