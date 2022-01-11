Content-Type: multipart/mixed; boundary="===============1253842355422074619=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 6/6] frame-xchg: use work priorities rather than hard coding
Date: Tue, 11 Jan 2022 09:45:14 -0800
Message-ID: <20220111174514.1074967-6-prestwoj@gmail.com>
In-Reply-To: 20220111174514.1074967-1-prestwoj@gmail.com

--===============1253842355422074619==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/frame-xchg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 4ecfc45d..2c06269c 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -1213,7 +1213,8 @@ uint32_t frame_xchg_startv(uint64_t wdev_id, struct i=
ovec *frame, uint32_t freq,
 	 * wait on channel) are introduced.
 	 */
 	return wiphy_radio_work_insert(wiphy_find_by_wdev(wdev_id),
-					&fx->work, 0, &work_ops);
+					&fx->work, WIPHY_WORK_PRIORITY_FRAME,
+					&work_ops);
 }
 =

 static bool frame_xchg_cancel_by_wdev(void *data, void *user_data)
-- =

2.31.1

--===============1253842355422074619==--

