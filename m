Content-Type: multipart/mixed; boundary="===============1496843714964608881=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 07/12] frame-xchg: Allow frame_xchg_stop calls inside frame
 callbacks
Date: Wed, 18 Mar 2020 15:45:26 +0100
Message-ID: <20200318144531.30613-7-andrew.zaborowski@intel.com>
In-Reply-To: <20200318144531.30613-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1496843714964608881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make sure a frame callback is free to call frame_xchg_stop without
causing a crash.  Frame callback here means the one that gets
called if our tx frame was ACKed and triggered a respone frame that
matched one of the provided prefixes, within the given time.

All in all a frame callback is allowed to call either
frame_xchg_stop or frame_xchg_startv or neither.  Same applies to
the final callback (called when no matching responses received).
---
 src/frame-xchg.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 7b66cb6d..dd6d63ad 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -108,6 +108,7 @@ struct frame_xchg_data {
 	unsigned int retry_interval;
 	unsigned int resp_timeout;
 	bool in_frame_cb : 1;
+	bool stale : 1;
 };
 =

 struct frame_xchg_watch_data {
@@ -725,6 +726,7 @@ static void frame_xchg_wait_cancel(struct frame_xchg_da=
ta *fx)
 static void frame_xchg_reset(struct frame_xchg_data *fx)
 {
 	fx->in_frame_cb =3D false;
+	fx->stale =3D false;
 =

 	frame_xchg_wait_cancel(fx);
 =

@@ -972,7 +974,7 @@ static void frame_xchg_resp_cb(const struct mmpdu_heade=
r *mpdu,
 =

 		fx->in_frame_cb =3D false;
 =

-		if (done) {
+		if (done || fx->stale) {
 			fx->cb =3D NULL;
 			frame_xchg_done(fx, 0);
 			return;
@@ -1117,6 +1119,11 @@ void frame_xchg_stop(uint64_t wdev_id)
 	if (!fx)
 		return;
 =

+	if (fx->in_frame_cb) {
+		fx->stale =3D true;
+		return;
+	}
+
 	frame_xchg_reset(fx);
 	l_free(fx);
 }
-- =

2.20.1

--===============1496843714964608881==--

