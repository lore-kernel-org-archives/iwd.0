Content-Type: multipart/mixed; boundary="===============7813072424214155258=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/5] hotspot: fix double free between hostpot and knownnetworks
Date: Wed, 13 Nov 2019 14:30:32 -0800
Message-ID: <20191113223032.5650-5-prestwoj@gmail.com>
In-Reply-To: <20191113223032.5650-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7813072424214155258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The module framework was changed to call the module exit functions in
the reverse order as the init functions. This uncovered/caused known
networks to try and free the network_info structures after hotspot had
already freed them. Since known networks clean up the network_info's
anyways, we don't actually need hotspot to do any cleanup.
---
 src/hotspot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/hotspot.c b/src/hotspot.c
index 68fc5a66..6a95757b 100644
--- a/src/hotspot.c
+++ b/src/hotspot.c
@@ -524,7 +524,7 @@ static void hotspot_exit(void)
 {
 	l_dir_watch_destroy(hs20_dir_watch);
 =

-	l_queue_destroy(hs20_settings, hs20_config_free);
+	l_queue_destroy(hs20_settings, NULL);
 	hs20_settings =3D NULL;
 }
 =

-- =

2.17.1

--===============7813072424214155258==--

