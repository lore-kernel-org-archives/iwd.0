Content-Type: multipart/mixed; boundary="===============6329293512792077757=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/4] frame-xchg: Don't call frame_xchg_destroy directly
Date: Tue, 21 Jul 2020 02:45:37 +0200
Message-ID: <20200721004540.399351-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6329293512792077757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

frame_xchg_destroy is passed as the wiphy radio work's destroy callback
to wiphy.c.  If it's also called directly in frame_xchg_exit, there's
going to be a use-after-free when it's called again from wiphy_exit, so
instead use wiphy_radio_work_done which will call frame_xchg_destroy and
forget the frame_xchg record.
---
 src/frame-xchg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 1ba2d907..f07a4d8d 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -1337,7 +1337,7 @@ static void destroy_xchg_data(void *user_data)
 {
 	struct frame_xchg_data *fx =3D user_data;
 =

-	frame_xchg_destroy(&fx->work);
+	wiphy_radio_work_done(wiphy_find_by_wdev(fx->wdev_id), fx->work.id);
 }
 =

 static void frame_xchg_exit(void)
@@ -1359,3 +1359,4 @@ static void frame_xchg_exit(void)
 }
 =

 IWD_MODULE(frame_xchg, frame_xchg_init, frame_xchg_exit);
+IWD_MODULE_DEPENDS(frame_xchg, wiphy)
-- =

2.25.1

--===============6329293512792077757==--

