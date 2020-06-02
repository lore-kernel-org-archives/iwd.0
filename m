Content-Type: multipart/mixed; boundary="===============6297069176027843988=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 03/10] frame-xchg: Use frame_watch_group_match in
 frame_watch_group_get
Date: Tue, 02 Jun 2020 10:30:14 -0700
Message-ID: <20200602173021.20085-4-prestwoj@gmail.com>
In-Reply-To: <20200602173021.20085-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6297069176027843988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Andrew Zaborowski <andrew.zaborowski@intel.com>

---
 src/frame-xchg.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index ba8bd0f0..7e516d0a 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -439,21 +439,30 @@ err:
 	return NULL;
 }
 =

-static struct watch_group *frame_watch_group_get(uint64_t wdev_id, uint32_=
t id)
+struct watch_group_match_info {
+	uint64_t wdev_id;
+	uint32_t id;
+};
+
+static bool frame_watch_group_match(const void *a, const void *b)
 {
-	const struct l_queue_entry *entry;
-	struct watch_group *group;
+	const struct watch_group *group =3D a;
+	const struct watch_group_match_info *info =3D b;
 =

-	for (entry =3D l_queue_get_entries(watch_groups); entry;
-			entry =3D entry->next) {
-		group =3D entry->data;
+	return group->wdev_id =3D=3D info->wdev_id && group->id =3D=3D info->id;
+}
 =

-		if (group->id =3D=3D id && (id =3D=3D 0 || group->wdev_id =3D=3D wdev_id=
))
-			return group;
+static struct watch_group *frame_watch_group_get(uint64_t wdev_id, uint32_=
t id)
+{
+	struct watch_group_match_info info =3D { id =3D=3D 0 ? 0 : wdev_id, id };
+	struct watch_group *group =3D l_queue_find(watch_groups,
+						frame_watch_group_match, &info);
+
+	if (!group) {
+		group =3D frame_watch_group_new(wdev_id, id);
+		l_queue_push_tail(watch_groups, group);
 	}
 =

-	group =3D frame_watch_group_new(wdev_id, id);
-	l_queue_push_tail(watch_groups, group);
 	return group;
 }
 =

@@ -600,19 +609,6 @@ bool frame_watch_add(uint64_t wdev_id, uint32_t group_=
id, uint16_t frame_type,
 	return true;
 }
 =

-struct watch_group_match_info {
-	uint64_t wdev_id;
-	uint32_t id;
-};
-
-static bool frame_watch_group_match(const void *a, const void *b)
-{
-	const struct watch_group *group =3D a;
-	const struct watch_group_match_info *info =3D b;
-
-	return group->wdev_id =3D=3D info->wdev_id && group->id =3D=3D info->id;
-}
-
 bool frame_watch_group_remove(uint64_t wdev_id, uint32_t group_id)
 {
 	struct watch_group_match_info info =3D { wdev_id, group_id };
-- =

2.21.1

--===============6297069176027843988==--

