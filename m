Content-Type: multipart/mixed; boundary="===============8959565943548607669=="
MIME-Version: 1.0
From: Jesse Lentz <jesse at twosheds.org>
To: iwd at lists.01.org
Subject: [PATCH] netdev: Initialize signal level during connection attempt
Date: Mon, 23 May 2022 00:28:43 -0400
Message-ID: <20220523042843.14058-1-jesse@twosheds.org>

--===============8959565943548607669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The call to netdev_rssi_level_init() in netdev_connect_common() is
currently a no-op, because netdev->connected has not yet been set at
this stage of the connection attempt. Because netdev_rssi_level_init()
is only used twice, it's been replaced by two inlined calls to
netdev_set_rssi_level_idx().
---
 src/netdev.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 8b2143fd..ece2aab3 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1025,12 +1025,6 @@ static void netdev_cqm_event_rssi_threshold(struct n=
etdev *netdev,
 	netdev->event_filter(netdev, event, NULL, netdev->user_data);
 }
 =

-static void netdev_rssi_level_init(struct netdev *netdev)
-{
-	if (netdev->connected && netdev->rssi_levels_num)
-		netdev_set_rssi_level_idx(netdev);
-}
-
 static void netdev_cqm_event_rssi_value(struct netdev *netdev, int rssi_va=
l)
 {
 	bool new_rssi_low;
@@ -4043,7 +4037,10 @@ build_cmd_connect:
 	netdev->handshake =3D hs;
 	netdev->sm =3D sm;
 	netdev->cur_rssi =3D bss->signal_strength / 100;
-	netdev_rssi_level_init(netdev);
+
+	if (netdev->rssi_levels_num)
+		netdev_set_rssi_level_idx(netdev);
+
 	netdev_cqm_rssi_update(netdev);
 =

 	if (!wiphy_has_ext_feature(netdev->wiphy,
@@ -5651,11 +5648,14 @@ int netdev_set_rssi_report_levels(struct netdev *ne=
tdev, const int8_t *levels,
 	}
 =

 done:
-	if (levels_num)
+	netdev->rssi_levels_num =3D levels_num;
+
+	if (levels_num) {
 		memcpy(netdev->rssi_levels, levels, levels_num);
 =

-	netdev->rssi_levels_num =3D levels_num;
-	netdev_rssi_level_init(netdev);
+		if (netdev->connected)
+			netdev_set_rssi_level_idx(netdev);
+	}
 =

 	netdev_rssi_polling_update(netdev);
 =

-- =

2.36.0

--===============8959565943548607669==--

