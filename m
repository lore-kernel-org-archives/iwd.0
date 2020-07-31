Content-Type: multipart/mixed; boundary="===============5825404074546242082=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 03/13] frame-xchg: Re-add frame_xchg_stop
Date: Fri, 31 Jul 2020 03:31:26 +0200
Message-ID: <20200731013136.65057-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200731013136.65057-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5825404074546242082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In 98cf2bf3ece070bfe7ff45670b95d24b34bf3e13 frame_xchg_stop was removed
and its use in p2p.c was changed to frame_xchg_cancel with the slight
complication that the ID returned by frame_xchg_start had do be stored.
Re-add frame_xchg_stop, (renamed as frame_xchg_stop_wdev) to simplify
this bit in p2p.c.
---
 src/frame-xchg.c | 18 ++++++++++++++++++
 src/frame-xchg.h |  1 +
 src/p2p.c        | 17 ++---------------
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 8abcc8a7..2ea8504a 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -1188,6 +1188,24 @@ uint32_t frame_xchg_startv(uint64_t wdev_id, struct =
iovec *frame, uint32_t freq,
 					&fx->work, 0, &work_ops);
 }
 =

+static bool frame_xchg_cancel_by_wdev(void *data, void *user_data)
+{
+	struct frame_xchg_data *fx =3D data;
+	const uint64_t *wdev_id =3D user_data;
+
+	if (fx->wdev_id !=3D *wdev_id)
+		return false;
+
+	wiphy_radio_work_done(wiphy_find_by_wdev(fx->wdev_id), fx->work.id);
+	return true;
+}
+
+void frame_xchg_stop_wdev(uint64_t wdev_id)
+{
+	l_queue_foreach_remove(frame_xchgs, frame_xchg_cancel_by_wdev,
+				&wdev_id);
+}
+
 static bool frame_xchg_match_id(const void *a, const void *b)
 {
 	const struct frame_xchg_data *fx =3D a;
diff --git a/src/frame-xchg.h b/src/frame-xchg.h
index ba4dc61a..e3748538 100644
--- a/src/frame-xchg.h
+++ b/src/frame-xchg.h
@@ -53,4 +53,5 @@ uint32_t frame_xchg_startv(uint64_t wdev_id, struct iovec=
 *frame, uint32_t freq,
 			unsigned int retries_on_ack, uint32_t group_id,
 			frame_xchg_cb_t cb, void *user_data,
 			frame_xchg_destroy_func_t destroy, va_list resp_args);
+void frame_xchg_stop_wdev(uint64_t wdev_id);
 void frame_xchg_cancel(uint32_t id);
diff --git a/src/p2p.c b/src/p2p.c
index 58027fc6..e327cba9 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -68,7 +68,6 @@ struct p2p_device {
 	uint32_t start_stop_cmd_id;
 	l_dbus_property_complete_cb_t pending_complete;
 	struct l_dbus_message *pending_message;
-	uint32_t xchg_id;
 =

 	uint8_t listen_country[3];
 	uint8_t listen_oper_class;
@@ -471,11 +470,7 @@ static void p2p_connection_reset(struct p2p_device *de=
v)
 	netdev_watch_remove(dev->conn_netdev_watch_id);
 =

 	frame_watch_group_remove(dev->wdev_id, FRAME_GROUP_CONNECT);
-
-	if (dev->xchg_id) {
-		frame_xchg_cancel(dev->xchg_id);
-		dev->xchg_id =3D 0;
-	}
+	frame_xchg_stop_wdev(dev->wdev_id);
 =

 	if (!dev->enabled || (dev->enabled && dev->start_stop_cmd_id)) {
 		/*
@@ -557,7 +552,7 @@ static void p2p_peer_frame_xchg(struct p2p_peer *peer, =
struct iovec *tx_body,
 =

 	va_start(args, cb);
 =

-	dev->xchg_id =3D frame_xchg_startv(dev->wdev_id, frame, freq,
+	frame_xchg_startv(dev->wdev_id, frame, freq,
 				retry_interval, resp_timeout, retries_on_ack,
 				group_id, cb, dev, NULL, args);
 	va_end(args);
@@ -1313,17 +1308,11 @@ static void p2p_go_negotiation_resp_done(int error,=
 void *user_data)
 	else
 		l_error("No GO Negotiation Confirmation frame received");
 =

-	dev->xchg_id =3D 0;
-
 	p2p_connect_failed(dev);
 }
 =

 static void p2p_go_negotiation_resp_err_done(int error, void *user_data)
 {
-	struct p2p_device *dev =3D user_data;
-
-	dev->xchg_id =3D 0;
-
 	if (error)
 		l_error("Sending the GO Negotiation Response failed: %s (%i)",
 			strerror(-error), -error);
@@ -1573,8 +1562,6 @@ static bool p2p_go_negotiation_confirm_cb(const struc=
t mmpdu_header *mpdu,
 =

 	l_debug("");
 =

-	dev->xchg_id =3D 0;
-
 	if (body_len < 8) {
 		l_error("GO Negotiation Confirmation frame too short");
 		p2p_connect_failed(dev);
-- =

2.25.1

--===============5825404074546242082==--

