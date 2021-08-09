Content-Type: multipart/mixed; boundary="===============0913674193538297937=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/4] netdev: move failure point out of netdev_connect_common
Date: Mon, 09 Aug 2021 10:42:56 -0700
Message-ID: <20210809174259.537399-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0913674193538297937==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The only point of failure in netdev_connect_common was setting
up the handshake type. Moving this outside of netdev_connect_common
makes the code flow much better in netdev_{connect,reassociate} as
nothing needs to be reset upon failure.
---
 src/netdev.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

v3:
 * Fixed previous break to open networks due to netdev_connect_common
   not handling the !is_rsn special case. This check was moved into
   netdev_handshake_state_setup_connection_type.

diff --git a/src/netdev.c b/src/netdev.c
index 1b72b0a7..f9731892 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3364,6 +3364,9 @@ static int netdev_handshake_state_setup_connection_ty=
pe(
 	bool softmac =3D wiphy_supports_cmds_auth_assoc(wiphy);
 	bool canroam =3D wiphy_supports_firmware_roam(wiphy);
 =

+	if (hs->supplicant_ie =3D=3D NULL)
+		goto softmac;
+
 	/*
 	 * Sanity check that any FT AKMs are set only on softmac or on
 	 * devices that support firmware roam
@@ -3442,7 +3445,7 @@ offload_1x:
 	return 0;
 }
 =

-static int netdev_connect_common(struct netdev *netdev,
+static void netdev_connect_common(struct netdev *netdev,
 					struct scan_bss *bss,
 					struct scan_bss *prev_bss,
 					struct handshake_state *hs,
@@ -3458,13 +3461,8 @@ static int netdev_connect_common(struct netdev *netd=
ev,
 	bool is_rsn =3D hs->supplicant_ie !=3D NULL;
 	const uint8_t *prev_bssid =3D prev_bss ? prev_bss->addr : NULL;
 =

-	if (!is_rsn) {
-		nhs->type =3D CONNECTION_TYPE_SOFTMAC;
+	if (!is_rsn)
 		goto build_cmd_connect;
-	}
-
-	if (netdev_handshake_state_setup_connection_type(hs) < 0)
-		return -ENOTSUP;
 =

 	if (nhs->type !=3D CONNECTION_TYPE_SOFTMAC)
 		goto build_cmd_connect;
@@ -3534,7 +3532,7 @@ build_cmd_connect:
 	wiphy_radio_work_insert(netdev->wiphy, &netdev->work, 1,
 				&connect_work_ops);
 =

-	return 0;
+	return;
 }
 =

 int netdev_connect(struct netdev *netdev, struct scan_bss *bss,
@@ -3554,9 +3552,14 @@ int netdev_connect(struct netdev *netdev, struct sca=
n_bss *bss,
 	if (netdev->connected || netdev->connect_cmd_id || netdev->work.id)
 		return -EISCONN;
 =

-	return netdev_connect_common(netdev, bss, NULL, hs, vendor_ies,
+	if (netdev_handshake_state_setup_connection_type(hs) < 0)
+		return -ENOTSUP;
+
+	netdev_connect_common(netdev, bss, NULL, hs, vendor_ies,
 					num_vendor_ies, event_filter, cb,
 					user_data);
+
+	return 0;
 }
 =

 static void disconnect_idle(struct l_idle *idle, void *user_data)
@@ -3646,24 +3649,24 @@ int netdev_reassociate(struct netdev *netdev, struc=
t scan_bss *target_bss,
 {
 	struct handshake_state *old_hs;
 	struct eapol_sm *old_sm;
-	int ret;
 =

 	old_sm =3D netdev->sm;
 	old_hs =3D netdev->handshake;
 =

-	ret =3D netdev_connect_common(netdev, target_bss, orig_bss, hs, NULL, 0,
-					event_filter, cb, user_data);
-	if (ret < 0)
-		return ret;
-
-	if (netdev->ap)
-		memcpy(netdev->ap->prev_bssid, orig_bss->addr, ETH_ALEN);
+	if (netdev_handshake_state_setup_connection_type(hs) < 0)
+		return -ENOTSUP;
 =

 	netdev->associated =3D false;
 	netdev->operational =3D false;
 	netdev->connected =3D false;
 	netdev->in_reassoc =3D true;
 =

+	netdev_connect_common(netdev, target_bss, orig_bss, hs, NULL, 0,
+					event_filter, cb, user_data);
+
+	if (netdev->ap)
+		memcpy(netdev->ap->prev_bssid, orig_bss->addr, ETH_ALEN);
+
 	netdev_rssi_polling_update(netdev);
 =

 	if (old_sm)
-- =

2.31.1

--===============0913674193538297937==--

