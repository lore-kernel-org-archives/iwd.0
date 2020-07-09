Content-Type: multipart/mixed; boundary="===============7475982162689553482=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/6] frame-xchg: refactor to use wiphy work queue
Date: Wed, 08 Jul 2020 17:04:33 -0700
Message-ID: <20200709000437.32719-2-prestwoj@gmail.com>
In-Reply-To: <20200709000437.32719-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7475982162689553482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In order to first integrate frame-xchg some refactoring needed to
be done. First it is useful to allow queueing frames up rather than
requiring the module (p2p, anqp etc) to wait for the last frame to
finish. This can be aided by radio management but frame-xchg needed
some refactoring as well.

First was getting rid of this fx pointer re-use. It looks like this
was done to save a bit of memory but things get pretty complex
needed to check if the pointer is stale or has been reset. Instead
of this we now just allocate a new pointer each frame-xchg. This
allows for the module to queue multiple requests as well as removes
the complexity of needed to check if the fx pointer is stale.

Next was adding the ability to track frame-xchgs by ID. If a module
can queue up multiple requests it also needs to be able to cancel
them individually vs per-wdev. This comes free with the wiphy work
queue since it returns an ID which can be given directly to the
caller.

Then radio management was simply piped in by adding the
insert/done APIs.
---
 src/frame-xchg.c | 121 +++++++++++++++++++++++------------------------
 src/frame-xchg.h |   6 +--
 src/p2p.c        |  22 +++++++--
 3 files changed, 81 insertions(+), 68 deletions(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index a9c1e4c3..1ba2d907 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -41,6 +41,7 @@
 #include "src/nl80211util.h"
 #include "src/netdev.h"
 #include "src/frame-xchg.h"
+#include "src/wiphy.h"
 =

 #ifndef SOL_NETLINK
 #define SOL_NETLINK 270
@@ -113,8 +114,7 @@ struct frame_xchg_data {
 	unsigned int retry_interval;
 	unsigned int resp_timeout;
 	unsigned int retries_on_ack;
-	bool in_frame_cb : 1;
-	bool stale : 1;
+	struct wiphy_radio_work_item work;
 };
 =

 struct frame_xchg_watch_data {
@@ -726,7 +726,7 @@ static bool frame_watch_remove_by_handler(uint64_t wdev=
_id, uint32_t group_id,
 					&handler_info) > 0;
 }
 =

-static void frame_xchg_tx_retry(struct frame_xchg_data *fx);
+static bool frame_xchg_tx_retry(struct wiphy_radio_work_item *item);
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
@@ -771,9 +768,10 @@ static void frame_xchg_reset(struct frame_xchg_data *f=
x)
 					frame_xchg_resp_cb, fx);
 }
 =

-static void frame_xchg_destroy(void *user_data)
+static void frame_xchg_destroy(struct wiphy_radio_work_item *item)
 {
-	struct frame_xchg_data *fx =3D user_data;
+	struct frame_xchg_data *fx =3D l_container_of(item,
+						struct frame_xchg_data, work);
 =

 	if (fx->destroy)
 		fx->destroy(fx->user_data);
@@ -789,7 +787,7 @@ static void frame_xchg_done(struct frame_xchg_data *fx,=
 int err)
 	if (fx->cb)
 		fx->cb(err, fx->user_data);
 =

-	frame_xchg_destroy(fx);
+	wiphy_radio_work_done(wiphy_find_by_wdev(fx->wdev_id), fx->work.id);
 }
 =

 static void frame_xchg_timeout_destroy(void *user_data)
@@ -805,7 +803,7 @@ static void frame_xchg_timeout_cb(struct l_timeout *tim=
eout,
 	struct frame_xchg_data *fx =3D user_data;
 =

 	l_timeout_remove(fx->timeout);
-	frame_xchg_tx_retry(fx);
+	frame_xchg_tx_retry(&fx->work);
 }
 =

 static void frame_xchg_listen_end_cb(struct l_timeout *timeout,
@@ -821,7 +819,7 @@ static void frame_xchg_listen_end_cb(struct l_timeout *=
timeout,
 	l_timeout_remove(fx->timeout);
 	fx->retries_on_ack--;
 	fx->retry_cnt =3D 0;
-	frame_xchg_tx_retry(fx);
+	frame_xchg_tx_retry(&fx->work);
 }
 =

 static void frame_xchg_tx_status(struct frame_xchg_data *fx, bool acked)
@@ -918,8 +916,10 @@ error:
 	frame_xchg_done(fx, error);
 }
 =

