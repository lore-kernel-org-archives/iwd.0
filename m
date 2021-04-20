Content-Type: multipart/mixed; boundary="===============7041477088978533831=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/8] netdev: Re-add frame watches on iftype change
Date: Tue, 20 Apr 2021 11:35:14 -0500
Message-ID: <20210420163519.12375-3-denkenz@gmail.com>
In-Reply-To: <20210420163519.12375-1-denkenz@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7041477088978533831==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the iftype changes, kernel silently wipes out any frame registrations
we may have registered.  Right now, frame registrations are only done when
the interface is created.  This can result in frame watches not being
added if the interface type is changed between station mode to ap mode
and then back to station mode, e.g.:

device wlan0 set-property Mode ap
device wlan0 set-property Mode station

Make sure to re-add frame registrations according to the mode if the
interface type is changed.
---
 src/netdev.c | 80 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 33 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index f4877bbd6fbb..4208deea35fa 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4867,6 +4867,51 @@ static int netdev_cqm_rssi_update(struct netdev *net=
dev)
 	return 0;
 }
 =

+static void netdev_add_station_frame_watches(struct netdev *netdev)
+{
+	static const uint8_t action_neighbor_report_prefix[2] =3D { 0x05, 0x05 };
+	static const uint8_t action_sa_query_resp_prefix[2] =3D { 0x08, 0x01 };
+	static const uint8_t action_sa_query_req_prefix[2] =3D { 0x08, 0x00 };
+	static const uint8_t action_ft_response_prefix[] =3D  { 0x06, 0x02 };
+	static const uint8_t action_qos_map_prefix[] =3D { 0x01, 0x04 };
+	uint64_t wdev =3D netdev->wdev_id;
+
+	/* Subscribe to Management -> Action -> RM -> Neighbor Report frames */
+	frame_watch_add(wdev, 0, 0x00d0, action_neighbor_report_prefix,
+			sizeof(action_neighbor_report_prefix),
+			netdev_neighbor_report_frame_event, netdev, NULL);
+
+	frame_watch_add(wdev, 0, 0x00d0, action_sa_query_resp_prefix,
+			sizeof(action_sa_query_resp_prefix),
+			netdev_sa_query_resp_frame_event, netdev, NULL);
+
+	frame_watch_add(wdev, 0, 0x00d0, action_sa_query_req_prefix,
+			sizeof(action_sa_query_req_prefix),
+			netdev_sa_query_req_frame_event, netdev, NULL);
+
+	frame_watch_add(wdev, 0, 0x00d0, action_ft_response_prefix,
+			sizeof(action_ft_response_prefix),
+			netdev_ft_response_frame_event, netdev, NULL);
+
+	if (wiphy_supports_qos_set_map(netdev->wiphy))
+		frame_watch_add(wdev, 0, 0x00d0, action_qos_map_prefix,
+				sizeof(action_qos_map_prefix),
+				netdev_qos_map_frame_event, netdev, NULL);
+}
+
+static void netdev_setup_interface(struct netdev *netdev)
+{
+	switch (netdev->type) {
+	case NL80211_IFTYPE_STATION:
+		/* Set RSSI threshold for CQM notifications */
+		netdev_cqm_rssi_update(netdev);
+		netdev_add_station_frame_watches(netdev);
+		break;
+	default:
+		break;
+	}
+}
+
 static void netdev_set_interface_event(struct l_genl_msg *msg,
 							struct netdev *netdev)
 {
@@ -4887,9 +4932,7 @@ static void netdev_set_interface_event(struct l_genl_=
msg *msg,
 	netdev->type =3D iftype;
 	frame_watch_wdev_remove(wdev_id);
 =

-	/* Set RSSI threshold for CQM notifications */
-	if (netdev->type =3D=3D NL80211_IFTYPE_STATION)
-		netdev_cqm_rssi_update(netdev);
+	netdev_setup_interface(netdev);
 }
 =

 static void netdev_config_notify(struct l_genl_msg *msg, void *user_data)
@@ -5447,11 +5490,6 @@ struct netdev *netdev_create_from_genl(struct l_genl=
_msg *msg,
 	struct wiphy *wiphy =3D NULL;
 	struct ifinfomsg *rtmmsg;
 	size_t bufsize;
-	const uint8_t action_neighbor_report_prefix[2] =3D { 0x05, 0x05 };
-	const uint8_t action_sa_query_resp_prefix[2] =3D { 0x08, 0x01 };
-	const uint8_t action_sa_query_req_prefix[2] =3D { 0x08, 0x00 };
-	const uint8_t action_ft_response_prefix[] =3D  { 0x06, 0x02 };
-	const uint8_t action_qos_map_prefix[] =3D { 0x01, 0x04 };
 	struct l_io *pae_io =3D NULL;
 =

 	if (nl80211_parse_attrs(msg, NL80211_ATTR_IFINDEX, &ifindex,
@@ -5525,31 +5563,7 @@ struct netdev *netdev_create_from_genl(struct l_genl=
_msg *msg,
 =

 	l_free(rtmmsg);
 =

-	/* Subscribe to Management -> Action -> RM -> Neighbor Report frames */
-	frame_watch_add(wdev, 0, 0x00d0, action_neighbor_report_prefix,
-			sizeof(action_neighbor_report_prefix),
-			netdev_neighbor_report_frame_event, netdev, NULL);
-
-	frame_watch_add(wdev, 0, 0x00d0, action_sa_query_resp_prefix,
-			sizeof(action_sa_query_resp_prefix),
-			netdev_sa_query_resp_frame_event, netdev, NULL);
-
-	frame_watch_add(wdev, 0, 0x00d0, action_sa_query_req_prefix,
-			sizeof(action_sa_query_req_prefix),
-			netdev_sa_query_req_frame_event, netdev, NULL);
-
-	frame_watch_add(wdev, 0, 0x00d0, action_ft_response_prefix,
-			sizeof(action_ft_response_prefix),
-			netdev_ft_response_frame_event, netdev, NULL);
-
-	if (wiphy_supports_qos_set_map(netdev->wiphy))
-		frame_watch_add(wdev, 0, 0x00d0, action_qos_map_prefix,
-				sizeof(action_qos_map_prefix),
-				netdev_qos_map_frame_event, netdev, NULL);
-
-	/* Set RSSI threshold for CQM notifications */
-	if (netdev->type =3D=3D NL80211_IFTYPE_STATION)
-		netdev_cqm_rssi_update(netdev);
+	netdev_setup_interface(netdev);
 =

 	return netdev;
 }
-- =

2.26.3

--===============7041477088978533831==--

