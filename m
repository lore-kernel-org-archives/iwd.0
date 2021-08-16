Content-Type: multipart/mixed; boundary="===============6593150642634695036=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/5] network: destroy secrets on network_disconnect()
Date: Mon, 16 Aug 2021 16:58:20 -0700
Message-ID: <20210816235823.146856-2-prestwoj@gmail.com>
In-Reply-To: <20210816235823.146856-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6593150642634695036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/network.c b/src/network.c
index 20c0ee1f..2779f6be 100644
--- a/src/network.c
+++ b/src/network.c
@@ -192,6 +192,8 @@ void network_disconnected(struct network *network)
 	network_settings_close(network);
 =

 	l_queue_clear(network->blacklist, NULL);
+	l_queue_destroy(network->secrets, eap_secret_info_free);
+	network->secrets =3D NULL;
 }
 =

 /* First 64 entries calculated by 1 / pow(n, 0.3) for n >=3D 1 */
-- =

2.31.1

--===============6593150642634695036==--

