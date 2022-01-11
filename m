Content-Type: multipart/mixed; boundary="===============8557439894689749063=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 4/6] netdev: use work priorities rather than hard coding
Date: Tue, 11 Jan 2022 09:45:12 -0800
Message-ID: <20220111174514.1074967-4-prestwoj@gmail.com>
In-Reply-To: 20220111174514.1074967-1-prestwoj@gmail.com

--===============8557439894689749063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netdev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 78467d3e..2d49b1f8 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4040,8 +4040,8 @@ build_cmd_connect:
 					NL80211_EXT_FEATURE_CAN_REPLACE_PTK0))
 		handshake_state_set_no_rekey(hs, true);
 =

-	wiphy_radio_work_insert(netdev->wiphy, &netdev->work, 1,
-				&connect_work_ops);
+	wiphy_radio_work_insert(netdev->wiphy, &netdev->work,
+				WIPHY_WORK_PRIORITY_CONNECT, &connect_work_ops);
 }
 =

 int netdev_connect(struct netdev *netdev, struct scan_bss *bss,
@@ -4620,8 +4620,8 @@ int netdev_fast_transition(struct netdev *netdev,
 					netdev_get_oci, netdev);
 	memcpy(netdev->ap->prev_bssid, orig_bss->addr, ETH_ALEN);
 =

-	wiphy_radio_work_insert(netdev->wiphy, &netdev->work, 1,
-				&ft_work_ops);
+	wiphy_radio_work_insert(netdev->wiphy, &netdev->work,
+				WIPHY_WORK_PRIORITY_CONNECT, &ft_work_ops);
 =

 	return 0;
 }
@@ -4661,8 +4661,8 @@ int netdev_fast_transition_over_ds(struct netdev *net=
dev,
 					netdev);
 	memcpy(netdev->ap->prev_bssid, orig_bss->addr, ETH_ALEN);
 =

-	wiphy_radio_work_insert(netdev->wiphy, &netdev->work, 1,
-				&ft_work_ops);
+	wiphy_radio_work_insert(netdev->wiphy, &netdev->work,
+				WIPHY_WORK_PRIORITY_CONNECT, &ft_work_ops);
 =

 	return 0;
 }
-- =

2.31.1

--===============8557439894689749063==--

