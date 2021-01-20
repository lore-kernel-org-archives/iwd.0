Content-Type: multipart/mixed; boundary="===============6125103584464104368=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/8] netdev: add netdev_get_all_stations
Date: Wed, 20 Jan 2021 10:30:30 -0800
Message-ID: <20210120183036.477287-2-prestwoj@gmail.com>
In-Reply-To: <20210120183036.477287-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6125103584464104368==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a nl80211 dump version of netdev_get_station aimed at
AP mode. This will dump all stations, parse into
netdev_station_info structs, and call the callback for each
individual station found. Once the dump is completed the destroy
callback is called.
---
 src/netdev.c | 26 ++++++++++++++++++++++++++
 src/netdev.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 0fc0600a..e3ce270a 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4240,6 +4240,32 @@ int netdev_get_current_station(struct netdev *netdev,
 					user_data, destroy);
 }
 =

+int netdev_get_all_stations(struct netdev *netdev, netdev_get_station_cb_t=
 cb,
+				void *user_data, netdev_destroy_func_t destroy)
+{
+	struct l_genl_msg *msg;
+
+	if (netdev->get_station_cmd_id)
+		return -EBUSY;
+
+	msg =3D l_genl_msg_new_sized(NL80211_CMD_GET_STATION, 64);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
+
+	netdev->get_station_cmd_id =3D l_genl_family_dump(nl80211, msg,
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
 static int netdev_cqm_rssi_update(struct netdev *netdev)
 {
 	struct l_genl_msg *msg;
diff --git a/src/netdev.h b/src/netdev.h
index 074dc61f..e7a1c060 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -211,6 +211,8 @@ int netdev_get_station(struct netdev *netdev, const uin=
t8_t *mac,
 int netdev_get_current_station(struct netdev *netdev,
 			netdev_get_station_cb_t cb, void *user_data,
 			netdev_destroy_func_t destroy);
+int netdev_get_all_stations(struct netdev *netdev, netdev_get_station_cb_t=
 cb,
+				void *user_data, netdev_destroy_func_t destroy);
 =

 void netdev_handshake_failed(struct handshake_state *hs, uint16_t reason_c=
ode);
 =

-- =

2.26.2

--===============6125103584464104368==--

