Content-Type: multipart/mixed; boundary="===============1034717481822829648=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 02/18] p2p: Update peer->device_addr when updating peer->bss
Date: Sat, 11 Jul 2020 03:00:37 +0200
Message-ID: <20200711010053.224223-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200711010053.224223-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1034717481822829648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

peer->device_addr is a pointer to the Device Address contained in
one of two possible places in peer->bss.  If during discovery we've
received a new beacon/probe response for an existing peer and we're
going to replace peer->bss, we also have to update peer->device_addr.
---
 src/p2p.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/p2p.c b/src/p2p.c
index 095a05cd..c043f4c9 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -2408,6 +2408,13 @@ static bool p2p_peer_update_existing(struct scan_bss=
 *bss,
 	 * from the discovery scan results.
 	 * Do we need to update DBus properties?
 	 */
+
+	if (peer->device_addr =3D=3D peer->bss->addr)
+		peer->device_addr =3D bss->addr;
+	else
+		peer->device_addr =3D
+			bss->p2p_probe_resp_info->device_info.device_addr;
+
 	scan_bss_free(peer->bss);
 	peer->bss =3D bss;
 =

-- =

2.25.1

--===============1034717481822829648==--

