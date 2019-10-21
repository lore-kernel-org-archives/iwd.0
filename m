Content-Type: multipart/mixed; boundary="===============4700593772383424161=="
MIME-Version: 1.0
From: Andrew Zaborowski <balrogg@gmail.com>
Subject: [PATCH 03/11] netdev: Extend checks for P2P scenarios
Date: Mon, 21 Oct 2019 15:55:02 +0200
Message-ID: <20191021135510.12657-3-balrogg@gmail.com>
In-Reply-To: <20191021135510.12657-1-balrogg@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4700593772383424161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Andrew Zaborowski <andrew.zaborowski@intel.com>

Extend the iftype-based checks to handle the P2P iftypes and remove a
warning that may be triggered in normal situations in the P2P scenarios.
---
 src/netdev.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 23fd980d..d9357a22 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1470,12 +1470,14 @@ void netdev_handshake_failed(struct handshake_state=
 *hs, uint16_t reason_code)
 =

 	switch (netdev->type) {
 	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_P2P_CLIENT:
 		msg =3D netdev_build_cmd_disconnect(netdev, reason_code);
 		netdev->disconnect_cmd_id =3D l_genl_family_send(nl80211, msg,
 							netdev_disconnect_cb,
 							netdev, NULL);
 		break;
 	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
 		msg =3D netdev_build_cmd_del_station(netdev, nhs->super.spa,
 				reason_code, false);
 		if (!l_genl_family_send(nl80211, msg, NULL, NULL, NULL))
@@ -2465,7 +2467,8 @@ int netdev_connect(struct netdev *netdev, struct scan=
_bss *bss,
 	struct eapol_sm *sm =3D NULL;
 	bool is_rsn =3D hs->supplicant_ie !=3D NULL;
 =

-	if (netdev->type !=3D NL80211_IFTYPE_STATION)
+	if (netdev->type !=3D NL80211_IFTYPE_STATION &&
+			netdev->type !=3D NL80211_IFTYPE_P2P_CLIENT)
 		return -ENOTSUP;
 =

 	if (netdev->connected)
@@ -2521,7 +2524,8 @@ int netdev_connect_wsc(struct netdev *netdev, struct =
scan_bss *bss,
 	size_t ie_len;
 	struct eapol_sm *sm;
 =

-	if (netdev->type !=3D NL80211_IFTYPE_STATION)
+	if (netdev->type !=3D NL80211_IFTYPE_STATION &&
+			netdev->type !=3D NL80211_IFTYPE_P2P_CLIENT)
 		return -ENOTSUP;
 =

 	if (netdev->connected)
@@ -2564,7 +2568,8 @@ int netdev_disconnect(struct netdev *netdev,
 {
 	struct l_genl_msg *disconnect;
 =

-	if (netdev->type !=3D NL80211_IFTYPE_STATION)
+	if (netdev->type !=3D NL80211_IFTYPE_STATION &&
+			netdev->type !=3D NL80211_IFTYPE_P2P_CLIENT)
 		return -ENOTSUP;
 =

 	if (!netdev->connected)
@@ -3441,10 +3446,8 @@ static void netdev_mlme_notify(struct l_genl_msg *ms=
g, void *user_data)
 		}
 	}
 =

-	if (!netdev) {
-		l_warn("MLME notification is missing ifindex attribute");
+	if (!netdev)
 		return;
-	}
 =

 	switch (cmd) {
 	case NL80211_CMD_AUTHENTICATE:
@@ -4395,6 +4398,11 @@ static void netdev_getlink_cb(int error, uint16_t ty=
pe, const void *data,
 =

 	netdev_newlink_notify(ifi, bytes);
 =

+	/* Don't do anything automatically for P2P interfaces */
+	if (netdev->type =3D=3D NL80211_IFTYPE_P2P_CLIENT ||
+			netdev->type =3D=3D NL80211_IFTYPE_P2P_GO)
+		return;
+
 	/*
 	 * If the interface is UP, reset it to ensure a clean state.
 	 * Otherwise, if we need to set a random mac, do so.  If not, just
-- =

2.20.1

--===============4700593772383424161==--

