Content-Type: multipart/mixed; boundary="===============0935346589629574308=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 05/10] hotspot: fix multiple potential memory leaks
Date: Wed, 16 Oct 2019 15:29:48 -0700
Message-ID: <20191016222953.513-5-prestwoj@gmail.com>
In-Reply-To: <20191016222953.513-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0935346589629574308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/hotspot.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/hotspot.c b/src/hotspot.c
index 20ebb2fd..1a783958 100644
--- a/src/hotspot.c
+++ b/src/hotspot.c
@@ -342,7 +342,11 @@ static struct hs20_config *hs20_config_new(struct l_se=
ttings *settings,
 	config =3D l_new(struct hs20_config, 1);
 =

 	if (hessid_str) {
-		util_string_to_address(hessid_str, config->hessid);
+		if (!util_string_to_address(hessid_str, config->hessid)) {
+			l_error("Invalid HESSID in settings");
+			memset(config->hessid, 0, 6);
+		}
+
 		l_free(hessid_str);
 	}
 =

@@ -423,6 +427,8 @@ static void hs20_dir_watch_cb(const char *filename,
 =

 		l_queue_push_head(hs20_settings, config);
 =

+		l_settings_free(new);
+
 		break;
 	case L_DIR_WATCH_EVENT_REMOVED:
 		config =3D l_queue_remove_if(hs20_settings, match_filename,
@@ -453,6 +459,8 @@ static void hs20_dir_watch_cb(const char *filename,
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

--===============0935346589629574308==--

