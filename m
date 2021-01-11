Content-Type: multipart/mixed; boundary="===============4804789817845840336=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/8] netdev: update RSSI polling to use netdev_get_station
Date: Mon, 11 Jan 2021 09:12:34 -0800
Message-ID: <20210111171239.472372-3-prestwoj@gmail.com>
In-Reply-To: <20210111171239.472372-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4804789817845840336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netdev.c | 61 +++++++++-------------------------------------------
 1 file changed, 10 insertions(+), 51 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 3cda1c48..1e54acec 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -124,7 +124,6 @@ struct netdev {
 	uint8_t cur_rssi_level_idx;
 	int8_t cur_rssi;
 	struct l_timeout *rssi_poll_timeout;
-	uint32_t rssi_poll_cmd_id;
 	uint8_t set_mac_once[6];
 =

 	uint32_t set_powered_cmd_id;
@@ -379,47 +378,16 @@ static void netdev_set_rssi_level_idx(struct netdev *=
netdev)
 	netdev->cur_rssi_level_idx =3D new_level;
 }
 =

-static void netdev_rssi_poll_cb(struct l_genl_msg *msg, void *user_data)
+static void netdev_rssi_poll_cb(struct netdev *netdev,
+				struct netdev_station_info *info,
+				void *user_data)
 {
-	struct netdev *netdev =3D user_data;
-	struct l_genl_attr attr, nested;
-	uint16_t type, len;
-	const void *data;
-	bool found;
 	uint8_t prev_rssi_level_idx =3D netdev->cur_rssi_level_idx;
 =

-	netdev->rssi_poll_cmd_id =3D 0;
-
-	if (!l_genl_attr_init(&attr, msg))
-		goto done;
-
-	found =3D false;
-	while (l_genl_attr_next(&attr, &type, &len, &data)) {
-		if (type !=3D NL80211_ATTR_STA_INFO)
-			continue;
-
-		found =3D true;
-		break;
-	}
-
-	if (!found || !l_genl_attr_recurse(&attr, &nested))
+	if (!info)
 		goto done;
 =

-	found =3D false;
-	while (l_genl_attr_next(&nested, &type, &len, &data)) {
-		if (type !=3D NL80211_STA_INFO_SIGNAL_AVG)
-			continue;
-
-		if (len !=3D 1)
-			continue;
-
-		found =3D true;
-		netdev->cur_rssi =3D *(const int8_t *) data;
-		break;
-	}
-
-	if (!found)
-		goto done;
+	netdev->cur_rssi =3D  info->cur_rssi;
 =

 	/*
 	 * Note we don't have to handle LOW_SIGNAL_THRESHOLD here.  The
@@ -441,16 +409,12 @@ done:
 static void netdev_rssi_poll(struct l_timeout *timeout, void *user_data)
 {
 	struct netdev *netdev =3D user_data;
-	struct l_genl_msg *msg;
-
-	msg =3D l_genl_msg_new_sized(NL80211_CMD_GET_STATION, 64);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN,
-							netdev->handshake->aa);
 =

-	netdev->rssi_poll_cmd_id =3D l_genl_family_send(nl80211, msg,
-							netdev_rssi_poll_cb,
-							netdev, NULL);
+	if (netdev_get_station(netdev, netdev->handshake->aa,
+				netdev_rssi_poll_cb, NULL, NULL) < 0) {
+		/* Some problem occurred, rearm timer and try again */
+		l_timeout_modify(netdev->rssi_poll_timeout, 6);
+	}
 }
 =

 /* To be called whenever operational or rssi_levels_num are updated */
@@ -472,11 +436,6 @@ static void netdev_rssi_polling_update(struct netdev *=
netdev)
 =

 		l_timeout_remove(netdev->rssi_poll_timeout);
 		netdev->rssi_poll_timeout =3D NULL;
-
-		if (netdev->rssi_poll_cmd_id) {
-			l_genl_family_cancel(nl80211, netdev->rssi_poll_cmd_id);
-			netdev->rssi_poll_cmd_id =3D 0;
-		}
 	}
 }
 =

-- =

2.26.2

--===============4804789817845840336==--

