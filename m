Content-Type: multipart/mixed; boundary="===============4575893678778152110=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] network: handle NULL/hotspot networks when removing
 secrets
Date: Wed, 18 Aug 2021 10:26:00 -0700
Message-ID: <20210818172603.266294-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4575893678778152110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The hotspot case can actually result in network being NULL which
ends up crashing when accessing "->secrets". In addition any
secrets on this network were never removed for hotspot networks
since everything happened in network_unset_hotspot.
---
 src/network.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/network.c b/src/network.c
index 79f3bd33..b794e609 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1823,6 +1823,11 @@ static void network_unset_hotspot(struct network *ne=
twork, void *user_data)
 		return;
 =

 	network_set_info(network, NULL);
+
+	if (network->secrets) {
+		l_queue_destroy(network->secrets, eap_secret_info_free);
+		network->secrets =3D NULL;
+	}
 }
 =

 static void emit_known_network_removed(struct station *station, void *user=
_data)
@@ -1850,8 +1855,10 @@ static void emit_known_network_removed(struct statio=
n *station, void *user_data)
 	if (network && was_hidden)
 		station_hide_network(station, network);
 =

-	l_queue_destroy(network->secrets, eap_secret_info_free);
-	network->secrets =3D NULL;
+	if (network && network->secrets) {
+		l_queue_destroy(network->secrets, eap_secret_info_free);
+		network->secrets =3D NULL;
+	}
 }
 =

 static void network_update_hotspot(struct network *network, void *user_dat=
a)
-- =

2.31.1

--===============4575893678778152110==--

