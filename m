Content-Type: multipart/mixed; boundary="===============8067810038988035314=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/4] netdev: allow SAE reassociation
Date: Thu, 05 Aug 2021 12:05:32 -0700
Message-ID: <20210805190535.309292-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8067810038988035314==
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
 src/netdev.c | 45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 2ae76a1e..09c446a1 100644
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
+	if (netdev->in_reassoc && !IE_AKM_IS_FT(netdev->handshake->akm_suite))
+		l_genl_msg_append_attr(msg, NL80211_ATTR_PREV_BSSID, 6,
+					netdev->ap->prev_bssid);
+
 	if (!l_genl_family_send(nl80211, msg, netdev_assoc_cb, netdev, NULL)) {
 		l_genl_msg_unref(msg);
 		netdev_connect_failed(netdev, NETDEV_RESULT_ASSOCIATION_FAILED,
@@ -3582,25 +3590,40 @@ int netdev_reassociate(struct netdev *netdev, struc=
t scan_bss *target_bss,
 			netdev_event_func_t event_filter,
 			netdev_connect_cb_t cb, void *user_data)
 {
-	struct l_genl_msg *cmd_connect;
-	struct netdev_handshake_state;
+	struct netdev_handshake_state *nhs =3D l_container_of(hs,
+				struct netdev_handshake_state, super);
+	struct l_genl_msg *cmd_connect =3D NULL;
 	struct handshake_state *old_hs;
 	struct eapol_sm *sm =3D NULL, *old_sm;
 	bool is_rsn =3D hs->supplicant_ie !=3D NULL;
 =

+	if (!is_rsn) {
+		nhs->type =3D CONNECTION_TYPE_SOFTMAC;
+		goto build_cmd_connect;
+	}
+
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
+	if (nhs->type !=3D CONNECTION_TYPE_SOFTMAC)
+		goto build_cmd_connect;
+
+	if (IE_AKM_IS_SAE(hs->akm_suite))
+		netdev->ap =3D sae_sm_new(hs, netdev_sae_tx_authenticate,
+						netdev_sae_tx_associate,
+						netdev);
+	else {
+build_cmd_connect:
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
@@ -3608,9 +3631,13 @@ int netdev_reassociate(struct netdev *netdev, struct=
 scan_bss *target_bss,
 	netdev_connect_common(netdev, cmd_connect, target_bss, hs, sm,
 					event_filter, cb, user_data);
 =

+	if (netdev->ap)
+		memcpy(netdev->ap->prev_bssid, orig_bss->addr, ETH_ALEN);
+
 	netdev->associated =3D false;
 	netdev->operational =3D false;
 	netdev->connected =3D false;
+	netdev->in_reassoc =3D true;
 =

 	netdev_rssi_polling_update(netdev);
 =

-- =

2.31.1

--===============8067810038988035314==--

