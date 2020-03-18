Content-Type: multipart/mixed; boundary="===============4073268631717458206=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 03/12] frame-xchg: Handle l_io errors through disconnect
 callback
Date: Wed, 18 Mar 2020 15:45:22 +0100
Message-ID: <20200318144531.30613-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200318144531.30613-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4073268631717458206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Don't try to handle l_io read errors in the read handler destroy
callback.  That cb is called both when the read handler returns false,
and when poll returns an error.  In neither case the l_io is
automatically destroyed so we were wrongly setting group->io =3D NULL,
we need to manually destroy the l_io.  But you can't use l_io_destroy
safely from inside the read handler destroy callback.  Do this in the
disconnect callback instead which is safe.
---
 src/frame-xchg.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index ce69c454..3719ed6c 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -234,6 +234,7 @@ static void frame_watch_group_destroy(void *data)
 		l_genl_remove_unicast_watch(iwd_get_genl(),
 						group->unicast_watch_id);
 =

+	l_io_set_disconnect_handler(group->io, NULL, NULL, NULL);
 	l_io_destroy(group->io);
 	l_queue_destroy(group->write_queue,
 			(l_queue_destroy_func_t) l_genl_msg_unref);
@@ -359,17 +360,16 @@ static bool frame_watch_group_io_read(struct l_io *io=
, void *user_data)
 	return true;
 }
 =

-static void frame_watch_group_io_destroy(void *user_data)
+static void frame_watch_group_io_disconnect(struct l_io *io, void *user_da=
ta)
 {
 	struct watch_group *group =3D user_data;
 =

-	group->io =3D NULL;
+	if (!l_queue_remove(watch_groups, group))
+		return;
 =

-	if (l_queue_remove(watch_groups, group)) {
-		l_error("Frame watch group socket closed");
+	l_error("Frame watch group %i socket closed", (int) group->id);
 =

-		frame_watch_group_destroy(group);
-	}
+	frame_watch_group_destroy(group);
 }
 =

 static struct watch_group *frame_watch_group_new(uint64_t wdev_id, uint32_=
t id)
@@ -432,8 +432,10 @@ static struct watch_group *frame_watch_group_new(uint6=
4_t wdev_id, uint32_t id)
 		goto err;
 =

 	l_io_set_close_on_destroy(group->io, true);
-	l_io_set_read_handler(group->io, frame_watch_group_io_read, group,
-				frame_watch_group_io_destroy);
+	l_io_set_read_handler(group->io, frame_watch_group_io_read,
+					group, NULL);
+	l_io_set_disconnect_handler(group->io, frame_watch_group_io_disconnect,
+					group, NULL);
 	group->write_queue =3D l_queue_new();
 =

 	return group;
-- =

2.20.1

--===============4073268631717458206==--

