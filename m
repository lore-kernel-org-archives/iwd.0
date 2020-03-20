Content-Type: multipart/mixed; boundary="===============4873958300165660501=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] frame-xchg: Drop l_io read destroy handler
Date: Fri, 20 Mar 2020 17:20:22 +0100
Message-ID: <20200320162022.16761-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4873958300165660501==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This function was intended to catch socket errors and destroy the group
but it would leak the l_io object if that happened, and if called on
ordinary shutdown it could cause a crash.  Since we're now assuming
that the netlink socket operations never fail just remove it.
---
 src/frame-xchg.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 131d5061..50351615 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -361,19 +361,6 @@ static bool frame_watch_group_io_read(struct l_io *io,=
 void *user_data)
 	return true;
 }
 =

-static void frame_watch_group_io_destroy(void *user_data)
-{
-	struct watch_group *group =3D user_data;
-
-	group->io =3D NULL;
-
-	if (l_queue_remove(watch_groups, group)) {
-		l_error("Frame watch group socket closed");
-
-		frame_watch_group_destroy(group);
-	}
-}
-
 static struct watch_group *frame_watch_group_new(uint64_t wdev_id, uint32_=
t id)
 {
 	struct watch_group *group =3D l_new(struct watch_group, 1);
@@ -435,7 +422,7 @@ static struct watch_group *frame_watch_group_new(uint64=
_t wdev_id, uint32_t id)
 =

 	l_io_set_close_on_destroy(group->io, true);
 	l_io_set_read_handler(group->io, frame_watch_group_io_read, group,
-				frame_watch_group_io_destroy);
+				NULL);
 	group->write_queue =3D l_queue_new();
 =

 	return group;
-- =

2.20.1

--===============4873958300165660501==--

