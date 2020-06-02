Content-Type: multipart/mixed; boundary="===============1983020998636134351=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 02/10] frame-xchg: Fix frame_watch_remove_by_handler for group
 0
Date: Tue, 02 Jun 2020 10:30:13 -0700
Message-ID: <20200602173021.20085-3-prestwoj@gmail.com>
In-Reply-To: <20200602173021.20085-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1983020998636134351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Andrew Zaborowski <andrew.zaborowski@intel.com>

Don't match the default group's (group_id 0) wdev_id against the
provided wdev_id because the default group can be used on all wdevs and
its wdev_id is 0.  Also match individual item's wdev_id in the group to
make up for this although it normally wouldn't matter.
---
 src/frame-xchg.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 71751ca4..ba8bd0f0 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -671,6 +671,7 @@ bool frame_watch_wdev_remove(uint64_t wdev_id)
 }
 =

 struct frame_watch_handler_check_info {
+	uint64_t wdev_id;
 	frame_watch_cb_t handler;
 	void *user_data;
 };
@@ -681,7 +682,8 @@ static bool frame_watch_item_remove_by_handler(void *da=
ta, void *user_data)
 		l_container_of(data, struct frame_watch, super);
 	struct frame_watch_handler_check_info *info =3D user_data;
 =

-	if (watch->super.notify !=3D info->handler ||
+	if (watch->wdev_id !=3D info->wdev_id ||
+			watch->super.notify !=3D info->handler ||
 			watch->super.notify_data !=3D info->user_data)
 		return false;
 =

@@ -712,9 +714,9 @@ static bool frame_watch_remove_by_handler(uint64_t wdev=
_id, uint32_t group_id,
 						void *user_data)
 {
 	struct watch_group_match_info group_info =3D
-		{ wdev_id, group_id };
+		{ group_id =3D=3D 0 ? 0 : wdev_id, group_id };
 	struct frame_watch_handler_check_info handler_info =3D
-		{ handler, user_data };
+		{ wdev_id, handler, user_data };
 	struct watch_group *group =3D l_queue_find(watch_groups,
 						frame_watch_group_match,
 						&group_info);
-- =

2.21.1

--===============1983020998636134351==--

