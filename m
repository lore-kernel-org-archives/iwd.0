Content-Type: multipart/mixed; boundary="===============0313485314518903045=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/5] network: destroy secrets on known network removal
Date: Tue, 17 Aug 2021 09:44:58 -0700
Message-ID: <20210817164501.195027-2-prestwoj@gmail.com>
In-Reply-To: <20210817164501.195027-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0313485314518903045==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a known network is removed explicitly IWD should forget any
secrets cached on the network object.
---
 src/network.c | 3 +++
 1 file changed, 3 insertions(+)

v2:
 * Moved to known network removal rather than network_disconnected()

diff --git a/src/network.c b/src/network.c
index 20c0ee1f..79f3bd33 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1849,6 +1849,9 @@ static void emit_known_network_removed(struct station=
 *station, void *user_data)
 =

 	if (network && was_hidden)
 		station_hide_network(station, network);
+
+	l_queue_destroy(network->secrets, eap_secret_info_free);
+	network->secrets =3D NULL;
 }
 =

 static void network_update_hotspot(struct network *network, void *user_dat=
a)
-- =

2.31.1

--===============0313485314518903045==--

