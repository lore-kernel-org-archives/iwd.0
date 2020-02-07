Content-Type: multipart/mixed; boundary="===============4371383444160500718=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/5] frame-xchg: Add new groups to watch_groups list
Date: Fri, 07 Feb 2020 12:39:11 +0100
Message-ID: <20200207113914.3869-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200207113914.3869-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4371383444160500718==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I forgot to actually add new groups being created in
frame_watch_group_get to the watch_groups queue, meaning that we'd
re-create the group every time a new watch was added to the group.
---
 src/frame-xchg.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 0a6c1fc6..89b0f93e 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -258,16 +258,19 @@ err:
 static struct watch_group *frame_watch_group_get(uint64_t wdev_id, uint32_=
t id)
 {
 	const struct l_queue_entry *entry;
+	struct watch_group *group;
 =

 	for (entry =3D l_queue_get_entries(watch_groups); entry;
 			entry =3D entry->next) {
-		struct watch_group *group =3D entry->data;
+		group =3D entry->data;
 =

 		if (group->id =3D=3D id && (id =3D=3D 0 || group->wdev_id =3D=3D wdev_id=
))
 			return group;
 	}
 =

-	return frame_watch_group_new(wdev_id, id);
+	group =3D frame_watch_group_new(wdev_id, id);
+	l_queue_push_tail(watch_groups, group);
+	return group;
 }
 =

 static void frame_watch_register_cb(struct l_genl_msg *msg, void *user_dat=
a)
-- =

2.20.1

--===============4371383444160500718==--

