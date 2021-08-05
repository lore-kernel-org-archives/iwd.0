Content-Type: multipart/mixed; boundary="===============3740613159155940683=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/6] netdev: allow SAE reassociation
Date: Thu, 05 Aug 2021 08:19:55 -0700
Message-ID: <20210805151958.288829-3-prestwoj@gmail.com>
In-Reply-To: <20210805151958.288829-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3740613159155940683==
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
 src/netdev.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index eebced05..e9c19faf 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2715,6 +2715,11 @@ static void netdev_sae_tx_associate(void *user_data)
 =

 	l_genl_msg_append_attrv(msg, NL80211_ATTR_IE, iov, n_used);
 =

+	/* If doing a non-FT Reassociation */
+	if (netdev->in_roam && !IE_AKM_IS_FT(netdev->handshake->akm_suite))
+		l_genl_msg_append_attr(msg, NL80211_ATTR_PREV_BSSID, 6,
+					netdev->prev_bssid);
+
 	if (!l_genl_family_send(nl80211, msg, netdev_assoc_cb, netdev, NULL)) {
 		l_genl_msg_unref(msg);
 		netdev_connect_failed(netdev, NETDEV_RESULT_ASSOCIATION_FAILED,
@@ -3583,7 +3588,7 @@ int netdev_reassociate(struct netdev *netdev, struct =
scan_bss *target_bss,
 			netdev_event_func_t event_filter,
 			netdev_connect_cb_t cb, void *user_data)
 {
-	struct l_genl_msg *cmd_connect;
+	struct l_genl_msg *cmd_connect =3D NULL;
 	struct netdev_handshake_state;
 	struct handshake_state *old_hs;
 	struct eapol_sm *sm =3D NULL, *old_sm;
@@ -3593,16 +3598,21 @@ int netdev_reassociate(struct netdev *netdev, struc=
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
@@ -3612,11 +3622,14 @@ int netdev_reassociate(struct netdev *netdev, struc=
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
+	netdev->in_roam =3D true;
 =

 	netdev_rssi_polling_update(netdev);
 =

-- =

2.31.1

--===============3740613159155940683==--

