Content-Type: multipart/mixed; boundary="===============4603475931554649314=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 4/7] netdev: separate over-air and over-ds netdev APIs
Date: Thu, 29 Apr 2021 16:08:38 -0700
Message-ID: <20210429230841.222368-4-prestwoj@gmail.com>
In-Reply-To: <20210429230841.222368-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4603475931554649314==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netdev.c | 68 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 25891092..232d098d 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3658,10 +3658,25 @@ static void prepare_ft(struct netdev *netdev, struc=
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
@@ -3809,8 +3824,7 @@ static const struct wiphy_radio_work_item_ops ft_work=
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
@@ -3823,32 +3837,13 @@ static int fast_transition(struct netdev *netdev, s=
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
@@ -3856,17 +3851,32 @@ static int fast_transition(struct netdev *netdev, s=
truct scan_bss *target_bss,
 	return 0;
 }
 =

-int netdev_fast_transition(struct netdev *netdev, struct scan_bss *target_=
bss,
-				netdev_connect_cb_t cb)
-{
-	return fast_transition(netdev, target_bss, true, cb);
-}
-
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
+	prepare_ft(netdev, target_bss);
+
+	handshake_state_new_snonce(netdev->handshake);
+
+	netdev->connect_cb =3D cb;
+
+	netdev->ap =3D ft_over_ds_sm_new(netdev->handshake,
+					netdev_ft_over_ds_tx_authenticate,
+					netdev_ft_tx_associate, netdev);
+
+	wiphy_radio_work_insert(netdev->wiphy, &netdev->work, 1,
+				&ft_work_ops);
+
+	return 0;
 }
 =

 static void netdev_preauth_cb(const uint8_t *pmk, void *user_data)
-- =

2.26.2

--===============4603475931554649314==--

