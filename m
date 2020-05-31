Content-Type: multipart/mixed; boundary="===============8313053713481085252=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] frame-xchg: Fix frame_watch_remove_by_handler for group 0
Date: Sun, 31 May 2020 02:56:44 +0200
Message-ID: <20200531005645.257055-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8313053713481085252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Don't match the default group's (group_id 0) wdev_id against the
provided wdev_id because the default group can be used on all wdevs and
its wdev_id is 0.  Also match individual item's wdev_id in the group to
make up for this although it normally wouldn't matter.
---
 src/frame-xchg.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 4c950fd3..44711997 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -661,6 +661,7 @@ bool frame_watch_wdev_remove(uint64_t wdev_id)
 }
 =

 struct frame_watch_handler_check_info {
+	uint64_t wdev_id;
 	frame_watch_cb_t handler;
 	void *user_data;
 };
@@ -671,7 +672,8 @@ static bool frame_watch_item_remove_by_handler(void *da=
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

@@ -702,9 +704,9 @@ static bool frame_watch_remove_by_handler(uint64_t wdev=
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

2.25.1

--===============8313053713481085252==--

