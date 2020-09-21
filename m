Content-Type: multipart/mixed; boundary="===============8482836326907632629=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/5] p2p: Free peer->wfd in p2p_peer_free
Date: Mon, 21 Sep 2020 21:04:22 +0200
Message-ID: <20200921190425.615855-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200921190425.615855-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8482836326907632629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/p2p.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/p2p.c b/src/p2p.c
index 5ee887d3..cc24b92f 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -256,6 +256,7 @@ static void p2p_peer_free(void *user_data)
 	struct p2p_peer *peer =3D user_data;
 =

 	scan_bss_free(peer->bss);
+	l_free(peer->wfd);
 	l_free(peer->name);
 	l_free(peer);
 }
-- =

2.25.1

--===============8482836326907632629==--

