Content-Type: multipart/mixed; boundary="===============7868842894921120483=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/6] netdev: enable FILS reassociation
Date: Thu, 05 Aug 2021 08:19:58 -0700
Message-ID: <20210805151958.288829-6-prestwoj@gmail.com>
In-Reply-To: <20210805151958.288829-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7868842894921120483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the same vein of SAE reassociation create a FILS auth
proto just as we would for a normal connection. Then append
the PREV_BSSID for reassociation.
---
 src/netdev.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index e9c19faf..0800f334 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2803,6 +2803,11 @@ static void netdev_fils_tx_associate(struct iovec *i=
ov, size_t iov_len,
 	l_genl_msg_append_attr(msg, NL80211_ATTR_FILS_KEK, kek_len, kek);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_FILS_NONCES, nonces_len, nonces);
 =

+	/* If doing a non-FT Reassociation */
+	if (netdev->in_roam && !IE_AKM_IS_FT(netdev->handshake->akm_suite))
+		l_genl_msg_append_attr(msg, NL80211_ATTR_PREV_BSSID, 6,
+					netdev->prev_bssid);
+
 	if (!l_genl_family_send(nl80211, msg, netdev_assoc_cb,
 							netdev, NULL)) {
 		l_genl_msg_unref(msg);
@@ -3598,14 +3603,14 @@ int netdev_reassociate(struct netdev *netdev, struc=
t scan_bss *target_bss,
 	if (netdev_handshake_state_setup_connection_type(hs) < 0)
 		return -ENOTSUP;
 =

-	/* TODO: SoftMac FILS Re-Associations are not suppored yet */
-	if (L_WARN_ON(IE_AKM_IS_FILS(hs->akm_suite)))
-		return -ENOTSUP;
-
 	if (IE_AKM_IS_SAE(hs->akm_suite))
 		netdev->ap =3D sae_sm_new(hs, netdev_sae_tx_authenticate,
 						netdev_sae_tx_associate,
 						netdev);
+	else if (IE_AKM_IS_FILS(hs->akm_suite))
+		netdev->ap =3D fils_sm_new(hs, netdev_fils_tx_authenticate,
+						netdev_fils_tx_associate,
+						netdev);
 	else {
 		cmd_connect =3D netdev_build_cmd_connect(netdev, target_bss, hs,
 						orig_bss->addr, NULL, 0);
-- =

2.31.1

--===============7868842894921120483==--

