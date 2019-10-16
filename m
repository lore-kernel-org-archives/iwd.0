Content-Type: multipart/mixed; boundary="===============7600791385858848136=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/2] hotspot: fix multiple potential memory leaks
Date: Wed, 16 Oct 2019 16:21:50 -0700
Message-ID: <20191016232151.11778-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7600791385858848136==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/hotspot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/hotspot.c b/src/hotspot.c
index 20ebb2fd..ad8af37c 100644
--- a/src/hotspot.c
+++ b/src/hotspot.c
@@ -423,6 +423,8 @@ static void hs20_dir_watch_cb(const char *filename,
 =

 		l_queue_push_head(hs20_settings, config);
 =

+		l_settings_free(new);
+
 		break;
 	case L_DIR_WATCH_EVENT_REMOVED:
 		config =3D l_queue_remove_if(hs20_settings, match_filename,
@@ -453,6 +455,8 @@ static void hs20_dir_watch_cb(const char *filename,
 =

 		known_network_update(&config->super, new, connected_time);
 =

+		l_settings_free(new);
+
 		break;
 	case L_DIR_WATCH_EVENT_ACCESSED:
 		break;
-- =

2.17.1

--===============7600791385858848136==--

