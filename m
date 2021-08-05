Content-Type: multipart/mixed; boundary="===============6685122538271824146=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/4] netdev: allow SAE reassociation
Date: Thu, 05 Aug 2021 09:59:11 -0700
Message-ID: <20210805165914.293926-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6685122538271824146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds support in netdev_reassociate for SAE. An SAE auth
protocol is created rather than the connect command and from
here there is virtually no difference to a normal connection
attempt. The only differences are 'in_roam' is set as to
ignore the inevitable disconnect event and PREV_BSSID is
appended to CMD_ASSOCIATE only for this new reassociation case.
---
 src/netdev.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index deb780dc..f42e7881 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -182,6 +182,7 @@ struct netdev {
 	bool aborting : 1;
 	bool events_ready : 1;
 	bool retry_auth : 1;
+	bool in_reassoc : 1;
 };
 =

 struct netdev_preauth_state {
@@ -756,6 +757,7 @@ static void netdev_connect_free(struct netdev *netdev)
 	netdev->result =3D NETDEV_RESULT_OK;
 	netdev->last_code =3D 0;
 	netdev->in_ft =3D false;
+	netdev->in_reassoc =3D false;
 	netdev->ignore_connect_event =3D false;
 	netdev->expect_connect_failure =3D false;
 	netdev->cur_rssi_low =3D false;
@@ -1098,7 +1100,7 @@ static void netdev_disconnect_event(struct l_genl_msg=
 *msg,
 	l_debug("");
 =

 	if (!netdev->connected || netdev->disconnect_cmd_id > 0 ||
-			netdev->in_ft)
+			netdev->in_ft || netdev->in_reassoc)
 		return;
 =

 	if (!l_genl_attr_init(&attr, msg)) {
@@ -2535,6 +2537,7 @@ static void netdev_associate_event(struct l_genl_msg =
*msg,
 								false);
 =

 			netdev->in_ft =3D false;
+			netdev->in_reassoc =3D false;
 			netdev->associated =3D true;
 			return;
 		} else if (ret =3D=3D -EAGAIN) {
@@ -2716,6 +2719,11 @@ static void netdev_sae_tx_associate(void *user_data)
 =

 	l_genl_msg_append_attrv(msg, NL80211_ATTR_IE, iov, n_used);
 =

+	/* If doing a non-FT Reassociation */
+	if (netdev->in_reassoc && !IE_AKM_IS_FT(netdev->handshake->akm_suite))
+		l_genl_msg_append_attr(msg, NL80211_ATTR_PREV_BSSID, 6,
+					netdev->prev_bssid);
+
 	if (!l_genl_family_send(nl80211, msg, netdev_assoc_cb, netdev, NULL)) {
 		l_genl_msg_unref(msg);
 		netdev_connect_failed(netdev, NETDEV_RESULT_ASSOCIATION_FAILED,
@@ -3584,7 +3592,7 @@ int netdev_reassociate(struct netdev *netdev, struct =
scan_bss *target_bss,
 			netdev_event_func_t event_filter,
 			netdev_connect_cb_t cb, void *user_data)
 {
-	struct l_genl_msg *cmd_connect;
+	struct l_genl_msg *cmd_connect =3D NULL;
 	struct netdev_handshake_state;
 	struct handshake_state *old_hs;
 	struct eapol_sm *sm =3D NULL, *old_sm;
@@ -3594,16 +3602,21 @@ int netdev_reassociate(struct netdev *netdev, struc=
t scan_bss *target_bss,
 	if (netdev_handshake_state_setup_connection_type(hs) < 0)
 		return -ENOTSUP;
 =

-	/* TODO: SoftMac SAE/FILS Re-Associations are not suppored yet */
-	if (L_WARN_ON(IE_AKM_IS_SAE(hs->akm_suite) ||
-				IE_AKM_IS_FILS(hs->akm_suite)))
+	/* TODO: SoftMac FILS Re-Associations are not suppored yet */
+	if (L_WARN_ON(IE_AKM_IS_FILS(hs->akm_suite)))
 		return -ENOTSUP;
 =

-	cmd_connect =3D netdev_build_cmd_connect(netdev, target_bss, hs,
+	if (IE_AKM_IS_SAE(hs->akm_suite))
+		netdev->ap =3D sae_sm_new(hs, netdev_sae_tx_authenticate,
+						netdev_sae_tx_associate,
+						netdev);
+	else {
+		cmd_connect =3D netdev_build_cmd_connect(netdev, target_bss, hs,
 						orig_bss->addr, NULL, 0);
 =

-	if (is_rsn)
-		sm =3D eapol_sm_new(hs);
+		if (is_rsn)
+			sm =3D eapol_sm_new(hs);
+	}
 =

 	old_sm =3D netdev->sm;
 	old_hs =3D netdev->handshake;
@@ -3613,11 +3626,14 @@ int netdev_reassociate(struct netdev *netdev, struc=
t scan_bss *target_bss,
 	if (err < 0)
 		return err;
 =

+	l_debug("reassociate to "MAC, MAC_STR(target_bss->addr));
+
 	memcpy(netdev->prev_bssid, orig_bss->addr, ETH_ALEN);
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

--===============6685122538271824146==--

