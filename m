Content-Type: multipart/mixed; boundary="===============1349241968943703379=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 4/6] frame-xchg: refactor to work with offchannel module
Date: Wed, 17 Jun 2020 10:56:43 -0700
Message-ID: <20200617175645.31197-4-prestwoj@gmail.com>
In-Reply-To: <20200617175645.31197-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1349241968943703379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In order to first integrate frame-xchg some refactoring needed to
be done. First it is useful to allow queueing frames up rather than
requiring the module (p2p, anqp etc) to wait for the last frame to
finish. This can be aided by offchannel but frame-xchg needed some
refactoring as well.

First was getting rid of this fx pointer re-use. It looks like this
was done to save a bit of memory but things get pretty complex
needed to check if the pointer is stale or has been reset. Instead
of this we now just allocate a new pointer each frame-xchg. This
allows for the module to queue multiple requests as well as removes
the complexity of needed to check if the fx pointer is stale.

Next was adding the ability to track frame-xchgs by ID. If a module
can queue up multiple requests it also needs to be able to cancel
them individually vs per-wdev. This comes free with offchannel since
it returns an ID which can be given directly to the caller.

Then offchannel was simply piped in by adding the push/done APIs
as well as some minor modification to internal frame-xchg APIs for
destroy functionality.
---
 src/frame-xchg.c | 97 +++++++++++++++++++++---------------------------
 src/frame-xchg.h |  6 +--
 src/p2p.c        |  9 +++--
 3 files changed, 51 insertions(+), 61 deletions(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 1473e59e..dd60e080 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -41,6 +41,7 @@
 #include "src/nl80211util.h"
 #include "src/netdev.h"
 #include "src/frame-xchg.h"
+#include "src/offchannel.h"
 =

 #ifndef SOL_NETLINK
 #define SOL_NETLINK 270
@@ -109,12 +110,11 @@ struct frame_xchg_data {
 	frame_xchg_destroy_func_t destroy;
 	void *user_data;
 	uint32_t group_id;
+	uint32_t offchan_id;
 	unsigned int retry_cnt;
 	unsigned int retry_interval;
 	unsigned int resp_timeout;
 	unsigned int retries_on_ack;
-	bool in_frame_cb : 1;
-	bool stale : 1;
 };
 =

 struct frame_xchg_watch_data {
@@ -726,7 +726,7 @@ static bool frame_watch_remove_by_handler(uint64_t wdev=
_id, uint32_t group_id,
 					&handler_info) > 0;
 }
 =

-static void frame_xchg_tx_retry(struct frame_xchg_data *fx);
+static bool frame_xchg_tx_retry(void *user_data);
 static bool frame_xchg_resp_handle(const struct mmpdu_header *mpdu,
 					const void *body, size_t body_len,
 					int rssi, void *user_data);
@@ -753,9 +753,6 @@ static void frame_xchg_wait_cancel(struct frame_xchg_da=
ta *fx)
 =

 static void frame_xchg_reset(struct frame_xchg_data *fx)
 {
-	fx->in_frame_cb =3D false;
-	fx->stale =3D false;
-
 	frame_xchg_wait_cancel(fx);
 =

 	if (fx->timeout)
@@ -789,7 +786,7 @@ static void frame_xchg_done(struct frame_xchg_data *fx,=
 int err)
 	if (fx->cb)
 		fx->cb(err, fx->user_data);
 =

-	frame_xchg_destroy(fx);
+	offchan_work_done(fx->wdev_id, fx->offchan_id);
 }
 =

 static void frame_xchg_timeout_destroy(void *user_data)
@@ -918,12 +915,16 @@ error:
 	frame_xchg_done(fx, error);
 }
 =

