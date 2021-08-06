Content-Type: multipart/mixed; boundary="===============2253899424321664673=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/5] netdev: move flag setting in netdev_reassociate
Date: Fri, 06 Aug 2021 16:02:08 -0700
Message-ID: <20210806230212.381657-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2253899424321664673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the real world setting the flags prior to netdev_connect_common
should never cause a problem, but using the developer Roam()
command will because it forces a roam to occur with no roam scan.
This ends up running the connect work item immediately which sets
netdev->connected=3Dtrue, then netdev_reassociate ends
up setting it false again right after.

To handle both ways of roaming set the flags prior to
netdev_connect_common and if it does fail reset them back to
their original values.
---
 src/netdev.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 74eb349c..e9b4a42c 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3611,19 +3611,19 @@ int netdev_reassociate(struct netdev *netdev, struc=
t scan_bss *target_bss,
 	old_sm =3D netdev->sm;
 	old_hs =3D netdev->handshake;
 =

+	netdev->associated =3D false;
+	netdev->operational =3D false;
+	netdev->connected =3D false;
+	netdev->in_reassoc =3D true;
+
 	ret =3D netdev_connect_common(netdev, target_bss, orig_bss, hs, NULL, 0,
 					event_filter, cb, user_data);
 	if (ret < 0)
-		return ret;
+		goto reset_flags;
 =

 	if (netdev->ap)
 		memcpy(netdev->ap->prev_bssid, orig_bss->addr, ETH_ALEN);
 =

-	netdev->associated =3D false;
-	netdev->operational =3D false;
-	netdev->connected =3D false;
-	netdev->in_reassoc =3D true;
-
 	netdev_rssi_polling_update(netdev);
 =

 	if (old_sm)
@@ -3633,6 +3633,14 @@ int netdev_reassociate(struct netdev *netdev, struct=
 scan_bss *target_bss,
 		handshake_state_free(old_hs);
 =

 	return 0;
+
+reset_flags:
+	netdev->associated =3D true;
+	netdev->operational =3D true;
+	netdev->connected =3D true;
+	netdev->in_reassoc =3D false;
+
+	return ret;
 }
 =

 static void netdev_join_adhoc_cb(struct l_genl_msg *msg, void *user_data)
-- =

2.31.1

--===============2253899424321664673==--

