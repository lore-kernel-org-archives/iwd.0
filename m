Content-Type: multipart/mixed; boundary="===============0513193153564189933=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/6] adhoc: delay setting setting Started
Date: Mon, 14 Sep 2020 14:04:04 -0700
Message-ID: <20200914210407.428918-4-prestwoj@gmail.com>
In-Reply-To: <20200914210407.428918-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0513193153564189933==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Started property was being set in the Join IBSS callback which
isn't really when the IBSS has been started. The kernel automatically
scans for IBSS networks which takes some time. Its better to wait
on setting Started until we get the Join IBSS event.
---
 src/adhoc.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/src/adhoc.c b/src/adhoc.c
index 9f3b32e7..7f9ce765 100644
--- a/src/adhoc.c
+++ b/src/adhoc.c
@@ -52,6 +52,7 @@ struct adhoc_state {
 	struct l_queue *sta_states;
 	uint32_t sta_watch_id;
 	uint32_t netdev_watch_id;
+	unsigned int mlme_watch;
 	struct l_dbus_message *pending;
 	uint32_t ciphers;
 	uint32_t group_cipher;
@@ -137,6 +138,7 @@ static void adhoc_reset(struct adhoc_state *adhoc)
 	adhoc->ssid =3D NULL;
 =

 	netdev_station_watch_remove(adhoc->netdev, adhoc->sta_watch_id);
+	adhoc->sta_watch_id =3D 0;
 =

 	l_queue_destroy(adhoc->sta_states, adhoc_sta_free);
 	adhoc->sta_states =3D NULL;
@@ -145,6 +147,9 @@ static void adhoc_reset(struct adhoc_state *adhoc)
 =

 	l_dbus_property_changed(dbus_get_bus(), netdev_get_path(adhoc->netdev),
 						IWD_ADHOC_INTERFACE, "Started");
+
+	if (adhoc->mlme_watch)
+		l_genl_family_unregister(adhoc->nl80211, adhoc->mlme_watch);
 }
 =

 static void adhoc_set_rsn_info(struct adhoc_state *adhoc,
@@ -493,11 +498,35 @@ static void adhoc_join_cb(struct netdev *netdev, int =
result, void *user_data)
 =

 	reply =3D l_dbus_message_new_method_return(adhoc->pending);
 	dbus_pending_reply(&adhoc->pending, reply);
+}
 =

-	adhoc->started =3D true;
+static void adhoc_mlme_notify(struct l_genl_msg *msg, void *user_data)
+{
+	struct adhoc_state *adhoc =3D user_data;
+	uint32_t ifindex;
 =

-	l_dbus_property_changed(dbus_get_bus(), netdev_get_path(adhoc->netdev),
+	if (nl80211_parse_attrs(msg, NL80211_ATTR_IFINDEX, &ifindex,
+				NL80211_ATTR_UNSPEC) < 0 ||
+			ifindex !=3D netdev_get_ifindex(adhoc->netdev))
+		return;
+
+	switch (l_genl_msg_get_command(msg)) {
+	case NL80211_CMD_JOIN_IBSS:
+		/*
+		 * if watch is set the join_ibss_cb has come back. This event
+		 * will come in for each new STA joining the IBSS so we only
+		 * want to set it once
+		 */
+		if (adhoc->sta_watch_id && !adhoc->started) {
+			adhoc->started =3D true;
+
+			l_dbus_property_changed(dbus_get_bus(),
+						netdev_get_path(adhoc->netdev),
 						IWD_ADHOC_INTERFACE, "Started");
+		}
+
+		break;
+	}
 }
 =

 static struct l_dbus_message *adhoc_dbus_start(struct l_dbus *dbus,
@@ -538,6 +567,11 @@ static struct l_dbus_message *adhoc_dbus_start(struct =
l_dbus *dbus,
 			adhoc))
 		return dbus_error_invalid_args(message);
 =

+	adhoc->mlme_watch =3D l_genl_family_register(adhoc->nl80211, "mlme",
+						adhoc_mlme_notify, adhoc, NULL);
+	if (!adhoc->mlme_watch)
+		return dbus_error_failed(message);
+
 	return NULL;
 }
 =

@@ -573,6 +607,11 @@ static struct l_dbus_message *adhoc_dbus_start_open(st=
ruct l_dbus *dbus,
 			adhoc))
 		return dbus_error_invalid_args(message);
 =

+	adhoc->mlme_watch =3D l_genl_family_register(adhoc->nl80211, "mlme",
+						adhoc_mlme_notify, adhoc, NULL);
+	if (!adhoc->mlme_watch)
+		return dbus_error_failed(message);
+
 	return NULL;
 }
 =

-- =

2.26.2

--===============0513193153564189933==--

