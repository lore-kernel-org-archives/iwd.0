Content-Type: multipart/mixed; boundary="===============5947493880029371833=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/8] netdev: add netdev_get_station
Date: Mon, 11 Jan 2021 09:12:33 -0800
Message-ID: <20210111171239.472372-2-prestwoj@gmail.com>
In-Reply-To: <20210111171239.472372-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5947493880029371833==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds a generalized API for GET_STATION. This API handles
calling and parsing the results into a new structure,
netdev_station_info. This results structure will hold any
data needed by consumers of netdev_get_station.

For now only the RSSI is parsed as this is already being
done for RSSI polling/events. Looking further more info will
be added such as rx/tx rates and estimated throughput.
---
 src/netdev.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/netdev.h |  12 ++++++
 2 files changed, 115 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 3f78afbf..3cda1c48 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -132,6 +132,11 @@ struct netdev {
 	void *set_powered_user_data;
 	netdev_destroy_func_t set_powered_destroy;
 =

+	uint32_t get_station_cmd_id;
+	netdev_get_station_cb_t get_station_cb;
+	void *get_station_data;
+	netdev_destroy_func_t get_station_destroy;
+
 	struct watchlist station_watches;
 =

 	struct l_io *pae_io;  /* for drivers without EAPoL over NL80211 */
@@ -636,6 +641,11 @@ static void netdev_free(void *data)
 		netdev->mac_change_cmd_id =3D 0;
 	}
 =

+	if (netdev->get_station_cmd_id) {
+		l_genl_family_cancel(nl80211, netdev->get_station_cmd_id);
+		netdev->get_station_cmd_id =3D 0;
+	}
+
 	if (netdev->events_ready)
 		WATCHLIST_NOTIFY(&netdev_watches, netdev_watch_func_t,
 					netdev, NETDEV_WATCH_EVENT_DEL);
@@ -4022,6 +4032,99 @@ done:
 	return 0;
 }
 =

+static bool netdev_parse_sta_info(struct l_genl_attr *attr,
+					struct netdev_station_info *info)
+{
+	uint16_t type, len;
+	const void *data;
+
+	while (l_genl_attr_next(attr, &type, &len, &data)) {
+		switch (type) {
+		case NL80211_STA_INFO_SIGNAL_AVG:
+			if (len !=3D 1)
+				return false;
+
+			info->cur_rssi =3D *(const int8_t *) data;
+
+			break;
+		}
+	}
+
+	return true;
+}
+
+static void netdev_get_station_cb(struct l_genl_msg *msg, void *user_data)
+{
+	struct netdev *netdev =3D user_data;
+	struct l_genl_attr attr, nested;
+	uint16_t type, len;
+	const void *data;
+	struct netdev_station_info info;
+
+	netdev->get_station_cmd_id =3D 0;
+
+	if (!l_genl_attr_init(&attr, msg))
+		goto parse_error;
+
+	while (l_genl_attr_next(&attr, &type, &len, &data)) {
+		switch (type) {
+		case NL80211_ATTR_STA_INFO:
+			if (!l_genl_attr_recurse(&attr, &nested))
+				goto parse_error;
+
+			if (!netdev_parse_sta_info(&nested, &info))
+				goto parse_error;
+
+			break;
+		}
+	}
+
+	if (netdev->get_station_cb)
+		netdev->get_station_cb(netdev, &info, netdev->get_station_data);
+
+	return;
+
+parse_error:
+	if (netdev->get_station_cb)
+		netdev->get_station_cb(netdev, NULL, netdev->get_station_data);
+}
+
+static void netdev_get_station_destroy(void *user_data)
+{
+	struct netdev *netdev =3D user_data;
+
+	netdev->get_station_cmd_id =3D 0;
+
+	if (netdev->get_station_destroy)
+		netdev->get_station_destroy(netdev->get_station_data);
+}
+
+int netdev_get_station(struct netdev *netdev, const uint8_t *mac,
+			netdev_get_station_cb_t cb, void *user_data,
+			netdev_destroy_func_t destroy)
+{
+	struct l_genl_msg *msg;
+
+	if (netdev->get_station_cmd_id)
+		return -EBUSY;
+
+	msg =3D l_genl_msg_new_sized(NL80211_CMD_GET_STATION, 64);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, mac);
+
+	netdev->get_station_cmd_id =3D l_genl_family_send(nl80211, msg,
+						netdev_get_station_cb, netdev,
+						netdev_get_station_destroy);
+	if (!netdev->get_station_cmd_id)
+		return -EIO;
+
+	netdev->get_station_cb =3D cb;
+	netdev->get_station_data =3D user_data;
+	netdev->get_station_destroy =3D destroy;
+
+	return 0;
+}
+
 static int netdev_cqm_rssi_update(struct netdev *netdev)
 {
 	struct l_genl_msg *msg;
diff --git a/src/netdev.h b/src/netdev.h
index 65fdbaaf..5cf38076 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -114,6 +114,14 @@ typedef void (*netdev_station_watch_func_t)(struct net=
dev *netdev,
 					const uint8_t *mac, bool added,
 					void *user_data);
 =

+struct netdev_station_info {
+	int8_t cur_rssi;
+};
+
+typedef void (*netdev_get_station_cb_t)(struct netdev *netdev,
+					struct netdev_station_info *info,
+					void *user_data);
+
 struct wiphy *netdev_get_wiphy(struct netdev *netdev);
 const uint8_t *netdev_get_address(struct netdev *netdev);
 uint32_t netdev_get_ifindex(struct netdev *netdev);
@@ -174,6 +182,10 @@ int netdev_neighbor_report_req(struct netdev *netdev,
 int netdev_set_rssi_report_levels(struct netdev *netdev, const int8_t *lev=
els,
 					size_t levels_num);
 =

+int netdev_get_station(struct netdev *netdev, const uint8_t *mac,
+			netdev_get_station_cb_t cb, void *user_data,
+			netdev_destroy_func_t destroy);
+
 void netdev_handshake_failed(struct handshake_state *hs, uint16_t reason_c=
ode);
 =

 struct netdev *netdev_find(int ifindex);
-- =

2.26.2

--===============5947493880029371833==--

