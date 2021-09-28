Content-Type: multipart/mixed; boundary="===============8110601173396578423=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 5/9] ft: get OCI prior to reassociation
Date: Tue, 28 Sep 2021 08:46:54 -0700
Message-ID: <20210928154658.2382597-5-prestwoj@gmail.com>
In-Reply-To: 20210928154658.2382597-1-prestwoj@gmail.com

--===============8110601173396578423==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This modifies the FT logic to fist call get_oci() before
reassociation. This allows the OCI to be included in reassociation
and in the 4-way handshake later on.

The code path for getting the OCI had to be slightly changed to
handle an OCI that is already set. First the handshake chandef is
NULL'ed out for any new connection. This prevents a stale OCI from
being used. Then some checks were added for this case in
netdev_connect_event and if chandef is already set, start the 4-way
handshake.
---
 src/ft.c     | 13 ++++++++++++-
 src/ft.h     |  2 ++
 src/netdev.c | 29 ++++++++++++++++++++++++++---
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index 6897f6d7..40e29341 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -40,6 +40,7 @@ struct ft_sm {
 =

 	ft_tx_authenticate_func_t tx_auth;
 	ft_tx_associate_func_t tx_assoc;
+	ft_get_oci get_oci;
 =

 	void *user_data;
 };
@@ -640,7 +641,7 @@ static int ft_rx_authenticate(struct auth_proto *ap, co=
nst uint8_t *frame,
 	if (ret < 0)
 		goto auth_error;
 =

-	return ft_tx_reassociate(ft);
+	return ft->get_oci(ft->user_data);
 =

 auth_error:
 	return (int)status_code;
@@ -783,6 +784,13 @@ static int ft_rx_associate(struct auth_proto *ap, cons=
t uint8_t *frame,
 	return 0;
 }
 =

+static int ft_rx_oci(struct auth_proto *ap)
+{
+	struct ft_sm *ft =3D l_container_of(ap, struct ft_sm, ap);
+
+	return ft_tx_reassociate(ft);
+}
+
 static void ft_sm_free(struct auth_proto *ap)
 {
 	struct ft_sm *ft =3D l_container_of(ap, struct ft_sm, ap);
@@ -890,12 +898,14 @@ static bool ft_start(struct auth_proto *ap)
 struct auth_proto *ft_over_air_sm_new(struct handshake_state *hs,
 				ft_tx_authenticate_func_t tx_auth,
 				ft_tx_associate_func_t tx_assoc,
+				ft_get_oci get_oci,
 				void *user_data)
 {
 	struct ft_sm *ft =3D l_new(struct ft_sm, 1);
 =

 	ft->tx_auth =3D tx_auth;
 	ft->tx_assoc =3D tx_assoc;
+	ft->get_oci =3D get_oci;
 	ft->hs =3D hs;
 	ft->user_data =3D user_data;
 =

@@ -903,6 +913,7 @@ struct auth_proto *ft_over_air_sm_new(struct handshake_=
state *hs,
 	ft->ap.rx_associate =3D ft_rx_associate;
 	ft->ap.start =3D ft_start;
 	ft->ap.free =3D ft_sm_free;
+	ft->ap.rx_oci =3D ft_rx_oci;
 =

 	return &ft->ap;
 }
diff --git a/src/ft.h b/src/ft.h
index 6167e0d7..cc25463f 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -26,6 +26,7 @@ typedef void (*ft_tx_authenticate_func_t)(struct iovec *i=
ov, size_t iov_len,
 					void *user_data);
 typedef int (*ft_tx_associate_func_t)(struct iovec *ie_iov, size_t iov_len,
 					void *user_data);
+typedef int (*ft_get_oci)(void *user_data);
 =

 typedef void (*ft_ds_free_func_t)(void *user_data);
 =

@@ -60,6 +61,7 @@ bool ft_over_ds_parse_action_ies(struct ft_ds_info *info,
 struct auth_proto *ft_over_air_sm_new(struct handshake_state *hs,
 				ft_tx_authenticate_func_t tx_auth,
 				ft_tx_associate_func_t tx_assoc,
+				ft_get_oci get_oci,
 				void *user_data);
 =

 struct auth_proto *ft_over_ds_sm_new(struct handshake_state *hs,
diff --git a/src/netdev.c b/src/netdev.c
index 9a4eff0f..a0669173 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2074,6 +2074,21 @@ static void netdev_get_oci_cb(struct l_genl_msg *msg=
, void *user_data)
 	handshake_state_set_chandef(netdev->handshake, l_steal_ptr(chandef));
 =

 done:
+	if (netdev->ap) {
+		/*
+		 * Cant do much here. IWD assumes every kernel/driver supports
+		 * this. There is no way of detecting support either.
+		 */
+		if (L_WARN_ON(err < 0))
+			netdev_connect_failed(netdev,
+					NETDEV_RESULT_AUTHENTICATION_FAILED,
+					MMPDU_STATUS_CODE_UNSPECIFIED);
+		else
+			auth_proto_rx_oci(netdev->ap);
+
+		return;
+	}
+
 	L_WARN_ON(!eapol_start(netdev->sm));
 }
 =

@@ -2581,8 +2596,11 @@ process_resp_ies:
 	}
 =

 	if (netdev->sm) {
-		if (netdev_get_oci(netdev) < 0)
-			goto deauth;
+		if (!netdev->handshake->chandef) {
+			if (netdev_get_oci(netdev) < 0)
+				goto deauth;
+		} else if (!eapol_start(netdev->sm))
+				goto deauth;
 =

 		return;
 	}
@@ -3633,6 +3651,8 @@ static void netdev_connect_common(struct netdev *netd=
ev,
 	netdev->privacy =3D bss->capability & IE_BSS_CAP_PRIVACY;
 	handshake_state_set_authenticator_address(hs, bss->addr);
 =

+	handshake_state_set_chandef(hs, NULL);
+
 	if (!is_rsn)
 		goto build_cmd_connect;
 =

@@ -4099,6 +4119,8 @@ static void prepare_ft(struct netdev *netdev, const s=
truct scan_bss *target_bss)
 	netdev->operational =3D false;
 	netdev->in_ft =3D true;
 =

+	handshake_state_set_chandef(netdev->handshake, NULL);
+
 	/*
 	 * Cancel commands that could be running because of EAPoL activity
 	 * like re-keying, this way the callbacks for those commands don't
@@ -4273,7 +4295,8 @@ int netdev_fast_transition(struct netdev *netdev,
 =

 	netdev->ap =3D ft_over_air_sm_new(netdev->handshake,
 					netdev_ft_tx_authenticate,
-					netdev_ft_tx_associate, netdev);
+					netdev_ft_tx_associate,
+					netdev_get_oci, netdev);
 	memcpy(netdev->ap->prev_bssid, orig_bss->addr, ETH_ALEN);
 =

 	wiphy_radio_work_insert(netdev->wiphy, &netdev->work, 1,
-- =

2.31.1

--===============8110601173396578423==--

