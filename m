Content-Type: multipart/mixed; boundary="===============3944816280386780387=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/5] frame-xchg: Try to call a handler only once per frame
Date: Fri, 07 Feb 2020 12:39:12 +0100
Message-ID: <20200207113914.3869-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200207113914.3869-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3944816280386780387==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Try to better deduplicate the frame watches.  Until now we'd check if
we'd already registered a given frame body prefix with the kernel, or a
matching more general prefix (shorter).  Now also try to check if we
have already have a watch with the same callback pointer and user_data
value, and:

 * an identical or shorter (more general) prefix, in that case ignore
   the new watch completely.

 * a longer (more specific) prefix, in that case forget the existing
   watch.

The use case for this is when we have a single callback for multiple
watches and multiple frame types, and inside that callback we're looking
at the frame body again and matching it to frame types.  In that case
we don't want that function to be called multiple times for one frame
event.
---
 src/frame-xchg.c | 70 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 64 insertions(+), 6 deletions(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 89b0f93e..7c7c2652 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -280,6 +280,60 @@ static void frame_watch_register_cb(struct l_genl_msg =
*msg, void *user_data)
 			L_PTR_TO_UINT(user_data), l_genl_msg_get_error(msg));
 }
 =

+struct frame_duplicate_info {
+	uint64_t wdev_id;
+	uint16_t frame_type;
+	const uint8_t *prefix;
+	size_t prefix_len;
+	frame_watch_cb_t handler;
+	void *user_data;
+	bool duplicate : 1;
+	bool registered : 1;
+};
+
+static bool frame_watch_check_duplicate(void *data, void *user_data)
+{
+	struct watchlist_item *super =3D data;
+	struct frame_watch *watch =3D
+		l_container_of(super, struct frame_watch, super);
+	struct frame_duplicate_info *info =3D user_data;
+	int common_len =3D info->prefix_len < watch->prefix_len ?
+		info->prefix_len : watch->prefix_len;
+
+	if (info->wdev_id !=3D watch->wdev_id ||
+			info->frame_type !=3D watch->frame_type ||
+			(common_len &&
+			 memcmp(info->prefix, watch->prefix, common_len)))
+		/* No match */
+		return false;
+
+	if (info->prefix_len >=3D watch->prefix_len)
+		/*
+		 * A matching shorter prefix is already registered with
+		 * the kernel, no need to register the new prefix.
+		 */
+		info->registered =3D true;
+
+	if (info->handler !=3D watch->super.notify ||
+			info->user_data !=3D watch->super.notify_data)
+		return false;
+
+	/*
+	 * If we already have a watch with the exact same callback and
+	 * user_data and a matching prefix (longer or shorter), drop
+	 * either the existing watch, or the new watch, so as to preserve
+	 * the set of frames that trigger the callback but avoid
+	 * calling back twice with the same user_data.
+	 */
+	if (info->prefix_len >=3D watch->prefix_len) {
+		info->duplicate =3D true;
+		return false;
+	}
+
+	/* Drop the existing watch as a duplicate of the new one */
+	return true;
+}
+
 bool frame_watch_add(uint64_t wdev_id, uint32_t group_id, uint16_t frame_t=
ype,
 			const uint8_t *prefix, size_t prefix_len,
 			frame_watch_cb_t handler, void *user_data,
@@ -288,15 +342,19 @@ bool frame_watch_add(uint64_t wdev_id, uint32_t group=
_id, uint16_t frame_type,
 	struct watch_group *group =3D frame_watch_group_get(wdev_id, group_id);
 	struct frame_watch *watch;
 	struct l_genl_msg *msg;
-	struct frame_prefix_info info =3D { frame_type, prefix, prefix_len, wdev_=
id };
-	bool registered;
+	struct frame_duplicate_info info =3D {
+		wdev_id, frame_type, prefix, prefix_len,
+		handler, user_data, false, false
+	};
 =

 	if (!group)
 		return false;
 =

-	registered =3D l_queue_find(group->watches.items,
-					frame_watch_match_prefix,
-					&info);
+	l_queue_foreach_remove(group->watches.items,
+				frame_watch_check_duplicate, &info);
+
+	if (info.duplicate)
+		return true;
 =

 	watch =3D l_new(struct frame_watch, 1);
 	watch->frame_type =3D frame_type;
@@ -307,7 +365,7 @@ bool frame_watch_add(uint64_t wdev_id, uint32_t group_i=
d, uint16_t frame_type,
 	watchlist_link(&group->watches, &watch->super, handler, user_data,
 			destroy);
 =

-	if (registered)
+	if (info.registered)
 		return true;
 =

 	msg =3D l_genl_msg_new_sized(NL80211_CMD_REGISTER_FRAME, 32 + prefix_len);
-- =

2.20.1

--===============3944816280386780387==--

