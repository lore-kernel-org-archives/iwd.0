Content-Type: multipart/mixed; boundary="===============5872713902976473752=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/4] netdev: enable FILS reassociation
Date: Thu, 05 Aug 2021 09:59:14 -0700
Message-ID: <20210805165914.293926-4-prestwoj@gmail.com>
In-Reply-To: <20210805165914.293926-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5872713902976473752==
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
index f42e7881..3beb767c 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2807,6 +2807,11 @@ static void netdev_fils_tx_associate(struct iovec *i=
ov, size_t iov_len,
 	l_genl_msg_append_attr(msg, NL80211_ATTR_FILS_KEK, kek_len, kek);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_FILS_NONCES, nonces_len, nonces);
 =

+	/* If doing a non-FT Reassociation */
+	if (netdev->in_reassoc && !IE_AKM_IS_FT(netdev->handshake->akm_suite))
+		l_genl_msg_append_attr(msg, NL80211_ATTR_PREV_BSSID, 6,
+					netdev->prev_bssid);
+
 	if (!l_genl_family_send(nl80211, msg, netdev_assoc_cb,
 							netdev, NULL)) {
 		l_genl_msg_unref(msg);
@@ -3602,14 +3607,14 @@ int netdev_reassociate(struct netdev *netdev, struc=
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

--===============5872713902976473752==--

