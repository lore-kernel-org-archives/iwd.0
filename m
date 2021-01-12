Content-Type: multipart/mixed; boundary="===============9080648364147435225=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/8] netdev: add netdev_get_station/current_station
Date: Tue, 12 Jan 2021 09:17:17 -0800
Message-ID: <20210112171723.3025-2-prestwoj@gmail.com>
In-Reply-To: <20210112171723.3025-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9080648364147435225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds a generalized API for GET_STATION. This API handles
calling and parsing the results into a new structure,
netdev_station_info. This results structure will hold any
data needed by consumers of netdev_get_station. A helper API
(netdev_get_current_station) was added as a convenience which
automatically passes handshake->aa as the MAC.

For now only the RSSI is parsed as this is already being
done for RSSI polling/events. Looking further more info will
be added such as rx/tx rates and estimated throughput.
---
 src/netdev.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/netdev.h |  17 +++++++
 2 files changed, 139 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 3f78afbf..879bd275 100644
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
@@ -363,6 +368,28 @@ int netdev_set_powered(struct netdev *netdev, bool pow=
ered,
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
+			info->have_cur_rssi =3D true;
+
+			break;
+		}
+	}
+
+	return true;
+}
+
 static void netdev_set_rssi_level_idx(struct netdev *netdev)
 {
 	uint8_t new_level;
@@ -636,6 +663,11 @@ static void netdev_free(void *data)
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
@@ -4022,6 +4054,96 @@ done:
 	return 0;
 }
 =

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
+
+		case NL80211_ATTR_MAC:
+			if (len !=3D 6)
+				goto parse_error;
+
+			memcpy(info.addr, data, 6);
+
+			break;
+		}
+	}
+
+	if (netdev->get_station_cb)
+		netdev->get_station_cb(&info, netdev->get_station_data);
+
+	return;
+
+parse_error:
+	if (netdev->get_station_cb)
+		netdev->get_station_cb(NULL, netdev->get_station_data);
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
+	if (!netdev->get_station_cmd_id) {
+		l_genl_msg_unref(msg);
+		return -EIO;
+	}
+
+	netdev->get_station_cb =3D cb;
+	netdev->get_station_data =3D user_data;
+	netdev->get_station_destroy =3D destroy;
+
+	return 0;
+}
+
+int netdev_get_current_station(struct netdev *netdev,
+			netdev_get_station_cb_t cb, void *user_data,
+			netdev_destroy_func_t destroy)
+{
+	return netdev_get_station(netdev, netdev->handshake->aa, cb,
+					user_data, destroy);
+}
+
 static int netdev_cqm_rssi_update(struct netdev *netdev)
 {
 	struct l_genl_msg *msg;
diff --git a/src/netdev.h b/src/netdev.h
index 65fdbaaf..e4a6eee3 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -114,6 +114,16 @@ typedef void (*netdev_station_watch_func_t)(struct net=
dev *netdev,
 					const uint8_t *mac, bool added,
 					void *user_data);
 =

+struct netdev_station_info {
+	uint8_t addr[6];
+	int8_t cur_rssi;
+
+	bool have_cur_rssi : 1;
+};
+
+typedef void (*netdev_get_station_cb_t)(struct netdev_station_info *info,
+					void *user_data);
+
 struct wiphy *netdev_get_wiphy(struct netdev *netdev);
 const uint8_t *netdev_get_address(struct netdev *netdev);
 uint32_t netdev_get_ifindex(struct netdev *netdev);
@@ -174,6 +184,13 @@ int netdev_neighbor_report_req(struct netdev *netdev,
 int netdev_set_rssi_report_levels(struct netdev *netdev, const int8_t *lev=
els,
 					size_t levels_num);
 =

+int netdev_get_station(struct netdev *netdev, const uint8_t *mac,
+			netdev_get_station_cb_t cb, void *user_data,
+			netdev_destroy_func_t destroy);
+int netdev_get_current_station(struct netdev *netdev,
+			netdev_get_station_cb_t cb, void *user_data,
+			netdev_destroy_func_t destroy);
+
 void netdev_handshake_failed(struct handshake_state *hs, uint16_t reason_c=
ode);
 =

 struct netdev *netdev_find(int ifindex);
-- =

2.26.2

--===============9080648364147435225==--

