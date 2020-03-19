Content-Type: multipart/mixed; boundary="===============2112390177282631015=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/9] frame-xchg: Add facility to keep retransmitting after ACK
Date: Thu, 19 Mar 2020 22:12:10 +0100
Message-ID: <20200319211218.32083-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2112390177282631015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In some cases a P2P peer will ACK our frame but not reply on the first
attempt, and other implementations seem to handle this by going back to
retransmitting the frame at a high rate until it gets ACKed again, at
which point they will again give the peer a longer time to tx the
response frame.  Implement the same logic here by adding a
retries_on_ack parameter that takes the number of additional times we
want to restart the normal retransmit counter after we received no
response frame on the first attempt.  So passing 0 maintains the
current behaviour, 1 for 1 extra attempt, etc.

In effect we may retransmit a frame about 15 * (retry_on_ack + 1) *
<in-kernel retransmit limit> times.  The kernel/driver retransmits a
frame a number of times if there's no ACK (I've seen about 20 normally)
at a high frequency, if that fails we retry the whole process 15 times
inside frame-xchg.c and if we still get no ACK at any point, we give up.
If we do get an ACK, we wait for a response frame and if we don't get
that we will optionally reset the retry counter and restart the whole
thing retry_on_ack times.
---
 src/frame-xchg.c | 61 +++++++++++++++++++++++++++++++++---------------
 src/frame-xchg.h |  4 ++--
 2 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index d69fff7c..a5a80ca2 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -107,6 +107,7 @@ struct frame_xchg_data {
 	unsigned int retry_cnt;
 	unsigned int retry_interval;
 	unsigned int resp_timeout;
+	unsigned int retries_on_ack;
 	bool in_frame_cb : 1;
 	bool stale : 1;
 };
@@ -726,6 +727,9 @@ static bool frame_watch_remove_by_handler(uint64_t wdev=
_id, uint32_t group_id,
 }
 =

 static void frame_xchg_tx_retry(struct frame_xchg_data *fx);
+static bool frame_xchg_resp_handle(const struct mmpdu_header *mpdu,
+					const void *body, size_t body_len,
+					int rssi, void *user_data);
 static void frame_xchg_resp_cb(const struct mmpdu_header *mpdu,
 				const void *body, size_t body_len,
 				int rssi, void *user_data);
@@ -805,12 +809,20 @@ static void frame_xchg_timeout_cb(struct l_timeout *t=
imeout,
 	frame_xchg_tx_retry(fx);
 }
 =

-static void frame_xchg_resp_timeout_cb(struct l_timeout *timeout,
+static void frame_xchg_listen_end_cb(struct l_timeout *timeout,
 					void *user_data)
 {
 	struct frame_xchg_data *fx =3D user_data;
 =

-	frame_xchg_done(fx, 0);
+	if (!fx->retries_on_ack) {
+		frame_xchg_done(fx, 0);
+		return;
+	}
+
+	l_timeout_remove(fx->timeout);
+	fx->retries_on_ack--;
+	fx->retry_cnt =3D 0;
+	frame_xchg_tx_retry(fx);
 }
 =

 static void frame_xchg_tx_status(struct frame_xchg_data *fx, bool acked)
@@ -850,17 +862,19 @@ static void frame_xchg_tx_status(struct frame_xchg_da=
ta *fx, bool acked)
 		fx->have_cookie =3D false;
 =

 		l_debug("Processing an early frame");
-		frame_xchg_resp_cb(fx->early_frame.mpdu, fx->early_frame.body,
-					fx->early_frame.body_len,
-					fx->early_frame.rssi, fx);
 =

-		frame_xchg_done(fx, 0);
+		if (frame_xchg_resp_handle(fx->early_frame.mpdu, fx->early_frame.body,
+						fx->early_frame.body_len,
+						fx->early_frame.rssi, fx))
+			return;
+
+		frame_xchg_listen_end_cb(NULL, fx);
 		return;
 	}
 =

 	/* Txed frame ACKed, listen for response frames */
 	fx->timeout =3D l_timeout_create_ms(fx->resp_timeout,
-						frame_xchg_resp_timeout_cb, fx,
+						frame_xchg_listen_end_cb, fx,
 						frame_xchg_timeout_destroy);
 }
 =

@@ -946,9 +960,9 @@ static void frame_xchg_tx_retry(struct frame_xchg_data =
*fx)
 	fx->retry_cnt++;
 }
 =

