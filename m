Content-Type: multipart/mixed; boundary="===============1830195726833309190=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/8] netdev: factor out FT handshake preparation
Date: Thu, 15 Apr 2021 15:45:05 -0700
Message-ID: <20210415224508.1823614-5-prestwoj@gmail.com>
In-Reply-To: <20210415224508.1823614-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1830195726833309190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This isolates the handshake/nhs preparation for
FT into its own function to be used by both
FT-over-Air and FT-over-DS after refactoring.
---
 src/netdev.c | 99 +++++++++++++++++++++++++++-------------------------
 1 file changed, 52 insertions(+), 47 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index d8703ed2..4c28fb25 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3529,6 +3529,56 @@ static void netdev_ft_tx_associate(struct iovec *ie_=
iov, size_t iov_len,
 	}
 }
 =

+static void prepare_ft(struct netdev *netdev, struct scan_bss *target_bss)
+{
+	struct netdev_handshake_state *nhs;
+
+	memcpy(netdev->prev_bssid, netdev->handshake->aa, 6);
+	netdev->prev_frequency =3D netdev->frequency;
+	netdev->frequency =3D target_bss->frequency;
+
+	netdev->associated =3D false;
+	netdev->operational =3D false;
+	netdev->in_ft =3D true;
+
+	/*
+	 * Cancel commands that could be running because of EAPoL activity
+	 * like re-keying, this way the callbacks for those commands don't
+	 * have to check if failures resulted from the transition.
+	 */
+	nhs =3D l_container_of(netdev->handshake,
+				struct netdev_handshake_state, super);
+
+	/* reset key states just as we do in initialization */
+	nhs->complete =3D false;
+	nhs->ptk_installed =3D false;
+	nhs->gtk_installed =3D true;
+	nhs->igtk_installed =3D true;
+
+	if (nhs->group_new_key_cmd_id) {
+		l_genl_family_cancel(nl80211, nhs->group_new_key_cmd_id);
+		nhs->group_new_key_cmd_id =3D 0;
+	}
+
+	if (nhs->group_management_new_key_cmd_id) {
+		l_genl_family_cancel(nl80211,
+			nhs->group_management_new_key_cmd_id);
+		nhs->group_management_new_key_cmd_id =3D 0;
+	}
+
+	if (netdev->rekey_offload_cmd_id) {
+		l_genl_family_cancel(nl80211, netdev->rekey_offload_cmd_id);
+		netdev->rekey_offload_cmd_id =3D 0;
+	}
+
+	netdev_rssi_polling_update(netdev);
+
+	if (netdev->sm) {
+		eapol_sm_free(netdev->sm);
+		netdev->sm =3D NULL;
+	}
+}
+
 static void netdev_ft_request_cb(struct l_genl_msg *msg, void *user_data)
 {
 	struct netdev *netdev =3D user_data;
@@ -3636,8 +3686,6 @@ static int fast_transition(struct netdev *netdev, str=
uct scan_bss *target_bss,
 				bool over_air,
 				netdev_connect_cb_t cb)
 {
-	struct netdev_handshake_state *nhs;
-
 	if (!netdev->operational)
 		return -ENOTCONN;
 =

@@ -3651,14 +3699,9 @@ static int fast_transition(struct netdev *netdev, st=
ruct scan_bss *target_bss,
 	 * Could also create a new object and copy most of the state but
 	 * we would end up doing more work.
 	 */
-	memcpy(netdev->prev_bssid, netdev->handshake->aa, ETH_ALEN);
 	memcpy(netdev->prev_snonce, netdev->handshake->snonce, 32);
-
 	handshake_state_new_snonce(netdev->handshake);
 =

-	netdev->prev_frequency =3D netdev->frequency;
-	netdev->frequency =3D target_bss->frequency;
-
 	handshake_state_set_authenticator_address(netdev->handshake,
 							target_bss->addr);
 =

@@ -3667,47 +3710,9 @@ static int fast_transition(struct netdev *netdev, st=
ruct scan_bss *target_bss,
 							target_bss->rsne);
 	memcpy(netdev->handshake->mde + 2, target_bss->mde, 3);
 =

-	netdev->associated =3D false;
-	netdev->operational =3D false;
-	netdev->in_ft =3D true;
-	netdev->connect_cb =3D cb;
-
-	/*
-	 * Cancel commands that could be running because of EAPoL activity
-	 * like re-keying, this way the callbacks for those commands don't
-	 * have to check if failures resulted from the transition.
-	 */
-	nhs =3D l_container_of(netdev->handshake,
-				struct netdev_handshake_state, super);
-
-	/* reset key states just as we do in initialization */
-	nhs->complete =3D false;
-	nhs->ptk_installed =3D false;
-	nhs->gtk_installed =3D true;
-	nhs->igtk_installed =3D true;
+	prepare_ft(netdev, target_bss);
 =

-	if (nhs->group_new_key_cmd_id) {
-		l_genl_family_cancel(nl80211, nhs->group_new_key_cmd_id);
-		nhs->group_new_key_cmd_id =3D 0;
-	}
-
-	if (nhs->group_management_new_key_cmd_id) {
-		l_genl_family_cancel(nl80211,
-			nhs->group_management_new_key_cmd_id);
-		nhs->group_management_new_key_cmd_id =3D 0;
-	}
-
-	if (netdev->rekey_offload_cmd_id) {
-		l_genl_family_cancel(nl80211, netdev->rekey_offload_cmd_id);
-		netdev->rekey_offload_cmd_id =3D 0;
-	}
-
-	netdev_rssi_polling_update(netdev);
-
-	if (netdev->sm) {
-		eapol_sm_free(netdev->sm);
-		netdev->sm =3D NULL;
-	}
+	netdev->connect_cb =3D cb;
 =

 	if (over_air)
 		netdev->ap =3D ft_over_air_sm_new(netdev->handshake,
-- =

2.26.2

--===============1830195726833309190==--