-static void frame_xchg_tx_retry(struct frame_xchg_data *fx)
+static bool frame_xchg_tx_retry(void *user_data)
 {
+	struct frame_xchg_data *fx =3D user_data;
 	struct l_genl_msg *msg;
 	uint32_t cmd_id;
 	uint32_t duration =3D fx->resp_timeout;
 =

+	/* push fx now that we are ready to start offchannel work */
+	l_queue_push_tail(frame_xchgs, fx);
+
 	/*
 	 * TODO: in Station, AP, P2P-Client, GO or Ad-Hoc modes if we're
 	 * transmitting the frame on the BSS's operating channel we can skip
@@ -951,13 +952,15 @@ static void frame_xchg_tx_retry(struct frame_xchg_dat=
a *fx)
 		l_error("Error sending frame");
 		l_genl_msg_unref(msg);
 		frame_xchg_done(fx, -EIO);
-		return;
+		return true;
 	}
 =

 	fx->tx_acked =3D false;
 	fx->have_cookie =3D false;
 	fx->early_status =3D false;
 	fx->retry_cnt++;
+
+	return false;
 }
 =

 static bool frame_xchg_resp_handle(const struct mmpdu_header *mpdu,
@@ -999,20 +1002,10 @@ static bool frame_xchg_resp_handle(const struct mmpd=
u_header *mpdu,
 		if (!fx->tx_acked)
 			goto early_frame;
 =

-		fx->in_frame_cb =3D true;
 		done =3D watch->cb(mpdu, body, body_len, rssi, fx->user_data);
 =

-		/*
-		 * If the callback has started a new frame exchange it will
-		 * have reset and taken over the state variables and we need
-		 * to just exit without touching anything.
-		 */
-		if (!fx->in_frame_cb)
-			return true;
-
-		fx->in_frame_cb =3D false;
-
-		if (done || fx->stale) {
+		if (done) {
+			/* NULL callback here since the caller is done */
 			fx->cb =3D NULL;
 			frame_xchg_done(fx, 0);
 			return true;
@@ -1070,22 +1063,24 @@ static bool frame_xchg_match(const void *a, const v=
oid *b)
  * @resp_timeout was 0.  @frame is an iovec array terminated by an iovec
  * struct with NULL-iov_base.
  */
-void frame_xchg_start(uint64_t wdev_id, struct iovec *frame, uint32_t freq,
+uint32_t frame_xchg_start(uint64_t wdev_id, struct iovec *frame, uint32_t =
freq,
 			unsigned int retry_interval, unsigned int resp_timeout,
 			unsigned int retries_on_ack, uint32_t group_id,
 			frame_xchg_cb_t cb, void *user_data,
 			frame_xchg_destroy_func_t destroy, ...)
 {
+	uint32_t id;
 	va_list args;
 =

 	va_start(args, destroy);
-	frame_xchg_startv(wdev_id, frame, freq, retry_interval, resp_timeout,
+	id =3D frame_xchg_startv(wdev_id, frame, freq, retry_interval, resp_timeo=
ut,
 				retries_on_ack, group_id, cb, user_data,
 				destroy, args);
 	va_end(args);
+	return id;
 }
 =

-void frame_xchg_startv(uint64_t wdev_id, struct iovec *frame, uint32_t fre=
q,
+uint32_t frame_xchg_startv(uint64_t wdev_id, struct iovec *frame, uint32_t=
 freq,
 			unsigned int retry_interval, unsigned int resp_timeout,
 			unsigned int retries_on_ack, uint32_t group_id,
 			frame_xchg_cb_t cb, void *user_data,
@@ -1103,31 +1098,13 @@ void frame_xchg_startv(uint64_t wdev_id, struct iov=
ec *frame, uint32_t freq,
 	if (frame_len < sizeof(*mpdu)) {
 		l_error("Frame too short");
 		cb(-EMSGSIZE, user_data);
-		return;
+		return 0;
 	}
 =

-	fx =3D l_queue_find(frame_xchgs, frame_xchg_match, &wdev_id);
+	fx =3D l_new(struct frame_xchg_data, 1);
 =

-	if (fx) {
-		/*
-		 * If a frame callback calls us assume it's the end of
-		 * that earlier frame exchange and the start of a new one.
-		 */
-		if (fx->in_frame_cb)
-			frame_xchg_reset(fx);
-		else {
-			l_error("Frame exchange in progress");
-			cb(-EBUSY, user_data);
-			return;
-		}
-	} else {
-		fx =3D l_new(struct frame_xchg_data, 1);
-
-		if (!frame_xchgs)
-			frame_xchgs =3D l_queue_new();
-
-		l_queue_push_tail(frame_xchgs, fx);
-	}
+	if (!frame_xchgs)
+		frame_xchgs =3D l_queue_new();
 =

 	fx->wdev_id =3D wdev_id;
 	fx->freq =3D freq;
@@ -1172,22 +1149,34 @@ void frame_xchg_startv(uint64_t wdev_id, struct iov=
ec *frame, uint32_t freq,
 	}
 =

 	fx->retry_cnt =3D 0;
-	frame_xchg_tx_retry(fx);
+
+	/*
+	 * TODO: Assume any offchannel frames are a high priority. This may
+	 * need to be re-examined in the future if other operations (e.g.
+	 * wait on channel) are introduced.
+	 */
+	fx->offchan_id =3D offchan_work_push(wdev_id, OFFCHAN_PRIORITY_HIGH,
+						frame_xchg_tx_retry,
+						fx, frame_xchg_destroy);
+	return fx->offchan_id;
 }
 =

-void frame_xchg_stop(uint64_t wdev_id)
+static bool frame_xchg_match_id(const void *a, const void *b)
+{
+	const struct frame_xchg_data *fx =3D a;
+	const uint32_t *id =3D b;
+
+	return fx->offchan_id =3D=3D *id;
+}
+
+void frame_xchg_stop(uint64_t wdev_id, uint32_t id)
 {
 	struct frame_xchg_data *fx =3D
-		l_queue_remove_if(frame_xchgs, frame_xchg_match, &wdev_id);
+		l_queue_remove_if(frame_xchgs, frame_xchg_match_id, &id);
 =

 	if (!fx)
 		return;
 =

-	if (fx->in_frame_cb) {
-		fx->stale =3D true;
-		return;
-	}
-
 	frame_xchg_reset(fx);
 	l_free(fx);
 }
diff --git a/src/frame-xchg.h b/src/frame-xchg.h
index 55a55f73..5bcb0ad0 100644
--- a/src/frame-xchg.h
+++ b/src/frame-xchg.h
@@ -43,14 +43,14 @@ bool frame_watch_add(uint64_t wdev_id, uint32_t group, =
uint16_t frame_type,
 bool frame_watch_group_remove(uint64_t wdev_id, uint32_t group);
 bool frame_watch_wdev_remove(uint64_t wdev_id);
 =

-void frame_xchg_start(uint64_t wdev_id, struct iovec *frame, uint32_t freq,
+uint32_t frame_xchg_start(uint64_t wdev_id, struct iovec *frame, uint32_t =
freq,
 			unsigned int retry_interval, unsigned int resp_timeout,
 			unsigned int retries_on_ack, uint32_t group_id,
 			frame_xchg_cb_t cb, void *user_data,
 			frame_xchg_destroy_func_t destroy, ...);
-void frame_xchg_startv(uint64_t wdev_id, struct iovec *frame, uint32_t fre=
q,
+uint32_t frame_xchg_startv(uint64_t wdev_id, struct iovec *frame, uint32_t=
 freq,
 			unsigned int retry_interval, unsigned int resp_timeout,
 			unsigned int retries_on_ack, uint32_t group_id,
 			frame_xchg_cb_t cb, void *user_data,
 			frame_xchg_destroy_func_t destroy, va_list resp_args);
-void frame_xchg_stop(uint64_t wdev_id);
+void frame_xchg_stop(uint64_t wdev_id, uint32_t id);
diff --git a/src/p2p.c b/src/p2p.c
index dc78b887..e46abe4f 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -67,6 +67,7 @@ struct p2p_device {
 	uint32_t start_stop_cmd_id;
 	l_dbus_property_complete_cb_t pending_complete;
 	struct l_dbus_message *pending_message;
+	uint32_t xchg_id;
 =

 	uint8_t listen_country[3];
 	uint8_t listen_oper_class;
@@ -382,7 +383,7 @@ static void p2p_connection_reset(struct p2p_device *dev)
 	netdev_watch_remove(dev->conn_netdev_watch_id);
 =

 	frame_watch_group_remove(dev->wdev_id, FRAME_GROUP_CONNECT);
-	frame_xchg_stop(dev->wdev_id);
+	frame_xchg_stop(dev->wdev_id, dev->xchg_id);
 =

 	if (!dev->enabled || (dev->enabled && dev->start_stop_cmd_id)) {
 		/*
@@ -457,9 +458,9 @@ static void p2p_peer_frame_xchg(struct p2p_peer *peer, =
struct iovec *tx_body,
 		peer->bss->frequency;
 =

 	va_start(args, cb);
-	frame_xchg_startv(dev->wdev_id, frame, freq, retry_interval,
-				resp_timeout, retries_on_ack, group_id,
-				cb, dev, args);
+	dev->xchg_id =3D frame_xchg_startv(dev->wdev_id, frame, freq,
+				retry_interval, resp_timeout, retries_on_ack,
+				group_id, cb, dev, NULL, args);
 	va_end(args);
 =

 	l_free(frame);
-- =

2.21.1

--===============1349241968943703379==--

