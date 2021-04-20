Content-Type: multipart/mixed; boundary="===============6052851260497189350=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/8] netdev: Track SET_INTERFACE events
Date: Tue, 20 Apr 2021 11:35:12 -0500
Message-ID: <20210420163519.12375-1-denkenz@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6052851260497189350==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

And set the interface type based on the event rather than the command
callback.  This allows us to track interface type changes even if they
come from outside iwd (which shouldn't happen.)
---
 src/netdev.c | 47 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index a63c6b12a5d1..05e22148e495 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4867,6 +4867,43 @@ static int netdev_cqm_rssi_update(struct netdev *net=
dev)
 	return 0;
 }
 =

+static void netdev_set_interface_event(struct l_genl_msg *msg,
+							struct netdev *netdev)
+{
+	uint32_t iftype;
+
+	if (nl80211_parse_attrs(msg, NL80211_ATTR_IFTYPE, &iftype,
+					NL80211_ATTR_UNSPEC) < 0)
+		return;
+
+	if (iftype =3D=3D netdev->type)
+		return;
+
+	l_debug("Interface type changed from %s to %s",
+			netdev_iftype_to_string(netdev->type),
+			netdev_iftype_to_string(iftype));
+	netdev->type =3D iftype;
+
+	/* Set RSSI threshold for CQM notifications */
+	if (netdev->type =3D=3D NL80211_IFTYPE_STATION)
+		netdev_cqm_rssi_update(netdev);
+}
+
+static void netdev_config_notify(struct l_genl_msg *msg, void *user_data)
+{
+	struct netdev *netdev;
+
+	netdev =3D netdev_from_message(msg);
+	if (!netdev)
+		return;
+
+	switch (l_genl_msg_get_command(msg)) {
+	case NL80211_CMD_SET_INTERFACE:
+		netdev_set_interface_event(msg, netdev);
+		break;
+	}
+}
+
 static struct l_genl_msg *netdev_build_cmd_set_interface(struct netdev *ne=
tdev,
 							uint32_t iftype)
 {
@@ -4927,12 +4964,6 @@ static void netdev_set_iftype_cb(struct l_genl_msg *=
msg, void *user_data)
 	if (error !=3D 0)
 		goto done;
 =

-	netdev->type =3D req->pending_type;
-
-	/* Set RSSI threshold for CQM notifications */
-	if (netdev->type =3D=3D NL80211_IFTYPE_STATION)
-		netdev_cqm_rssi_update(netdev);
-
 	/* If the netdev was down originally, we're done */
 	if (!req->bring_up)
 		goto done;
@@ -5635,6 +5666,10 @@ static int netdev_init(void)
 								NULL, NULL))
 		l_error("Registering for scan notifications failed");
 =

+	if (!l_genl_family_register(nl80211, "config", netdev_config_notify,
+								NULL, NULL))
+		l_error("Registering for config notifications failed");
+
 	return 0;
 =

 fail_netlink:
-- =

2.26.3

--===============6052851260497189350==--

