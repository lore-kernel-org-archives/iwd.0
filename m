Content-Type: multipart/mixed; boundary="===============5466223430568670064=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] netdev: remove handling of beacon loss event
Date: Tue, 03 Nov 2020 12:51:28 -0800
Message-ID: <20201103205129.2744888-2-prestwoj@gmail.com>
In-Reply-To: <20201103205129.2744888-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5466223430568670064==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netdev.c | 14 --------------
 src/netdev.h |  2 --
 2 files changed, 16 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 5d3aa862..3f78afbf 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -671,16 +671,6 @@ struct netdev *netdev_find(int ifindex)
 	return l_queue_find(netdev_list, netdev_match, L_UINT_TO_PTR(ifindex));
 }
 =

-static void netdev_lost_beacon(struct netdev *netdev)
-{
-	if (!netdev->connected)
-		return;
-
-	if (netdev->event_filter)
-		netdev->event_filter(netdev, NETDEV_EVENT_LOST_BEACON, NULL,
-							netdev->user_data);
-}
-
 /* Threshold RSSI for roaming to trigger, configurable in main.conf */
 static int LOW_SIGNAL_THRESHOLD;
 =

@@ -771,10 +761,6 @@ static void netdev_cqm_event(struct l_genl_msg *msg, s=
truct netdev *netdev)
 =

 			while (l_genl_attr_next(&nested, &type, &len, &data)) {
 				switch (type) {
-				case NL80211_ATTR_CQM_BEACON_LOSS_EVENT:
-					netdev_lost_beacon(netdev);
-					break;
-
 				case NL80211_ATTR_CQM_RSSI_THRESHOLD_EVENT:
 					if (len !=3D 4)
 						continue;
diff --git a/src/netdev.h b/src/netdev.h
index 58b63fbd..65fdbaaf 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -40,7 +40,6 @@ enum netdev_result {
 enum netdev_event {
 	NETDEV_EVENT_AUTHENTICATING,
 	NETDEV_EVENT_ASSOCIATING,
-	NETDEV_EVENT_LOST_BEACON,
 	NETDEV_EVENT_DISCONNECT_BY_AP,
 	NETDEV_EVENT_DISCONNECT_BY_SME,
 	NETDEV_EVENT_RSSI_THRESHOLD_LOW,
@@ -89,7 +88,6 @@ typedef void (*netdev_connect_cb_t)(struct netdev *netdev,
  *
  * NETDEV_EVENT_AUTHENTICATING - unused
  * NETDEV_EVENT_ASSOCIATING - unused
- * NETDEV_EVENT_LOST_BEACON - unused
  * NETDEV_EVENT_DISCONNECT_BY_AP - MMPDU_REASON_CODE
  * NETDEV_EVENT_DISCONNECT_BY_SME - MMPDU_REASON_CODE
  * NETDEV_EVENT_RSSI_THRESHOLD_LOW - unused
-- =

2.26.2

--===============5466223430568670064==--

