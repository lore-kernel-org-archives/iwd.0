Content-Type: multipart/mixed; boundary="===============1696631214653828349=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 5/7] ft: netdev: refactor FT-over-DS into two stages
Date: Thu, 29 Apr 2021 16:08:39 -0700
Message-ID: <20210429230841.222368-5-prestwoj@gmail.com>
In-Reply-To: <20210429230841.222368-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1696631214653828349==
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
 src/ft.c     |  74 +++----------------
 src/ft.h     |   1 -
 src/netdev.c | 196 ++++++++++++++++++++++++++++++++++++++++-----------
 src/netdev.h |   8 +++
 4 files changed, 169 insertions(+), 110 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index d5f1db5b..76285d13 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -156,40 +156,6 @@ static bool ft_parse_authentication_resp_frame(const u=
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
@@ -612,34 +578,6 @@ bool ft_over_ds_prepare_handshake(struct ft_ds_info *i=
nfo,
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
 void ft_ds_info_free(struct ft_ds_info *info)
 {
 	__typeof__(info->free) destroy =3D info->free;
@@ -827,6 +765,13 @@ static void ft_sm_free(struct auth_proto *ap)
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
@@ -938,20 +883,17 @@ struct auth_proto *ft_over_air_sm_new(struct handshak=
e_state *hs,
 }
 =

 struct auth_proto *ft_over_ds_sm_new(struct handshake_state *hs,
-				ft_tx_authenticate_func_t tx_auth,
 				ft_tx_associate_func_t tx_assoc,
 				void *user_data)
 {
 	struct ft_sm *ft =3D l_new(struct ft_sm, 1);
 =

 	ft->tx_assoc =3D tx_assoc;
-	ft->tx_auth =3D tx_auth;
 	ft->hs =3D hs;
 	ft->user_data =3D user_data;
 =

-	ft->ap.rx_authenticate =3D ft_rx_action;
 	ft->ap.rx_associate =3D ft_rx_associate;
-	ft->ap.start =3D ft_start;
+	ft->ap.start =3D ft_over_ds_start;
 	ft->ap.free =3D ft_sm_free;
 =

 	return &ft->ap;
diff --git a/src/ft.h b/src/ft.h
index 907c3d5d..7c009f16 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -57,7 +57,6 @@ struct auth_proto *ft_over_air_sm_new(struct handshake_st=
ate *hs,
 				void *user_data);
 =

 struct auth_proto *ft_over_ds_sm_new(struct handshake_state *hs,
-				ft_tx_authenticate_func_t tx_auth,
 				ft_tx_associate_func_t tx_assoc,
 				void *user_data);
 =

diff --git a/src/netdev.c b/src/netdev.c
index 232d098d..97e6665b 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -92,6 +92,14 @@ struct netdev_handshake_state {
 	enum connection_type type;
 };
 =

+struct netdev_ft_over_ds_info {
+	struct ft_ds_info super;
+	struct netdev *netdev;
+	struct l_timeout *timeout;
+	netdev_ft_over_ds_cb_t cb;
+	void *user_data;
+};
+
 struct netdev {
 	uint32_t index;
 	uint64_t wdev_id;
@@ -159,6 +167,8 @@ struct netdev {
 	struct l_genl_msg *auth_cmd;
 	struct wiphy_radio_work_item work;
 =

+	struct netdev_ft_over_ds_info *ft_ds_info;
+
 	bool connected : 1;
 	bool associated : 1;
 	bool operational : 1;
@@ -741,6 +751,9 @@ static void netdev_connect_free(struct netdev *netdev)
 		l_genl_family_cancel(nl80211, netdev->disconnect_cmd_id);
 		netdev->disconnect_cmd_id =3D 0;
 	}
+
+	if (netdev->ft_ds_info)
+		ft_ds_info_free(&netdev->ft_ds_info->super);
 }
 =

 static void netdev_connect_failed(struct netdev *netdev,
@@ -3719,44 +3732,52 @@ static void prepare_ft(struct netdev *netdev, struc=
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
+	if (info->cb)
+		info->cb(info->netdev, status, info->super.aa, info->user_data);
 =

-	if (err < 0) {
-		l_error("Could not send CMD_FRAME (%d)", err);
-		netdev_connect_failed(netdev,
-					NETDEV_RESULT_AUTHENTICATION_FAILED,
-					MMPDU_STATUS_CODE_UNSPECIFIED);
-	}
+	ft_ds_info_free(&info->super);
+
+	info->netdev->ft_ds_info =3D NULL;
 }
 =

 static void netdev_ft_response_frame_event(const struct mmpdu_header *hdr,
 					const void *body, size_t body_len,
 					int rssi, void *user_data)
 {
+	struct netdev *netdev =3D user_data;
+	struct netdev_ft_over_ds_info *info =3D netdev->ft_ds_info;
 	int ret;
 	uint16_t status_code =3D MMPDU_STATUS_CODE_UNSPECIFIED;
-	struct netdev *netdev =3D user_data;
 =

-	if (!netdev->ap || !netdev->in_ft)
+	if (!info)
 		return;
 =

-	ret =3D auth_proto_rx_authenticate(netdev->ap, body, body_len);
+	l_timeout_remove(info->timeout);
+	info->timeout =3D NULL;
+
+	ret =3D ft_over_ds_parse_action_response(&info->super, netdev->handshake,
+						body, body_len);
 	if (ret < 0)
-		goto ft_error;
-	else if (ret > 0) {
+		return;
+
+	/* Now make sure the packet contained a success status code */
+	if (ret > 0) {
 		status_code =3D (uint16_t)ret;
 		goto ft_error;
 	}
 =

+	if (info->cb)
+		info->cb(netdev, 0, info->super.aa, info->user_data);
+
 	return;
 =

 ft_error:
-	netdev_connect_failed(netdev, NETDEV_RESULT_AUTHENTICATION_FAILED,
-				status_code);
-	return;
+	l_debug("FT-over-DS to "MAC" failed", MAC_STR(info->super.aa));
+
+	netdev_ft_over_ds_auth_failed(info, status_code);
 }
 =

 static void netdev_qos_map_frame_event(const struct mmpdu_header *hdr,
@@ -3781,29 +3802,6 @@ static void netdev_qos_map_frame_event(const struct =
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
@@ -3855,6 +3853,11 @@ int netdev_fast_transition_over_ds(struct netdev *ne=
tdev,
 					struct scan_bss *target_bss,
 					netdev_connect_cb_t cb)
 {
+	struct netdev_ft_over_ds_info *info =3D netdev->ft_ds_info;
+
+	if (!info)
+		return -ENOENT;
+
 	if (!netdev->operational)
 		return -ENOTCONN;
 =

@@ -3865,13 +3868,14 @@ int netdev_fast_transition_over_ds(struct netdev *n=
etdev,
 =

 	prepare_ft(netdev, target_bss);
 =

-	handshake_state_new_snonce(netdev->handshake);
+	if (!ft_over_ds_prepare_handshake(&info->super, netdev->handshake))
+		return -ENOENT;
 =

 	netdev->connect_cb =3D cb;
 =

 	netdev->ap =3D ft_over_ds_sm_new(netdev->handshake,
-					netdev_ft_over_ds_tx_authenticate,
-					netdev_ft_tx_associate, netdev);
+					netdev_ft_tx_associate,
+					netdev);
 =

 	wiphy_radio_work_insert(netdev->wiphy, &netdev->work, 1,
 				&ft_work_ops);
@@ -3879,6 +3883,112 @@ int netdev_fast_transition_over_ds(struct netdev *n=
etdev,
 	return 0;
 }
 =

+static void netdev_ft_request_cb(struct l_genl_msg *msg, void *user_data)
+{
+	struct netdev_ft_over_ds_info *info =3D user_data;
+
+	if (l_genl_msg_get_error(msg) < 0) {
+		l_error("Could not send CMD_FRAME for FT-over-DS");
+		netdev_ft_over_ds_auth_failed(info,
+					MMPDU_STATUS_CODE_UNSPECIFIED);
+	}
+}
+
+static void netdev_ft_over_ds_timeout(struct l_timeout *timeout,
+					void *user_data)
+{
+	struct netdev_ft_over_ds_info *info =3D user_data;
+
+	l_timeout_remove(info->timeout);
+	info->timeout =3D NULL;
+
+	l_debug("");
+
+	netdev_ft_over_ds_auth_failed(info, MMPDU_STATUS_CODE_UNSPECIFIED);
+}
+
+static void netdev_ft_ds_info_free(struct ft_ds_info *ft)
+{
+	struct netdev_ft_over_ds_info *info =3D l_container_of(ft,
+					struct netdev_ft_over_ds_info, super);
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
+
+	/* TODO: Just allow single outstanding action frame for now */
+	if (netdev->ft_ds_info)
+		return -EALREADY;
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
+	info =3D l_new(struct netdev_ft_over_ds_info, 1);
+	info->netdev =3D netdev;
+
+	memcpy(info->super.spa, hs->spa, ETH_ALEN);
+	memcpy(info->super.aa, target_bss->addr, ETH_ALEN);
+	memcpy(info->super.mde, target_bss->mde, sizeof(info->super.mde));
+	l_getrandom(info->super.snonce, 32);
+	info->super.free =3D netdev_ft_ds_info_free;
+
+	info->cb =3D cb;
+	info->user_data =3D user_data;
+
+	ft_req[0] =3D 6; /* FT category */
+	ft_req[1] =3D 1; /* FT Request action */
+	memcpy(ft_req + 2, netdev->addr, 6);
+	memcpy(ft_req + 8, info->super.aa, 6);
+
+	iovs[0].iov_base =3D ft_req;
+	iovs[0].iov_len =3D sizeof(ft_req);
+
+	if (!ft_build_authenticate_ies(hs, info->super.snonce, buf, &len))
+		goto failed;
+
+	iovs[1].iov_base =3D buf;
+	iovs[1].iov_len =3D len;
+
+	iovs[2].iov_base =3D NULL;
+
+	netdev->ft_ds_info =3D info;
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
+}
+
 static void netdev_preauth_cb(const uint8_t *pmk, void *user_data)
 {
 	struct netdev_preauth_state *preauth =3D user_data;
diff --git a/src/netdev.h b/src/netdev.h
index 43ea3893..2f7f3647 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -125,6 +125,10 @@ typedef void (*netdev_get_station_cb_t)(
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
@@ -158,6 +162,10 @@ int netdev_reassociate(struct netdev *netdev, struct s=
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
 					netdev_connect_cb_t cb);
-- =

2.26.2

--===============1696631214653828349==--

