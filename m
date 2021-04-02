Content-Type: multipart/mixed; boundary="===============6764791917559049472=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v6 4/4] netdev: allow PSK offload for FT AKMs
Date: Fri, 02 Apr 2021 15:06:17 -0700
Message-ID: <20210402220617.937790-4-prestwoj@gmail.com>
In-Reply-To: <20210402220617.937790-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6764791917559049472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds a new connection type, TYPE_PSK_OFFLOAD, which
allows the 4-way handshake to be offloaded by the firmware.
Offloading will be used if the driver advertises support.

The CMD_ROAM event path was also modified to take into account
handshake offloading. If the handshake is offloaded we still
must issue GET_SCAN, but not start eapol since the firmware
takes care of this.
---
 src/netdev.c | 50 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index fe29de8f..e7ffb635 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -71,6 +71,7 @@ enum connection_type {
 	CONNECTION_TYPE_SOFTMAC,
 	CONNECTION_TYPE_FULLMAC,
 	CONNECTION_TYPE_SAE_OFFLOAD,
+	CONNECTION_TYPE_PSK_OFFLOAD,
 };
 =

 static uint32_t unicast_watch;
@@ -202,6 +203,7 @@ static inline bool is_offload(struct handshake_state *h=
s)
 	case CONNECTION_TYPE_FULLMAC:
 		return false;
 	case CONNECTION_TYPE_SAE_OFFLOAD:
+	case CONNECTION_TYPE_PSK_OFFLOAD:
 		return true;
 	}
 =

@@ -1238,11 +1240,6 @@ static void netdev_connect_ok(struct netdev *netdev)
 		netdev->fw_roam_bss =3D NULL;
 	}
 =

-	/* Allow station to sync the PSK to disk */
-	if (is_offload(netdev->handshake))
-		handshake_event(netdev->handshake,
-				HANDSHAKE_EVENT_SETTING_KEYS);
-
 	if (netdev->connect_cb) {
 		netdev->connect_cb(netdev, NETDEV_RESULT_OK, NULL,
 					netdev->user_data);
@@ -2012,14 +2009,6 @@ process_resp_ies:
 			netdev_send_qos_map_set(netdev, qos_set, qos_len);
 	}
 =

-	/*
-	 * TODO: Only SAE/WPA3-personal offload is supported. In this case IWD
-	 * is 'done'. In the case of 8021x offload EAP still needs to take
-	 * place, so this must be updated accordingly when that is implemented.
-	 */
-	if (is_offload(netdev->handshake))
-		goto done;
-
 	if (netdev->sm) {
 		/*
 		 * Start processing EAPoL frames now that the state machine
@@ -2031,7 +2020,11 @@ process_resp_ies:
 		return;
 	}
 =

-done:
+	/* Allow station to sync the PSK to disk */
+	if (is_offload(netdev->handshake))
+		handshake_event(netdev->handshake,
+				HANDSHAKE_EVENT_SETTING_KEYS);
+
 	netdev_connect_ok(netdev);
 =

 	return;
@@ -2663,6 +2656,9 @@ static struct l_genl_msg *netdev_build_cmd_connect(st=
ruct netdev *netdev,
 		l_genl_msg_append_attr(msg, NL80211_ATTR_SAE_PASSWORD,
 					strlen(hs->passphrase), hs->passphrase);
 		break;
+	case CONNECTION_TYPE_PSK_OFFLOAD:
+		l_genl_msg_append_attr(msg, NL80211_ATTR_PMK, 32, hs->pmk);
+		break;
 	}
 =

 	if (prev_bssid)
@@ -3036,15 +3032,19 @@ static int netdev_handshake_state_setup_connection_=
type(
 		return -ENOTSUP;
 =

 	switch (hs->akm_suite) {
+	case IE_RSN_AKM_SUITE_PSK:
+	case IE_RSN_AKM_SUITE_FT_USING_PSK:
+	case IE_RSN_AKM_SUITE_PSK_SHA256:
+		if (wiphy_has_ext_feature(wiphy,
+				NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_PSK))
+			goto psk_offload;
+		/* fall through */
 	case IE_RSN_AKM_SUITE_8021X:
 	case IE_RSN_AKM_SUITE_FT_OVER_8021X:
 	case IE_RSN_AKM_SUITE_8021X_SHA256:
 	case IE_RSN_AKM_SUITE_8021X_SUITE_B_SHA256:
 	case IE_RSN_AKM_SUITE_8021X_SUITE_B_SHA384:
 	case IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384:
-	case IE_RSN_AKM_SUITE_PSK:
-	case IE_RSN_AKM_SUITE_FT_USING_PSK:
-	case IE_RSN_AKM_SUITE_PSK_SHA256:
 		if (softmac)
 			goto softmac;
 =

@@ -3086,6 +3086,9 @@ fullmac:
 sae_offload:
 	nhs->type =3D CONNECTION_TYPE_SAE_OFFLOAD;
 	return 0;
+psk_offload:
+	nhs->type =3D CONNECTION_TYPE_PSK_OFFLOAD;
+	return 0;
 }
 =

 static int netdev_connect_common(struct netdev *netdev,
@@ -4126,6 +4129,11 @@ static bool netdev_get_fw_scan_cb(int err, struct l_=
queue *bss_list,
 =

 	handshake_state_set_authenticator_ie(netdev->handshake, bss->rsne);
 =

+	if (is_offload(netdev->handshake)) {
+		netdev_connect_ok(netdev);
+		return false;
+	}
+
 	if (netdev->sm) {
 		if (!eapol_start(netdev->sm))
 			goto failed;
@@ -4184,14 +4192,20 @@ static void netdev_roam_event(struct l_genl_msg *ms=
g, struct netdev *netdev)
 		goto failed;
 	}
 =

+	/* Handshake completed in firmware, just get the roamed BSS */
+	if (is_offload(netdev->handshake))
+		goto get_fw_scan;
+
 	/* Reset handshake state */
 	nhs->complete =3D false;
 	nhs->ptk_installed =3D false;
 	nhs->gtk_installed =3D true;
 	nhs->igtk_installed =3D true;
-	handshake_state_set_authenticator_address(netdev->handshake, mac);
 	netdev->handshake->ptk_complete =3D false;
 =

+get_fw_scan:
+	handshake_state_set_authenticator_address(netdev->handshake, mac);
+
 	if (!scan_get_firmware_scan(netdev->wdev_id, netdev_get_fw_scan_cb,
 					netdev, NULL))
 		goto failed;
-- =

2.26.2

--===============6764791917559049472==--