-static void frame_xchg_tx_retry(struct frame_xchg_data *fx)
+static bool frame_xchg_tx_retry(struct wiphy_radio_work_item *item)
 {
+	struct frame_xchg_data *fx =3D l_container_of(item,
+						struct frame_xchg_data, work);
 	struct l_genl_msg *msg;
 	uint32_t cmd_id;
 	uint32_t duration =3D fx->resp_timeout;
@@ -951,13 +951,15 @@ static void frame_xchg_tx_retry(struct frame_xchg_dat=
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
@@ -999,20 +1001,10 @@ static bool frame_xchg_resp_handle(const struct mmpd=
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
@@ -1070,22 +1062,29 @@ static bool frame_xchg_match(const void *a, const v=
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
+static const struct wiphy_radio_work_item_ops work_ops =3D {
+	.do_work =3D frame_xchg_tx_retry,
+	.destroy =3D frame_xchg_destroy,
+};
+
+uint32_t frame_xchg_startv(uint64_t wdev_id, struct iovec *frame, uint32_t=
 freq,
 			unsigned int retry_interval, unsigned int resp_timeout,
 			unsigned int retries_on_ack, uint32_t group_id,
 			frame_xchg_cb_t cb, void *user_data,
@@ -1108,31 +1107,13 @@ void frame_xchg_startv(uint64_t wdev_id, struct iov=
ec *frame, uint32_t freq,
 				frame[0].iov_base)) {
 		l_error("Frame too short");
 		cb(-EMSGSIZE, user_data);
-		return;
+		return 0;
 	}
 =

-	fx =3D l_queue_find(frame_xchgs, frame_xchg_match, &wdev_id);
-
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
+	fx =3D l_new(struct frame_xchg_data, 1);
 =

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
@@ -1177,24 +1158,35 @@ void frame_xchg_startv(uint64_t wdev_id, struct iov=
ec *frame, uint32_t freq,
 	}
 =

 	fx->retry_cnt =3D 0;
-	frame_xchg_tx_retry(fx);
+
+	l_queue_push_tail(frame_xchgs, fx);
+
+	/*
+	 * TODO: Assume any offchannel frames are a high priority (0). This may
+	 * need to be re-examined in the future if other operations (e.g.
+	 * wait on channel) are introduced.
+	 */
+	return wiphy_radio_work_insert(wiphy_find_by_wdev(wdev_id),
+					&fx->work, 0, &work_ops);
+}
+
+static bool frame_xchg_match_id(const void *a, const void *b)
+{
+	const struct frame_xchg_data *fx =3D a;
+	const uint32_t *id =3D b;
+
+	return fx->work.id =3D=3D *id;
 }
 =

-void frame_xchg_stop(uint64_t wdev_id)
+void frame_xchg_cancel(uint32_t id)
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
-	frame_xchg_reset(fx);
-	l_free(fx);
+	wiphy_radio_work_done(wiphy_find_by_wdev(fx->wdev_id), id);
 }
 =

 static void frame_xchg_mlme_notify(struct l_genl_msg *msg, void *user_data)
@@ -1341,13 +1333,20 @@ error:
 	return -EIO;
 }
 =

+static void destroy_xchg_data(void *user_data)
+{
+	struct frame_xchg_data *fx =3D user_data;
+
+	frame_xchg_destroy(&fx->work);
+}
+
 static void frame_xchg_exit(void)
 {
 	struct l_queue *groups =3D watch_groups;
 	struct l_queue *xchgs =3D frame_xchgs;
 =

 	frame_xchgs =3D NULL;
-	l_queue_destroy(xchgs, frame_xchg_destroy);
+	l_queue_destroy(xchgs, destroy_xchg_data);
 =

 	watch_groups =3D NULL;
 	l_queue_destroy(groups, frame_watch_group_destroy);
diff --git a/src/frame-xchg.h b/src/frame-xchg.h
index 55a55f73..ba4dc61a 100644
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
+void frame_xchg_cancel(uint32_t id);
diff --git a/src/p2p.c b/src/p2p.c
index 1c9cb081..b8c299a3 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -68,6 +68,7 @@ struct p2p_device {
 	uint32_t start_stop_cmd_id;
 	l_dbus_property_complete_cb_t pending_complete;
 	struct l_dbus_message *pending_message;
+	uint32_t xchg_id;
 =

 	uint8_t listen_country[3];
 	uint8_t listen_oper_class;
@@ -383,7 +384,11 @@ static void p2p_connection_reset(struct p2p_device *de=
v)
 	netdev_watch_remove(dev->conn_netdev_watch_id);
 =

 	frame_watch_group_remove(dev->wdev_id, FRAME_GROUP_CONNECT);
-	frame_xchg_stop(dev->wdev_id);
+
+	if (dev->xchg_id) {
+		frame_xchg_cancel(dev->xchg_id);
+		dev->xchg_id =3D 0;
+	}
 =

 	if (!dev->enabled || (dev->enabled && dev->start_stop_cmd_id)) {
 		/*
@@ -458,9 +463,10 @@ static void p2p_peer_frame_xchg(struct p2p_peer *peer,=
 struct iovec *tx_body,
 		peer->bss->frequency;
 =

 	va_start(args, cb);
-	frame_xchg_startv(dev->wdev_id, frame, freq, retry_interval,
-				resp_timeout, retries_on_ack, group_id,
-				cb, dev, NULL, args);
+
+	dev->xchg_id =3D frame_xchg_startv(dev->wdev_id, frame, freq,
+				retry_interval, resp_timeout, retries_on_ack,
+				group_id, cb, dev, NULL, args);
 	va_end(args);
 =

 	l_free(frame);
@@ -1175,11 +1181,17 @@ static void p2p_go_negotiation_resp_done(int error,=
 void *user_data)
 	else
 		l_error("No GO Negotiation Confirmation frame received");
 =

+	dev->xchg_id =3D 0;
+
 	p2p_connect_failed(dev);
 }
 =

 static void p2p_go_negotiation_resp_err_done(int error, void *user_data)
 {
+	struct p2p_device *dev =3D user_data;
+
+	dev->xchg_id =3D 0;
+
 	if (error)
 		l_error("Sending the GO Negotiation Response failed: %s (%i)",
 			strerror(-error), -error);
@@ -1272,6 +1284,8 @@ static bool p2p_go_negotiation_confirm_cb(const struc=
t mmpdu_header *mpdu,
 =

 	l_debug("");
 =

+	dev->xchg_id =3D 0;
+
 	if (body_len < 8) {
 		l_error("GO Negotiation Confirmation frame too short");
 		p2p_connect_failed(dev);
-- =

2.21.1

--===============7475982162689553482==--

