Content-Type: multipart/mixed; boundary="===============7698506051672754891=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] netdev: allow reassociation for auth-protos
Date: Fri, 06 Aug 2021 15:59:05 -0700
Message-ID: <20210806225905.381445-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7698506051672754891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds support in netdev_reassociate for all the auth
protocols (SAE/FILS/OWE) by moving the bulk of netdev_connect
into netdev_connect_common. In addition PREV_BSSID is set
in the associate message if 'in_reassoc' is true.
---
 src/netdev.c | 140 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 76 insertions(+), 64 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 2ae76a1e..74eb349c 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -180,6 +180,7 @@ struct netdev {
 	bool aborting : 1;
 	bool events_ready : 1;
 	bool retry_auth : 1;
+	bool in_reassoc : 1;
 };
 =

 struct netdev_preauth_state {
@@ -754,6 +755,7 @@ static void netdev_connect_free(struct netdev *netdev)
 	netdev->result =3D NETDEV_RESULT_OK;
 	netdev->last_code =3D 0;
 	netdev->in_ft =3D false;
+	netdev->in_reassoc =3D false;
 	netdev->ignore_connect_event =3D false;
 	netdev->expect_connect_failure =3D false;
 	netdev->cur_rssi_low =3D false;
@@ -1096,7 +1098,7 @@ static void netdev_disconnect_event(struct l_genl_msg=
 *msg,
 	l_debug("");
 =

 	if (!netdev->connected || netdev->disconnect_cmd_id > 0 ||
-			netdev->in_ft)
+			netdev->in_ft || netdev->in_reassoc)
 		return;
 =

 	if (!l_genl_attr_init(&attr, msg)) {
@@ -2533,6 +2535,7 @@ static void netdev_associate_event(struct l_genl_msg =
*msg,
 								false);
 =

 			netdev->in_ft =3D false;
+			netdev->in_reassoc =3D false;
 			netdev->associated =3D true;
 			return;
 		} else if (ret =3D=3D -EAGAIN) {
@@ -2714,6 +2717,11 @@ static void netdev_sae_tx_associate(void *user_data)
 =

 	l_genl_msg_append_attrv(msg, NL80211_ATTR_IE, iov, n_used);
 =

+	/* If doing a non-FT Reassociation */
+	if (netdev->in_reassoc)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_PREV_BSSID, 6,
+					netdev->ap->prev_bssid);
+
 	if (!l_genl_family_send(nl80211, msg, netdev_assoc_cb, netdev, NULL)) {
 		l_genl_msg_unref(msg);
 		netdev_connect_failed(netdev, NETDEV_RESULT_ASSOCIATION_FAILED,
@@ -2751,6 +2759,11 @@ static void netdev_owe_tx_associate(struct iovec *ie=
_iov, size_t iov_len,
 =

 	l_genl_msg_append_attrv(msg, NL80211_ATTR_IE, ie_iov, iov_len);
 =

+	/* If doing a non-FT Reassociation */
+	if (netdev->in_reassoc)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_PREV_BSSID, 6,
+					netdev->ap->prev_bssid);
+
 	if (!l_genl_family_send(nl80211, msg, netdev_assoc_cb,
 							netdev, NULL)) {
 		l_genl_msg_unref(msg);
@@ -2797,6 +2810,11 @@ static void netdev_fils_tx_associate(struct iovec *i=
ov, size_t iov_len,
 	l_genl_msg_append_attr(msg, NL80211_ATTR_FILS_KEK, kek_len, kek);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_FILS_NONCES, nonces_len, nonces);
 =

+	/* If doing a non-FT Reassociation */
+	if (netdev->in_reassoc)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_PREV_BSSID, 6,
+					netdev->ap->prev_bssid);
+
 	if (!l_genl_family_send(nl80211, msg, netdev_assoc_cb,
 							netdev, NULL)) {
 		l_genl_msg_unref(msg);
@@ -3384,57 +3402,21 @@ offload_1x:
 	return 0;
 }
 =

-static void netdev_connect_common(struct netdev *netdev,
-					struct l_genl_msg *cmd_connect,
+static int netdev_connect_common(struct netdev *netdev,
 					struct scan_bss *bss,
+					struct scan_bss *prev_bss,
 					struct handshake_state *hs,
-					struct eapol_sm *sm,
+					const struct iovec *vendor_ies,
+					size_t num_vendor_ies,
 					netdev_event_func_t event_filter,
 					netdev_connect_cb_t cb, void *user_data)
-{
-	netdev->connect_cmd =3D cmd_connect;
-	netdev->event_filter =3D event_filter;
-	netdev->connect_cb =3D cb;
-	netdev->user_data =3D user_data;
-	netdev->handshake =3D hs;
-	netdev->sm =3D sm;
-	netdev->frequency =3D bss->frequency;
-	netdev->cur_rssi =3D bss->signal_strength / 100;
-	netdev_rssi_level_init(netdev);
-	netdev_cqm_rssi_update(netdev);
-
-	handshake_state_set_authenticator_address(hs, bss->addr);
-
-	if (!wiphy_has_ext_feature(netdev->wiphy,
-					NL80211_EXT_FEATURE_CAN_REPLACE_PTK0))
-		handshake_state_set_no_rekey(hs, true);
-
-	wiphy_radio_work_insert(netdev->wiphy, &netdev->work, 1,
-				&connect_work_ops);
-}
-
-int netdev_connect(struct netdev *netdev, struct scan_bss *bss,
-				struct handshake_state *hs,
-				const struct iovec *vendor_ies,
-				size_t num_vendor_ies,
-				netdev_event_func_t event_filter,
-				netdev_connect_cb_t cb, void *user_data)
 {
 	struct netdev_handshake_state *nhs =3D l_container_of(hs,
 				struct netdev_handshake_state, super);
 	struct l_genl_msg *cmd_connect =3D NULL;
 	struct eapol_sm *sm =3D NULL;
 	bool is_rsn =3D hs->supplicant_ie !=3D NULL;
-
-	if (!(netdev->ifi_flags & IFF_UP))
-		return -ENETDOWN;
-
-	if (netdev->type !=3D NL80211_IFTYPE_STATION &&
-			netdev->type !=3D NL80211_IFTYPE_P2P_CLIENT)
-		return -ENOTSUP;
-
-	if (netdev->connected || netdev->connect_cmd_id || netdev->work.id)
-		return -EISCONN;
+	const uint8_t *prev_bssid =3D prev_bss ? prev_bss->addr : NULL;
 =

 	if (!is_rsn) {
 		nhs->type =3D CONNECTION_TYPE_SOFTMAC;
@@ -3482,7 +3464,7 @@ int netdev_connect(struct netdev *netdev, struct scan=
_bss *bss,
 	default:
 build_cmd_connect:
 		cmd_connect =3D netdev_build_cmd_connect(netdev, bss, hs,
-					NULL, vendor_ies, num_vendor_ies);
+					prev_bssid, vendor_ies, num_vendor_ies);
 =

 		if (!is_offload(hs) && (is_rsn || hs->settings_8021x)) {
 			sm =3D eapol_sm_new(hs);
@@ -3492,11 +3474,51 @@ build_cmd_connect:
 		}
 	}
 =

-	netdev_connect_common(netdev, cmd_connect, bss, hs, sm,
-						event_filter, cb, user_data);
+	netdev->connect_cmd =3D cmd_connect;
+	netdev->event_filter =3D event_filter;
+	netdev->connect_cb =3D cb;
+	netdev->user_data =3D user_data;
+	netdev->handshake =3D hs;
+	netdev->sm =3D sm;
+	netdev->frequency =3D bss->frequency;
+	netdev->cur_rssi =3D bss->signal_strength / 100;
+	netdev_rssi_level_init(netdev);
+	netdev_cqm_rssi_update(netdev);
+
+	handshake_state_set_authenticator_address(hs, bss->addr);
+
+	if (!wiphy_has_ext_feature(netdev->wiphy,
+					NL80211_EXT_FEATURE_CAN_REPLACE_PTK0))
+		handshake_state_set_no_rekey(hs, true);
+
+	wiphy_radio_work_insert(netdev->wiphy, &netdev->work, 1,
+				&connect_work_ops);
+
 	return 0;
 }
 =

+int netdev_connect(struct netdev *netdev, struct scan_bss *bss,
+				struct handshake_state *hs,
+				const struct iovec *vendor_ies,
+				size_t num_vendor_ies,
+				netdev_event_func_t event_filter,
+				netdev_connect_cb_t cb, void *user_data)
+{
+	if (!(netdev->ifi_flags & IFF_UP))
+		return -ENETDOWN;
+
+	if (netdev->type !=3D NL80211_IFTYPE_STATION &&
+			netdev->type !=3D NL80211_IFTYPE_P2P_CLIENT)
+		return -ENOTSUP;
+
+	if (netdev->connected || netdev->connect_cmd_id || netdev->work.id)
+		return -EISCONN;
+
+	return netdev_connect_common(netdev, bss, NULL, hs, vendor_ies,
+					num_vendor_ies, event_filter, cb,
+					user_data);
+}
+
 static void disconnect_idle(struct l_idle *idle, void *user_data)
 {
 	struct netdev *netdev =3D user_data;
@@ -3582,35 +3604,25 @@ int netdev_reassociate(struct netdev *netdev, struc=
t scan_bss *target_bss,
 			netdev_event_func_t event_filter,
 			netdev_connect_cb_t cb, void *user_data)
 {
-	struct l_genl_msg *cmd_connect;
-	struct netdev_handshake_state;
 	struct handshake_state *old_hs;
-	struct eapol_sm *sm =3D NULL, *old_sm;
-	bool is_rsn =3D hs->supplicant_ie !=3D NULL;
-
-	if (netdev_handshake_state_setup_connection_type(hs) < 0)
-		return -ENOTSUP;
-
-	/* TODO: SoftMac SAE/FILS Re-Associations are not suppored yet */
-	if (L_WARN_ON(IE_AKM_IS_SAE(hs->akm_suite) ||
-				IE_AKM_IS_FILS(hs->akm_suite)))
-		return -ENOTSUP;
-
-	cmd_connect =3D netdev_build_cmd_connect(netdev, target_bss, hs,
-						orig_bss->addr, NULL, 0);
-
-	if (is_rsn)
-		sm =3D eapol_sm_new(hs);
+	struct eapol_sm *old_sm;
+	int ret;
 =

 	old_sm =3D netdev->sm;
 	old_hs =3D netdev->handshake;
 =

-	netdev_connect_common(netdev, cmd_connect, target_bss, hs, sm,
+	ret =3D netdev_connect_common(netdev, target_bss, orig_bss, hs, NULL, 0,
 					event_filter, cb, user_data);
+	if (ret < 0)
+		return ret;
+
+	if (netdev->ap)
+		memcpy(netdev->ap->prev_bssid, orig_bss->addr, ETH_ALEN);
 =

 	netdev->associated =3D false;
 	netdev->operational =3D false;
 	netdev->connected =3D false;
+	netdev->in_reassoc =3D true;
 =

 	netdev_rssi_polling_update(netdev);
 =

-- =

2.31.1

--===============7698506051672754891==--

