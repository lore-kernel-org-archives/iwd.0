Content-Type: multipart/mixed; boundary="===============6587329107003163266=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 1/6] frame-xchg: add destroy function to start() APIs
Date: Wed, 17 Jun 2020 10:56:40 -0700
Message-ID: <20200617175645.31197-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6587329107003163266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This makes things more consistent with other IWD APIs as well as
prepares for unifying frame-xchg and scanning.
---
 src/frame-xchg.c | 36 ++++++++++++++++++++----------------
 src/frame-xchg.h |  6 ++++--
 2 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 7e516d0a..1473e59e 100644
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
@@ -1132,6 +1135,7 @@ void frame_xchg_startv(uint64_t wdev_id, struct iovec=
 *frame, uint32_t freq,
 	fx->resp_timeout =3D resp_timeout;
 	fx->retries_on_ack =3D retries_on_ack;
 	fx->cb =3D cb;
+	fx->destroy =3D destroy;
 	fx->user_data =3D user_data;
 	fx->group_id =3D group_id;
 =

@@ -1338,7 +1342,7 @@ static void frame_xchg_exit(void)
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
-- =

2.21.1

--===============6587329107003163266==--

