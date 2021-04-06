Content-Type: multipart/mixed; boundary="===============2275525130750606405=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] netdev: use l_idle_create for disconnect idle
Date: Tue, 06 Apr 2021 09:58:26 -0700
Message-ID: <20210406165826.1082128-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2275525130750606405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The chances were extremely low, but using l_idle_oneshot
could end up causing a invalid memory access if the netdev
went down while waiting for the disconnect idle callback.

Instead netdev can keep track of the idle with l_idle_create
and remove it if the netdev goes down prior to the idle callback.
---
 src/netdev.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 7900df92..d8703ed2 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -148,6 +148,8 @@ struct netdev {
 	void *get_station_data;
 	netdev_destroy_func_t get_station_destroy;
 =

+	struct l_idle *disconnect_idle;
+
 	struct watchlist station_watches;
 =

 	struct l_io *pae_io;  /* for drivers without EAPoL over NL80211 */
@@ -811,6 +813,11 @@ static void netdev_free(void *data)
 	if (netdev->fw_roam_bss)
 		scan_bss_free(netdev->fw_roam_bss);
 =

+	if (netdev->disconnect_idle) {
+		l_idle_remove(netdev->disconnect_idle);
+		netdev->disconnect_idle =3D NULL;
+	}
+
 	if (netdev->events_ready)
 		WATCHLIST_NOTIFY(&netdev_watches, netdev_watch_func_t,
 					netdev, NETDEV_WATCH_EVENT_DEL);
@@ -3182,10 +3189,13 @@ build_cmd_connect:
 						event_filter, cb, user_data);
 }
 =

-static void disconnect_idle(void *user_data)
+static void disconnect_idle(struct l_idle *idle, void *user_data)
 {
 	struct netdev *netdev =3D user_data;
 =

+	l_idle_remove(idle);
+	netdev->disconnect_idle =3D NULL;
+
 	netdev->disconnect_cb(netdev, true, netdev->user_data);
 }
 =

@@ -3249,8 +3259,8 @@ int netdev_disconnect(struct netdev *netdev,
 	} else if (cb) {
 		netdev->disconnect_cb =3D cb;
 		netdev->user_data =3D user_data;
-
-		l_idle_oneshot(disconnect_idle, netdev, NULL);
+		netdev->disconnect_idle =3D l_idle_create(disconnect_idle,
+							netdev, NULL);
 	}
 =

 	return 0;
-- =

2.26.2

--===============2275525130750606405==--

