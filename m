Content-Type: multipart/mixed; boundary="===============2767264251776389231=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/7] netdev: allow PSK offload for FT AKMs
Date: Tue, 30 Mar 2021 09:13:05 -0700
Message-ID: <20210330161307.732965-5-prestwoj@gmail.com>
In-Reply-To: <20210330161307.732965-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2767264251776389231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the handshake has offloading set, use ATTR_PMK (for WPA2)
which enables PSK offloading.

The CMD_ROAM event path was also modified to take into account
handshake offloading. If the handshake is offloaded we still
must issue GET_SCAN, but not start eapol since the firmware
takes care of this.
---
 src/netdev.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 914f6479..67a92e79 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2641,6 +2641,8 @@ static struct l_genl_msg *netdev_build_cmd_connect(st=
ruct netdev *netdev,
 		if (IE_AKM_IS_SAE(hs->akm_suite))
 			l_genl_msg_append_attr(msg, NL80211_ATTR_SAE_PASSWORD,
 					strlen(hs->passphrase), hs->passphrase);
+		else
+			l_genl_msg_append_attr(msg, NL80211_ATTR_PMK, 32, hs->pmk);
 	}
 =

 	if (prev_bssid)
@@ -4000,7 +4002,7 @@ static bool netdev_get_fw_scan_cb(int err, struct l_q=
ueue *bss_list,
 	 * In this case we should just ignore this and allow the disconnect
 	 * logic to continue.
 	 */
-	if (!netdev->sm)
+	if (!netdev->handshake->offload && !netdev->sm)
 		return false;
 =

 	if (err < 0) {
@@ -4028,6 +4030,11 @@ static bool netdev_get_fw_scan_cb(int err, struct l_=
queue *bss_list,
 =

 	handshake_state_set_authenticator_ie(netdev->handshake, bss->rsne);
 =

+	if (netdev->handshake->offload) {
+		netdev_connect_ok(netdev);
+		return false;
+	}
+
 	eapol_start(netdev->sm);
 =

 	return false;
@@ -4063,14 +4070,20 @@ static bool netdev_roam_event(struct l_genl_msg *ms=
g, struct netdev *netdev)
 		goto failed;
 	}
 =

+	/* Handshake completed in firmware, just get the roamed BSS */
+	if (netdev->handshake->offload)
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

--===============2767264251776389231==--

