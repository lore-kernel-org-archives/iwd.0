Content-Type: multipart/mixed; boundary="===============4632166990853296111=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 01/13] frame-xchg: Fix potential use after free
Date: Fri, 31 Jul 2020 03:31:24 +0200
Message-ID: <20200731013136.65057-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4632166990853296111==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Check if the frame callback has cancelled the frame_xchg before
attempting to free it.
---
I'm adding a frame_xchg_match_ptr here and I think I might have
used a similar function somewhere else.  I was wondering if we
want to add a pointer compare function in util.c or accept NULL
as match function in l_queue_find() to mean match by data pointer.
---
 src/frame-xchg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 3c1fc279..dfe08f6a 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -975,6 +975,11 @@ static bool frame_xchg_tx_retry(struct wiphy_radio_wor=
k_item *item)
 	return false;
 }
 =

+static bool frame_xchg_match_ptr(const void *a, const void *b)
+{
+	return a =3D=3D b;
+}
+
 static bool frame_xchg_resp_handle(const struct mmpdu_header *mpdu,
 					const void *body, size_t body_len,
 					int rssi, void *user_data)
@@ -1013,6 +1018,9 @@ static bool frame_xchg_resp_handle(const struct mmpdu=
_header *mpdu,
 =

 		done =3D watch->cb(mpdu, body, body_len, rssi, fx->user_data);
 =

+		if (!l_queue_find(frame_xchgs, frame_xchg_match_ptr, fx))
+			return true;
+
 		if (done) {
 			/* NULL callback here since the caller is done */
 			fx->cb =3D NULL;
-- =

2.25.1

--===============4632166990853296111==--

