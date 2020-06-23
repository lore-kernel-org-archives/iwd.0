Content-Type: multipart/mixed; boundary="===============8591802744028594514=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] frame-xchg: add destroy function to start() APIs
Date: Tue, 23 Jun 2020 08:42:51 -0700
Message-ID: <20200623154251.13491-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8591802744028594514==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This makes things more consistent with other IWD APIs as well as
prepares for unifying frame-xchg and scanning.
---
 src/frame-xchg.c | 36 ++++++++++++++++++++----------------
 src/frame-xchg.h |  6 ++++--
 src/p2p.c        |  2 +-
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 61399561..a9c1e4c3 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -106,6 +106,7 @@ struct frame_xchg_data {
 	struct l_timeout *timeout;
 	struct l_queue *rx_watches;
 	frame_xchg_cb_t cb;
+	frame_xchg_destroy_func_t destroy;
 	void *user_data;
 	uint32_t group_id;
 	unsigned int retry_cnt;
@@ -770,26 +771,25 @@ static void frame_xchg_reset(struct frame_xchg_data *=
fx)
 					frame_xchg_resp_cb, fx);
 }
 =

-static void frame_xchg_destroy(struct frame_xchg_data *fx, int err)
+static void frame_xchg_destroy(void *user_data)
 {
-	if (fx->cb)
-		fx->cb(err, fx->user_data);
+	struct frame_xchg_data *fx =3D user_data;
+
+	if (fx->destroy)
+		fx->destroy(fx->user_data);
 =

 	frame_xchg_reset(fx);
 	l_free(fx);
 }
 =

-static void frame_xchg_cancel(void *user_data)
-{
-	struct frame_xchg_data *fx =3D user_data;
-
-	frame_xchg_destroy(fx, -ECANCELED);
-}
-
 static void frame_xchg_done(struct frame_xchg_data *fx, int err)
 {
 	l_queue_remove(frame_xchgs, fx);
-	frame_xchg_destroy(fx, err);
+
+	if (fx->cb)
+		fx->cb(err, fx->user_data);
+
+	frame_xchg_destroy(fx);
 }
 =

 static void frame_xchg_timeout_destroy(void *user_data)
@@ -1073,20 +1073,23 @@ static bool frame_xchg_match(const void *a, const v=
oid *b)
 void frame_xchg_start(uint64_t wdev_id, struct iovec *frame, uint32_t freq,
 			unsigned int retry_interval, unsigned int resp_timeout,
 			unsigned int retries_on_ack, uint32_t group_id,
-			frame_xchg_cb_t cb, void *user_data, ...)
+			frame_xchg_cb_t cb, void *user_data,
+			frame_xchg_destroy_func_t destroy, ...)
 {
 	va_list args;
 =

-	va_start(args, user_data);
+	va_start(args, destroy);
 	frame_xchg_startv(wdev_id, frame, freq, retry_interval, resp_timeout,
-				retries_on_ack, group_id, cb, user_data, args);
+				retries_on_ack, group_id, cb, user_data,
+				destroy, args);
 	va_end(args);
 }
 =

 void frame_xchg_startv(uint64_t wdev_id, struct iovec *frame, uint32_t fre=
q,
 			unsigned int retry_interval, unsigned int resp_timeout,
 			unsigned int retries_on_ack, uint32_t group_id,
-			frame_xchg_cb_t cb, void *user_data, va_list resp_args)
+			frame_xchg_cb_t cb, void *user_data,
+			frame_xchg_destroy_func_t destroy, va_list resp_args)
 {
 	struct frame_xchg_data *fx;
 	size_t frame_len;
@@ -1137,6 +1140,7 @@ void frame_xchg_startv(uint64_t wdev_id, struct iovec=
 *frame, uint32_t freq,
 	fx->resp_timeout =3D resp_timeout;
 	fx->retries_on_ack =3D retries_on_ack;
 	fx->cb =3D cb;
+	fx->destroy =3D destroy;
 	fx->user_data =3D user_data;
 	fx->group_id =3D group_id;
 =

@@ -1343,7 +1347,7 @@ static void frame_xchg_exit(void)
 	struct l_queue *xchgs =3D frame_xchgs;
 =

 	frame_xchgs =3D NULL;
-	l_queue_destroy(xchgs, frame_xchg_cancel);
+	l_queue_destroy(xchgs, frame_xchg_destroy);
 =

 	watch_groups =3D NULL;
 	l_queue_destroy(groups, frame_watch_group_destroy);
diff --git a/src/frame-xchg.h b/src/frame-xchg.h
index 45b0e5fa..55a55f73 100644
--- a/src/frame-xchg.h
+++ b/src/frame-xchg.h
@@ -46,9 +46,11 @@ bool frame_watch_wdev_remove(uint64_t wdev_id);
 void frame_xchg_start(uint64_t wdev_id, struct iovec *frame, uint32_t freq,
 			unsigned int retry_interval, unsigned int resp_timeout,
 			unsigned int retries_on_ack, uint32_t group_id,
-			frame_xchg_cb_t cb, void *user_data, ...);
+			frame_xchg_cb_t cb, void *user_data,
+			frame_xchg_destroy_func_t destroy, ...);
 void frame_xchg_startv(uint64_t wdev_id, struct iovec *frame, uint32_t fre=
q,
 			unsigned int retry_interval, unsigned int resp_timeout,
 			unsigned int retries_on_ack, uint32_t group_id,
-			frame_xchg_cb_t cb, void *user_data, va_list resp_args);
+			frame_xchg_cb_t cb, void *user_data,
+			frame_xchg_destroy_func_t destroy, va_list resp_args);
 void frame_xchg_stop(uint64_t wdev_id);
diff --git a/src/p2p.c b/src/p2p.c
index a759df5c..1c9cb081 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -460,7 +460,7 @@ static void p2p_peer_frame_xchg(struct p2p_peer *peer, =
struct iovec *tx_body,
 	va_start(args, cb);
 	frame_xchg_startv(dev->wdev_id, frame, freq, retry_interval,
 				resp_timeout, retries_on_ack, group_id,
-				cb, dev, args);
+				cb, dev, NULL, args);
 	va_end(args);
 =

 	l_free(frame);
-- =

2.21.1

--===============8591802744028594514==--

