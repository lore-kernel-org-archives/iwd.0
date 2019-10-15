Content-Type: multipart/mixed; boundary="===============4423060437392517085=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 2/2] client: Address dbl free reported by coverity
Date: Tue, 15 Oct 2019 10:34:12 -0700
Message-ID: <20191015173412.11810-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191015173412.11810-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4423060437392517085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In practice, the double free isn't possible in this logic.

It also simplifies the print logic
---
 client/station.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/client/station.c b/client/station.c
index a332f486..a89c9833 100644
--- a/client/station.c
+++ b/client/station.c
@@ -338,7 +338,6 @@ static void ordered_networks_display(struct l_queue *or=
dered_networks)
 {
 	char *dbms =3D NULL;
 	const struct l_queue_entry *entry;
-	bool is_first;
 =

 	display_table_header("Available networks", "%s%-*s%-*s%-*s%*s",
 					MARGIN, 2, "", 32, "Network name",
@@ -351,7 +350,7 @@ static void ordered_networks_display(struct l_queue *or=
dered_networks)
 		return;
 	}
 =

-	for (is_first =3D true, entry =3D l_queue_get_entries(ordered_networks);
+	for (entry =3D l_queue_get_entries(ordered_networks);
 						entry; entry =3D entry->next) {
 		struct ordered_network *network =3D entry->data;
 		const struct proxy_interface *network_i =3D
@@ -362,24 +361,17 @@ static void ordered_networks_display(struct l_queue *=
ordered_networks)
 		if (display_signal_as_dbms)
 			dbms =3D l_strdup_printf("%d", network->signal_strength);
 =

-		if (is_first && network_is_connected(network_i)) {
-			display("%s%-*s%-*s%-*s%-*s\n", MARGIN,
-				2, COLOR_BOLDGRAY "> " COLOR_OFF,
-				32, network_name, 10, network_type,
-				6, display_signal_as_dbms ? dbms :
-					dbms_tostars(network->signal_strength));
+		display("%s%-*s%-*s%-*s%-*s\n", MARGIN, 2,
+			network_is_connected(network_i) ?
+				COLOR_BOLDGRAY "> " COLOR_OFF : "",
+			32, network_name, 10, network_type,
+			6, display_signal_as_dbms ? dbms :
+				dbms_tostars(network->signal_strength));
 =

+		if (display_signal_as_dbms) {
 			l_free(dbms);
-			is_first =3D false;
-			continue;
+			dbms =3D NULL;
 		}
-
-		display("%s%-*s%-*s%-*s%-*s\n", MARGIN, 2, "",
-				32, network_name, 10, network_type,
-				6, display_signal_as_dbms ? dbms :
-					dbms_tostars(network->signal_strength));
-
-		l_free(dbms);
 	}
 =

 	display_table_footer();
-- =

2.13.6

--===============4423060437392517085==--

