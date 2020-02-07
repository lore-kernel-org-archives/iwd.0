Content-Type: multipart/mixed; boundary="===============5338684745395774504=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/5] frame-xchg: Use both group_id and wdev_id when removing
 group
Date: Fri, 07 Feb 2020 12:39:13 +0100
Message-ID: <20200207113914.3869-4-andrew.zaborowski@intel.com>
In-Reply-To: <20200207113914.3869-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5338684745395774504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In frame_watch_group_remove I forgot to actually match the group to be
removed by both wdev_id and group_id.  group_ids are unique only in the
scope of one wdev.
---
 src/frame-xchg.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 7c7c2652..39b5b65a 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -381,19 +381,24 @@ bool frame_watch_add(uint64_t wdev_id, uint32_t group=
_id, uint16_t frame_type,
 	return true;
 }
 =

+struct watch_group_match_info {
+	uint64_t wdev_id;
+	uint32_t id;
+};
+
 static bool frame_watch_group_match(const void *a, const void *b)
 {
 	const struct watch_group *group =3D a;
-	uint32_t id =3D L_PTR_TO_UINT(b);
+	const struct watch_group_match_info *info =3D b;
 =

-	return group->id =3D=3D id;
+	return group->wdev_id =3D=3D info->wdev_id && group->id =3D=3D info->id;
 }
 =

 bool frame_watch_group_remove(uint64_t wdev_id, uint32_t group_id)
 {
+	struct watch_group_match_info info =3D { wdev_id, group_id };
 	struct watch_group *group =3D l_queue_remove_if(watch_groups,
-						frame_watch_group_match,
-						L_UINT_TO_PTR(group_id));
+						frame_watch_group_match, &info);
 =

 	if (!group)
 		return false;
-- =

2.20.1

--===============5338684745395774504==--

