Content-Type: multipart/mixed; boundary="===============0292775596327096782=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] adhoc: set operstate on Start/Stop
Date: Fri, 30 Apr 2021 15:40:01 -0700
Message-ID: <20210430224001.294319-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0292775596327096782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Similar to 06aa84cca set the operstate when AdHoc is started and
stopped as it is no longer always set by netdev (only for station/p2p
interface types)
---
 src/adhoc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/adhoc.c b/src/adhoc.c
index 506e596a..7db405c5 100644
--- a/src/adhoc.c
+++ b/src/adhoc.c
@@ -494,6 +494,11 @@ static void adhoc_join_cb(struct netdev *netdev, int r=
esult, void *user_data)
 		return;
 	}
 =

+	l_rtnl_set_linkmode_and_operstate(iwd_get_rtnl(),
+					netdev_get_ifindex(adhoc->netdev),
+					IF_LINK_MODE_DEFAULT, IF_OPER_UP,
+					NULL, NULL, NULL);
+
 	adhoc->sta_watch_id =3D netdev_station_watch_add(netdev,
 			adhoc_station_changed_cb, adhoc);
 =

@@ -649,6 +654,11 @@ static struct l_dbus_message *adhoc_dbus_stop(struct l=
_dbus *dbus,
 	if (netdev_leave_adhoc(adhoc->netdev, adhoc_leave_cb, adhoc))
 		return dbus_error_failed(message);
 =

+	l_rtnl_set_linkmode_and_operstate(iwd_get_rtnl(),
+					netdev_get_ifindex(adhoc->netdev),
+					IF_LINK_MODE_DORMANT, IF_OPER_DOWN,
+					NULL, NULL, NULL);
+
 	adhoc->pending =3D l_dbus_message_ref(message);
 =

 	return NULL;
-- =

2.26.2

--===============0292775596327096782==--