-static void frame_xchg_resp_cb(const struct mmpdu_header *mpdu,
-				const void *body, size_t body_len,
-				int rssi, void *user_data)
+static bool frame_xchg_resp_handle(const struct mmpdu_header *mpdu,
+					const void *body, size_t body_len,
+					int rssi, void *user_data)
 {
 	struct frame_xchg_data *fx =3D user_data;
 	const struct l_queue_entry *entry;
@@ -957,10 +971,10 @@ static void frame_xchg_resp_cb(const struct mmpdu_hea=
der *mpdu,
 	l_debug("");
 =

 	if (memcmp(mpdu->address_1, fx->tx_mpdu->address_2, 6))
-		return;
+		return false;
 =

 	if (memcmp(mpdu->address_2, fx->tx_mpdu->address_1, 6))
-		return;
+		return false;
 =

 	/*
 	 * Is the received frame's BSSID same as the transmitted frame's
@@ -970,7 +984,7 @@ static void frame_xchg_resp_cb(const struct mmpdu_heade=
r *mpdu,
 	 */
 	if (memcmp(mpdu->address_3, fx->tx_mpdu->address_3, 6) &&
 			!util_mem_is_zero(mpdu->address_3, 6))
-		return;
+		return false;
 =

 	for (entry =3D l_queue_get_entries(fx->rx_watches);
 			entry; entry =3D entry->next) {
@@ -994,18 +1008,18 @@ static void frame_xchg_resp_cb(const struct mmpdu_he=
ader *mpdu,
 		 * to just exit without touching anything.
 		 */
 		if (!fx->in_frame_cb)
-			return;
+			return true;
 =

 		fx->in_frame_cb =3D false;
 =

 		if (done || fx->stale) {
 			fx->cb =3D NULL;
 			frame_xchg_done(fx, 0);
-			return;
+			return true;
 		}
 	}
 =

-	return;
+	return false;
 =

 early_frame:
 	/*
@@ -1016,13 +1030,21 @@ early_frame:
 	 * Save the response frame to be processed in the Tx done callback.
 	 */
 	if (fx->early_frame.mpdu)
-		return;
+		return false;
 =

 	hdr_len =3D (const uint8_t *) body - (const uint8_t *) mpdu;
 	fx->early_frame.mpdu =3D l_memdup(mpdu, body_len + hdr_len);
 	fx->early_frame.body =3D (const uint8_t *) fx->early_frame.mpdu + hdr_len;
 	fx->early_frame.body_len =3D body_len;
 	fx->early_frame.rssi =3D rssi;
+	return false;
+}
+
+static void frame_xchg_resp_cb(const struct mmpdu_header *mpdu,
+				const void *body, size_t body_len,
+				int rssi, void *user_data)
+{
+	frame_xchg_resp_handle(mpdu, body, body_len, rssi, user_data);
 }
 =

 static bool frame_xchg_match(const void *a, const void *b)
@@ -1050,8 +1072,8 @@ static bool frame_xchg_match(const void *a, const voi=
d *b)
  */
 void frame_xchg_startv(uint64_t wdev_id, struct iovec *frame, uint32_t fre=
q,
 			unsigned int retry_interval, unsigned int resp_timeout,
-			uint32_t group_id, frame_xchg_cb_t cb, void *user_data,
-			va_list resp_args)
+			unsigned int retries_on_ack, uint32_t group_id,
+			frame_xchg_cb_t cb, void *user_data, va_list resp_args)
 {
 	struct frame_xchg_data *fx;
 	size_t frame_len;
@@ -1095,6 +1117,7 @@ void frame_xchg_startv(uint64_t wdev_id, struct iovec=
 *frame, uint32_t freq,
 	fx->freq =3D freq;
 	fx->retry_interval =3D retry_interval;
 	fx->resp_timeout =3D resp_timeout;
+	fx->retries_on_ack =3D retries_on_ack;
 	fx->cb =3D cb;
 	fx->user_data =3D user_data;
 	fx->group_id =3D group_id;
diff --git a/src/frame-xchg.h b/src/frame-xchg.h
index 1855492c..93d528ae 100644
--- a/src/frame-xchg.h
+++ b/src/frame-xchg.h
@@ -45,6 +45,6 @@ bool frame_watch_wdev_remove(uint64_t wdev_id);
 =

 void frame_xchg_startv(uint64_t wdev_id, struct iovec *frame, uint32_t fre=
q,
 			unsigned int retry_interval, unsigned int resp_timeout,
-			uint32_t group_id, frame_xchg_cb_t cb, void *user_data,
-			va_list resp_args);
+			unsigned int retries_on_ack, uint32_t group_id,
+			frame_xchg_cb_t cb, void *user_data, va_list resp_args);
 void frame_xchg_stop(uint64_t wdev_id);
-- =

2.20.1

--===============2112390177282631015==--

