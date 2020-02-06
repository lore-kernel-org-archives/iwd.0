Content-Type: multipart/mixed; boundary="===============1354956040677492795=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH] client: Fix missing Connected Network display
Date: Thu, 06 Feb 2020 08:51:58 -0800
Message-ID: <20200206165158.19014-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1354956040677492795==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The connected network wasn=E2=80=99t displayed correctly within Station
object when connection was created before the start of iwctl
due to object dependency and timing of the sequential parsing of
the Object Manager=E2=80=99s objects. The issue is corrected by storing
the network path and doing lookups of the network proxy objects
at the time of display.
---
 client/station.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/client/station.c b/client/station.c
index b6b59239..86e18f06 100644
--- a/client/station.c
+++ b/client/station.c
@@ -35,7 +35,7 @@
 struct station {
 	bool scanning;
 	char *state;
-	const struct proxy_interface *connected_network;
+	char *connected_network;
 };
 =

 static void *station_create(void)
@@ -48,7 +48,7 @@ static void station_destroy(void *data)
 	struct station *station =3D data;
 =

 	l_free(station->state);
-	station->connected_network =3D NULL;
+	l_free(station->connected_network);
 =

 	l_free(station);
 }
@@ -106,14 +106,15 @@ static void update_connected_network(void *data,
 	struct station *station =3D data;
 	const char *path;
 =

+	l_free(station->connected_network);
+
 	if (!l_dbus_message_iter_get_variant(variant, "o", &path)) {
 		station->connected_network =3D NULL;
 =

 		return;
 	}
 =

-	station->connected_network =3D proxy_interface_find(IWD_NETWORK_INTERFACE,
-									path);
+	station->connected_network =3D l_strdup(path);
 }
 =

 static const struct proxy_interface_property station_properties[] =3D {
@@ -145,10 +146,16 @@ static void display_station(const char *device_name,
 	proxy_properties_display(proxy, caption, MARGIN, 20, 47);
 	l_free(caption);
 =

-	if (station->connected_network)
-		display("%s%*s  %-*s%-*s\n", MARGIN, 8, "", 20,
-				"Connected network", 47,
-				network_get_name(station->connected_network));
+	if (station->connected_network) {
+		const struct proxy_interface *network_proxy =3D
+			proxy_interface_find(IWD_NETWORK_INTERFACE,
+						station->connected_network);
+
+		if (network_proxy)
+			display("%s%*s  %-*s%-*s\n", MARGIN, 8, "", 20,
+					"Connected network", 47,
+					network_get_name(network_proxy));
+	}
 =

 	display_table_footer();
 }
-- =

2.13.6

--===============1354956040677492795==--

