Content-Type: multipart/mixed; boundary="===============0671897761876393323=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 05/12] frame-xchg: Fix frame_watch_item_remove_by_handler
Date: Wed, 18 Mar 2020 15:45:24 +0100
Message-ID: <20200318144531.30613-5-andrew.zaborowski@intel.com>
In-Reply-To: <20200318144531.30613-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0671897761876393323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/frame-xchg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 68bd6168..7b45ebb6 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -658,7 +658,8 @@ struct frame_watch_handler_check_info {
 =

 static bool frame_watch_item_remove_by_handler(void *data, void *user_data)
 {
-	struct frame_watch *watch =3D data;
+	struct frame_watch *watch =3D
+		l_container_of(data, struct frame_watch, super);
 	struct frame_watch_handler_check_info *info =3D user_data;
 =

 	if (watch->super.notify !=3D info->handler ||
-- =

2.20.1

--===============0671897761876393323==--

