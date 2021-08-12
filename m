Content-Type: multipart/mixed; boundary="===============8091980863540904807=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/7] station: disable autoconnect when in developer mode
Date: Thu, 12 Aug 2021 13:38:07 -0700
Message-ID: <20210812203812.738060-2-prestwoj@gmail.com>
In-Reply-To: <20210812203812.738060-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8091980863540904807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Most autotests do not want autoconnect behavior so it is being
turned off by default. There are a few tests where it is needed
and in these few cases the test can enable autoconnect through
the new station debug property.
---
 src/station.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/station.c b/src/station.c
index f9b2b16d..2155aa3c 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3507,6 +3507,7 @@ static struct station *station_create(struct netdev *=
netdev)
 {
 	struct station *station;
 	struct l_dbus *dbus =3D dbus_get_bus();
+	bool autoconnect =3D true;
 =

 	station =3D l_new(struct station, 1);
 	watchlist_init(&station->state_watches, NULL);
@@ -3524,8 +3525,6 @@ static struct station *station_create(struct netdev *=
netdev)
 =

 	l_queue_push_head(station_list, station);
 =

-	station_set_autoconnect(station, true);
-
 	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
 					IWD_STATION_INTERFACE, station);
 =

@@ -3536,11 +3535,15 @@ static struct station *station_create(struct netdev=
 *netdev)
 =

 	station_fill_scan_freq_subsets(station);
 =

-	if (iwd_is_developer_mode())
+	if (iwd_is_developer_mode()) {
 		l_dbus_object_add_interface(dbus,
 					netdev_get_path(station->netdev),
 					IWD_STATION_DEBUG_INTERFACE,
 					station);
+		autoconnect =3D false;
+	}
+
+	station_set_autoconnect(station, autoconnect);
 =

 	return station;
 }
-- =

2.31.1

--===============8091980863540904807==--

