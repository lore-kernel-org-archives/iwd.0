Content-Type: multipart/mixed; boundary="===============7595544108334222443=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] netdev: always register for single CQM threshold
Date: Tue, 09 Feb 2021 16:04:47 -0800
Message-ID: <20210210000447.775876-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7595544108334222443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the extended feature for CQM levels was not supported no CQM
registration would happen, not even for a single level. This
caused IWD to completely lose the ability to roam since it would
only get notified when the kernel was disconnecting, around -90
dBm, not giving IWD enough time to roam.

Instead if the extended feature is not supported we can still
register for the event, just without multiple signal levels.
---
 src/netdev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 7a10bf0e..1f2aa51c 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4427,9 +4427,10 @@ static int netdev_cqm_rssi_update(struct netdev *net=
dev)
 =

 	if (!wiphy_has_ext_feature(netdev->wiphy,
 					NL80211_EXT_FEATURE_CQM_RSSI_LIST))
-		return 0;
-
-	msg =3D netdev_build_cmd_cqm_rssi_update(netdev, netdev->rssi_levels,
+		msg =3D netdev_build_cmd_cqm_rssi_update(netdev, NULL, 0);
+	else
+		msg =3D netdev_build_cmd_cqm_rssi_update(netdev,
+						netdev->rssi_levels,
 						netdev->rssi_levels_num);
 	if (!msg)
 		return -EINVAL;
-- =

2.26.2

--===============7595544108334222443==--

