Content-Type: multipart/mixed; boundary="===============7359278987248237198=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 4/8] hotspot: Fix mem leak on failed hotspot config
Date: Wed, 23 Oct 2019 13:23:59 -0700
Message-ID: <20191023202403.9690-4-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191023202403.9690-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7359278987248237198==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/hotspot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/hotspot.c b/src/hotspot.c
index 60a2e2de..8d2bb04a 100644
--- a/src/hotspot.c
+++ b/src/hotspot.c
@@ -423,8 +423,10 @@ static void hs20_dir_watch_cb(const char *filename,
 		}
 =

 		config =3D hs20_config_new(new, full_path);
-		if (!config)
-			break;
+		if (!config) {
+			l_settings_free(new);
+			return;
+		}
 =

 		l_queue_push_head(hs20_settings, config);
 =

-- =

2.13.6

--===============7359278987248237198==--

