Content-Type: multipart/mixed; boundary="===============2863220946520076190=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/4] network: handle NULL/hotspot networks when removing
 secrets
Date: Wed, 18 Aug 2021 14:50:25 -0700
Message-ID: <20210818215028.294978-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2863220946520076190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The hotspot case can actually result in network being NULL which
ends up crashing when accessing "->secrets". In addition any
secrets on this network were never removed for hotspot networks
since everything happened in network_unset_hotspot.
---
 src/network.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/network.c b/src/network.c
index 79f3bd33..d81a201d 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1823,6 +1823,9 @@ static void network_unset_hotspot(struct network *net=
work, void *user_data)
 		return;
 =

 	network_set_info(network, NULL);
+
+	l_queue_destroy(network->secrets, eap_secret_info_free);
+	network->secrets =3D NULL;
 }
 =

 static void emit_known_network_removed(struct station *station, void *user=
_data)
@@ -1841,6 +1844,9 @@ static void emit_known_network_removed(struct station=
 *station, void *user_data)
 			return;
 =

 		network_set_info(network, NULL);
+
+		l_queue_destroy(network->secrets, eap_secret_info_free);
+		network->secrets =3D NULL;
 	}
 =

 	connected_network =3D station_get_connected_network(station);
@@ -1849,9 +1855,6 @@ static void emit_known_network_removed(struct station=
 *station, void *user_data)
 =

 	if (network && was_hidden)
 		station_hide_network(station, network);
-
-	l_queue_destroy(network->secrets, eap_secret_info_free);
-	network->secrets =3D NULL;
 }
 =

 static void network_update_hotspot(struct network *network, void *user_dat=
a)
-- =

2.31.1

--===============2863220946520076190==--

