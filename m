Content-Type: multipart/mixed; boundary="===============5292641061207518676=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 09/12] frame-xchg: Optimize frame_watch_remove_by_handler
 scenarios
Date: Wed, 18 Mar 2020 15:45:28 +0100
Message-ID: <20200318144531.30613-9-andrew.zaborowski@intel.com>
In-Reply-To: <20200318144531.30613-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5292641061207518676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since frame_watch_remove_by_handler only forgets a given function +
user data pointers, and doesn't remove the frame prefixes added in the
kernel, we can avoid later re-registering those prefixes with the
kernel by keeping them in our local watchlist, and only replacing the
handler pointer with a dummy function.
---
 src/frame-xchg.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index dd6d63ad..a7565a24 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -474,6 +474,12 @@ static void frame_watch_register_cb(struct l_genl_msg =
*msg, void *user_data)
 			L_PTR_TO_UINT(user_data), l_genl_msg_get_error(msg));
 }
 =

+static void frame_watch_notify_empty(const struct mmpdu_header *mpdu,
+					const void *body, size_t body_len,
+					int rssi, void *user_data)
+{
+}
+
 struct frame_duplicate_info {
 	uint64_t wdev_id;
 	uint16_t frame_type;
@@ -508,6 +514,17 @@ static bool frame_watch_check_duplicate(void *data, vo=
id *user_data)
 		 */
 		info->registered =3D true;
 =

+	/*
+	 * If we previously had a watch registered on this socket,
+	 * with the same or a more specific prefix, we can now forget
+	 * its entry as the new watch is going to hold enough
+	 * information to keep us from registering redundant prefixes
+	 * in the future.
+	 */
+	if (info->prefix_len <=3D watch->prefix_len &&
+			watch->super.notify =3D=3D frame_watch_notify_empty)
+		goto drop;
+
 	if (info->handler !=3D watch->super.notify ||
 			info->user_data !=3D watch->super.notify_data)
 		return false;
@@ -524,6 +541,7 @@ static bool frame_watch_check_duplicate(void *data, voi=
d *user_data)
 		return false;
 	}
 =

+drop:
 	/* Drop the existing watch as a duplicate of the new one */
 	frame_watch_free(&watch->super);
 	return true;
@@ -667,11 +685,19 @@ static bool frame_watch_item_remove_by_handler(void *=
data, void *user_data)
 			watch->super.notify_data !=3D info->user_data)
 		return false;
 =

-	if (watch->super.destroy)
+	if (watch->super.destroy) {
 		watch->super.destroy(watch->super.notify_data);
+		watch->super.destroy =3D NULL;
+	}
 =

-	frame_watch_free(&watch->super);
-	return true;
+	/*
+	 * Keep the entry, with a dummy callback, in order to keep us from
+	 * re-registering its prefix in future frame_watch_add calls.  We
+	 * can drop the entry in some circumstances but checking the
+	 * conditions for this costs more than it is worth right now.
+	 */
+	watch->super.notify =3D frame_watch_notify_empty;
+	return false;
 }
 =

 /*
-- =

2.20.1

--===============5292641061207518676==--

