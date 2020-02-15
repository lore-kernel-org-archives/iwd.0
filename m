Content-Type: multipart/mixed; boundary="===============1822120178332480418=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/6] frame-xchg: Add a frame exchange API
Date: Sat, 15 Feb 2020 01:17:44 +0100
Message-ID: <20200215001748.20819-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200215001748.20819-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1822120178332480418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a little state machine and a related API, to simplify sending out a
frame, receiving the Ack / No-ack status and (if acked) waiting for a
response frame from the target device, one of a list of possible
frame prefixes.  The nl80211 API for this makes it complicated
enough that this new API seems to be justified, on top of that there's a
quirk when using the brcmfmac driver where the nl80211 response
(containing the operation's cookie), the Tx Status event and the response
Frame event are received from nl80211 in reverse order (not seen with
other drivers so far), further complicating what should be a pretty
simple task.
---
 src/frame-xchg.c | 556 +++++++++++++++++++++++++++++++++++++++++++++++
 src/frame-xchg.h |  15 ++
 2 files changed, 571 insertions(+)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 28b3a506..bb13975a 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -25,6 +25,7 @@
 #endif
 =

 #include <errno.h>
+#include <stdarg.h>
 =

 #include <ell/ell.h>
 =

@@ -79,6 +80,40 @@ struct wdev_info {
 =

 static struct l_queue *wdevs;
 =

+struct frame_xchg_data {
+	uint64_t wdev_id;
+	uint32_t freq;
+	struct mmpdu_header *tx_mpdu;
+	size_t tx_mpdu_len;
+	bool tx_acked;
+	uint64_t cookie;
+	bool have_cookie;
+	bool early_status;
+	struct {
+		struct mmpdu_header *mpdu;
+		const void *body;
+		size_t body_len;
+		int rssi;
+	} early_frame;
+	struct l_timeout *timeout;
+	struct l_queue *rx_watches;
+	frame_xchg_cb_t cb;
+	void *user_data;
+	uint32_t group_id;
+	unsigned int retry_cnt;
+	unsigned int retry_interval;
+	unsigned int resp_timeout;
+	bool in_frame_cb : 1;
+};
+
+struct frame_xchg_watch_data {
+	struct frame_xchg_prefix *prefix;
+	frame_xchg_resp_cb_t cb;
+};
+
+static struct l_queue *frame_xchgs;
+static struct l_genl_family *nl80211;
+
 struct frame_prefix_info {
 	uint16_t frame_type;
 	const uint8_t *body;
@@ -451,6 +486,514 @@ bool frame_watch_wdev_remove(uint64_t wdev_id)
 					&wdev_id) > 0;
 }
 =

+struct frame_watch_handler_check_info {
+	frame_watch_cb_t handler;
+	void *user_data;
+};
+
+static bool frame_watch_item_remove_by_handler(void *data, void *user_data)
+{
+	struct frame_watch *watch =3D data;
+	struct frame_watch_handler_check_info *info =3D user_data;
+
+	if (watch->super.notify !=3D info->handler ||
+			watch->super.notify_data !=3D info->user_data)
+		return false;
+
+	if (watch->super.destroy)
+		watch->super.destroy(watch->super.notify_data);
+
+	frame_watch_free(&watch->super);
+	return true;
+}
+
+/*
+ * Note this one doesn't interact with the kernel watches, only forgets our
+ * struct frame_watch instances.
+ *
+ * Also note empty groups are not automatically destroyed because right now
+ * this is not desired in frame_xchg_reset -- the only user of this functi=
on.
+ */
+static bool frame_watch_remove_by_handler(uint64_t wdev_id, uint32_t group=
_id,
+						frame_watch_cb_t handler,
+						void *user_data)
+{
+	struct watch_group_match_info group_info =3D
+		{ wdev_id, group_id };
+	struct frame_watch_handler_check_info handler_info =3D
+		{ handler, user_data };
+	struct watch_group *group =3D l_queue_find(watch_groups,
+						frame_watch_group_match,
+						&group_info);
+
+	if (!group)
+		return false;
+
+	return l_queue_foreach_remove(group->watches.items,
+					frame_watch_item_remove_by_handler,
+					&handler_info) > 0;
+}
+
+static void frame_xchg_tx_retry(struct frame_xchg_data *fx);
+static void frame_xchg_resp_cb(const struct mmpdu_header *mpdu,
+				const void *body, size_t body_len,
+				int rssi, void *user_data);
+
+static void frame_xchg_wait_cancel(struct frame_xchg_data *fx)
+{
+	struct l_genl_msg *msg;
+
+	if (!fx->have_cookie)
+		return;
+
+	l_debug("");
+
+	msg =3D l_genl_msg_new_sized(NL80211_CMD_FRAME_WAIT_CANCEL, 32);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_WDEV, 8, &fx->wdev_id);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_COOKIE, 8, &fx->cookie);
+	l_genl_family_send(nl80211, msg, NULL, NULL, NULL);
+
+	fx->have_cookie =3D false;
+}
+
+static void frame_xchg_reset(struct frame_xchg_data *fx)
+{
+	fx->in_frame_cb =3D false;
+
+	frame_xchg_wait_cancel(fx);
+
+	if (fx->timeout)
+		l_timeout_remove(fx->timeout);
+
+	l_free(fx->early_frame.mpdu);
+	fx->early_frame.mpdu =3D NULL;
+	l_queue_destroy(fx->rx_watches, l_free);
+	fx->rx_watches =3D NULL;
+	l_free(fx->tx_mpdu);
+	fx->tx_mpdu =3D NULL;
+	frame_watch_remove_by_handler(fx->wdev_id, fx->group_id,
+					frame_xchg_resp_cb, fx);
+}
+
+static void frame_xchg_destroy(struct frame_xchg_data *fx, int err)
+{
+	if (fx->cb)
+		fx->cb(err, fx->user_data);
+
+	frame_xchg_reset(fx);
+	l_free(fx);
+}
+
+static void frame_xchg_cancel(void *user_data)
+{
+	struct frame_xchg_data *fx =3D user_data;
+
+	frame_xchg_destroy(fx, -ECANCELED);
+}
+
+static void frame_xchg_done(struct frame_xchg_data *fx, int err)
+{
+	l_queue_remove(frame_xchgs, fx);
+	frame_xchg_destroy(fx, err);
+}
+
+static void frame_xchg_timeout_destroy(void *user_data)
+{
+	struct frame_xchg_data *fx =3D user_data;
+
+	fx->timeout =3D NULL;
+}
+
+static void frame_xchg_timeout_cb(struct l_timeout *timeout,
+					void *user_data)
+{
+	struct frame_xchg_data *fx =3D user_data;
+
+	l_timeout_remove(fx->timeout);
+	frame_xchg_tx_retry(fx);
+}
+
+static void frame_xchg_resp_timeout_cb(struct l_timeout *timeout,
+					void *user_data)
+{
+	struct frame_xchg_data *fx =3D user_data;
+
+	frame_xchg_done(fx, 0);
+}
+
+static void frame_xchg_tx_status(struct frame_xchg_data *fx, bool acked)
+{
+	if (!acked) {
+		frame_xchg_wait_cancel(fx);
+
+		if (!fx->retry_interval || fx->retry_cnt >=3D 15) {
+			if (!fx->resp_timeout)
+				fx->have_cookie =3D false;
+
+			l_error("Frame tx retry limit reached");
+			frame_xchg_done(fx, -ECOMM);
+			return;
+		}
+
+		l_free(fx->early_frame.mpdu);
+		fx->early_frame.mpdu =3D NULL;
+		fx->timeout =3D l_timeout_create_ms(fx->retry_interval,
+						frame_xchg_timeout_cb, fx,
+						frame_xchg_timeout_destroy);
+		return;
+	}
+
+	if (!fx->resp_timeout) {
+		/* No listen period to cancel */
+		fx->have_cookie =3D false;
+		frame_xchg_done(fx, 0);
+		return;
+	}
+
+	fx->tx_acked =3D true;
+
+	/* Process frames received early for strange drivers */
+	if (fx->early_frame.mpdu) {
+		/* The command is now over so no need to cancel it */
+		fx->have_cookie =3D false;
+
+		l_debug("Processing an early frame");
+		frame_xchg_resp_cb(fx->early_frame.mpdu, fx->early_frame.body,
+					fx->early_frame.body_len,
+					fx->early_frame.rssi, fx);
+
+		frame_xchg_done(fx, 0);
+		return;
+	}
+
+	/* Txed frame ACKed, listen for response frames */
+	fx->timeout =3D l_timeout_create_ms(fx->resp_timeout,
+						frame_xchg_resp_timeout_cb, fx,
+						frame_xchg_timeout_destroy);
+}
+
+static void frame_xchg_tx_cb(struct l_genl_msg *msg, void *user_data)
+{
+	struct frame_xchg_data *fx =3D user_data;
+	int error =3D l_genl_msg_get_error(msg);
+	uint64_t cookie;
+	bool early_status;
+
+	l_debug("err %i", -error);
+
+	if (error < 0) {
+		if (error =3D=3D -EBUSY) {
+			fx->timeout =3D l_timeout_create_ms(fx->retry_interval,
+						frame_xchg_timeout_cb, fx,
+						frame_xchg_timeout_destroy);
+			return;
+		}
+
+		l_error("Frame tx failed: %s (%i)", strerror(-error), -error);
+		goto error;
+	}
+
+	if (L_WARN_ON(nl80211_parse_attrs(msg, NL80211_ATTR_COOKIE, &cookie,
+						NL80211_ATTR_UNSPEC) < 0)) {
+		error =3D -EINVAL;
+		goto error;
+	}
+
+	early_status =3D fx->early_status && cookie =3D=3D fx->cookie;
+	fx->tx_acked =3D early_status && fx->tx_acked;
+	fx->have_cookie =3D true;
+	fx->cookie =3D cookie;
+
+	if (early_status)
+		frame_xchg_tx_status(fx, fx->tx_acked);
+
+	return;
+error:
+	frame_xchg_done(fx, error);
+}
+
+static void frame_xchg_tx_retry(struct frame_xchg_data *fx)
+{
+	struct l_genl_msg *msg;
+	uint32_t cmd_id;
+	uint32_t duration =3D fx->resp_timeout;
+
+	/*
+	 * TODO: in Station, AP, P2P-Client, GO or Ad-Hoc modes if we're
+	 * transmitting the frame on the BSS's operating channel we can skip
+	 * NL80211_ATTR_DURATION and we should still receive the frames
+	 * without potentially interfering with other operations.
+	 *
+	 * TODO: we may want to react to NL80211_CMD_CANCEL_REMAIN_ON_CHANNEL
+	 * in the group socket's unicast handler.
+	 */
+
+	msg =3D l_genl_msg_new_sized(NL80211_CMD_FRAME, 128 + fx->tx_mpdu_len);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_WDEV, 8, &fx->wdev_id);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY_FREQ, 4, &fx->freq);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_OFFCHANNEL_TX_OK, 0, NULL);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_TX_NO_CCK_RATE, 0, NULL);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME,
+				fx->tx_mpdu_len, fx->tx_mpdu);
+
+	if (duration)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_DURATION, 4,
+					&duration);
+
+	cmd_id =3D l_genl_family_send(nl80211, msg, frame_xchg_tx_cb, fx, NULL);
+	if (!cmd_id) {
+		l_error("Error sending frame");
+		l_genl_msg_unref(msg);
+		frame_xchg_done(fx, -EIO);
+		return;
+	}
+
+	fx->tx_acked =3D false;
+	fx->have_cookie =3D false;
+	fx->early_status =3D false;
+	fx->retry_cnt++;
+}
+
+static void frame_xchg_resp_cb(const struct mmpdu_header *mpdu,
+				const void *body, size_t body_len,
+				int rssi, void *user_data)
+{
+	struct frame_xchg_data *fx =3D user_data;
+	const struct l_queue_entry *entry;
+	size_t hdr_len;
+
+	l_debug("");
+
+	if (memcmp(mpdu->address_1, fx->tx_mpdu->address_2, 6))
+		return;
+
+	if (memcmp(mpdu->address_2, fx->tx_mpdu->address_1, 6))
+		return;
+
+	/*
+	 * Is the received frame's BSSID same as the transmitted frame's
+	 * BSSID, may have to be moved to the user callback if there are
+	 * usages where this is false.  Some drivers (brcmfmac) can't
+	 * report the BSSID so check for all-zeros too.
+	 */
+	if (memcmp(mpdu->address_3, fx->tx_mpdu->address_3, 6) &&
+			!util_mem_is_zero(mpdu->address_3, 6))
+		return;
+
+	for (entry =3D l_queue_get_entries(fx->rx_watches);
+			entry; entry =3D entry->next) {
+		struct frame_xchg_watch_data *watch =3D entry->data;
+		bool done;
+
+		if (body_len < watch->prefix->len ||
+				memcmp(body, watch->prefix->data,
+					watch->prefix->len))
+			continue;
+
+		if (!fx->tx_acked)
+			goto early_frame;
+
+		fx->in_frame_cb =3D true;
+		done =3D watch->cb(mpdu, body, body_len, rssi, fx->user_data);
+
+		/*
+		 * If the callback has started a new frame exchange it will
+		 * have reset and taken over the state variables and we need
+		 * to just exit without touching anything.
+		 */
+		if (!fx->in_frame_cb)
+			return;
+
+		fx->in_frame_cb =3D false;
+
+		if (done) {
+			fx->cb =3D NULL;
+			frame_xchg_done(fx, 0);
+			return;
+		}
+	}
+
+	return;
+
+early_frame:
+	/*
+	 * Work around the strange order of events seen with the brcmfmac
+	 * driver where we receive the response frames before the frame
+	 * Tx status, which in turn is receive before the Tx callback with
+	 * the operation cookie... rather then the reverse.
+	 * Save the response frame to be processed in the Tx done callback.
+	 */
+	if (fx->early_frame.mpdu)
+		return;
+
+	hdr_len =3D (const uint8_t *) body - (const uint8_t *) mpdu;
+	fx->early_frame.mpdu =3D l_memdup(mpdu, body_len + hdr_len);
+	fx->early_frame.body =3D (const uint8_t *) fx->early_frame.mpdu + hdr_len;
+	fx->early_frame.body_len =3D body_len;
+	fx->early_frame.rssi =3D rssi;
+}
+
+static bool frame_xchg_match(const void *a, const void *b)
+{
+	const struct frame_xchg_data *fx =3D a;
+	const uint64_t *wdev_id =3D b;
+
+	return fx->wdev_id =3D=3D *wdev_id;
+}
+
+/*
+ * Send an action frame described by @frame.  If @retry_interval is
+ * non-zero and we receive no ACK from @peer to any of the retransmissions
+ * done in the kernel (at a high rate), retry after @retry_interval
+ * milliseconds from the time the kernel gave up.  If no ACK is received
+ * after all the retransmissions, call @cb with a non-zero error number.
+ * Otherwise, if @resp_timeout is non-zero, remain on the same channel
+ * and report any response frames from the frame's destination address
+ * that match provided prefixes, to the corresponding callbacks.  Do so
+ * for @resp_timeout milliseconds from the ACK receival or until a frame
+ * callback returns @true.  Call @cb when @resp_timeout runs out and
+ * no frame callback returned @true, or immediately after the ACK if
+ * @resp_timeout was 0.  @frame is an iovec array terminated by an iovec
+ * struct with NULL-iov_base.
+ */
+void frame_xchg_startv(uint64_t wdev_id, struct iovec *frame, uint32_t fre=
q,
+			unsigned int retry_interval, unsigned int resp_timeout,
+			uint32_t group_id, frame_xchg_cb_t cb, void *user_data,
+			va_list resp_args)
+{
+	struct frame_xchg_data *fx;
+	size_t frame_len;
+	struct iovec *iov;
+	uint8_t *ptr;
+	struct mmpdu_header *mpdu;
+
+	for (frame_len =3D 0, iov =3D frame; iov->iov_base; iov++)
+		frame_len +=3D iov->iov_len;
+
+	if (frame_len < sizeof(*mpdu)) {
+		l_error("Frame too short");
+		cb(-EMSGSIZE, user_data);
+		return;
+	}
+
+	fx =3D l_queue_find(frame_xchgs, frame_xchg_match, &wdev_id);
+
+	if (fx) {
+		/*
+		 * If a frame callback calls us assume it's the end of
+		 * that earlier frame exchange and the start of a new one.
+		 */
+		if (fx->in_frame_cb)
+			frame_xchg_reset(fx);
+		else {
+			l_error("Frame exchange in progress");
+			cb(-EBUSY, user_data);
+			return;
+		}
+	} else {
+		fx =3D l_new(struct frame_xchg_data, 1);
+
+		if (!frame_xchgs)
+			frame_xchgs =3D l_queue_new();
+
+		l_queue_push_tail(frame_xchgs, fx);
+	}
+
+	fx->wdev_id =3D wdev_id;
+	fx->freq =3D freq;
+	fx->retry_interval =3D retry_interval;
+	fx->resp_timeout =3D resp_timeout;
+	fx->cb =3D cb;
+	fx->user_data =3D user_data;
+	fx->group_id =3D group_id;
+
+	fx->tx_mpdu =3D l_malloc(frame_len);
+	fx->tx_mpdu_len =3D frame_len;
+	ptr =3D (uint8_t *) fx->tx_mpdu;
+
+	for (iov =3D frame; iov->iov_base; ptr +=3D iov->iov_len, iov++)
+		memcpy(ptr, iov->iov_base, iov->iov_len);
+
+	/*
+	 * Subscribe to the response frames now instead of in the ACK
+	 * callback to save ourselves race condition considerations.
+	 */
+	while (1) {
+		struct frame_xchg_prefix *prefix;
+		struct frame_xchg_watch_data *watch;
+
+		prefix =3D va_arg(resp_args, struct frame_xchg_prefix *);
+		if (!prefix)
+			break;
+
+		watch =3D l_new(struct frame_xchg_watch_data, 1);
+		watch->prefix =3D prefix;
+		watch->cb =3D va_arg(resp_args, void *);
+		frame_watch_add(wdev_id, group_id, 0x00d0,
+				prefix->data, prefix->len,
+				frame_xchg_resp_cb, fx, NULL);
+
+		if (!fx->rx_watches)
+			fx->rx_watches =3D l_queue_new();
+
+		l_queue_push_tail(fx->rx_watches, watch);
+	}
+
+	fx->retry_cnt =3D 0;
+	frame_xchg_tx_retry(fx);
+}
+
+void frame_xchg_stop(uint64_t wdev_id)
+{
+	struct frame_xchg_data *fx =3D
+		l_queue_remove_if(frame_xchgs, frame_xchg_match, &wdev_id);
+
+	if (!fx)
+		return;
+
+	frame_xchg_reset(fx);
+	l_free(fx);
+}
+
+static void frame_xchg_mlme_notify(struct l_genl_msg *msg, void *user_data)
+{
+	uint64_t wdev_id;
+	struct frame_xchg_data *fx;
+	uint64_t cookie;
+	bool ack;
+	uint8_t cmd =3D l_genl_msg_get_command(msg);
+
+	switch (cmd) {
+	case NL80211_CMD_FRAME_TX_STATUS:
+		if (nl80211_parse_attrs(msg, NL80211_ATTR_WDEV, &wdev_id,
+					NL80211_ATTR_COOKIE, &cookie,
+					NL80211_ATTR_ACK, &ack,
+					NL80211_ATTR_UNSPEC) < 0)
+			return;
+
+		l_debug("Received %s", ack ? "an ACK" : "no ACK");
+
+		fx =3D l_queue_find(frame_xchgs, frame_xchg_match, &wdev_id);
+		if (!fx)
+			return;
+
+		if (fx->have_cookie && cookie =3D=3D fx->cookie && !fx->tx_acked)
+			frame_xchg_tx_status(fx, ack);
+		else if (!fx->have_cookie && !fx->tx_acked) {
+			/*
+			 * Save the information about the frame's ACK status
+			 * to be processed in frame_xchg_tx_cb if we were
+			 * called before it (happens on brcmfmac).
+			 */
+			fx->tx_acked =3D ack;
+			fx->cookie =3D cookie;
+			fx->early_status =3D true;
+		}
+
+		break;
+	}
+}
+
 static bool frame_xchg_wdev_match(const void *a, const void *b)
 {
 	const struct wdev_info *wdev =3D a;
@@ -525,8 +1068,17 @@ static int frame_xchg_init(void)
 		return -EIO;
 	}
 =

+	if (!l_genl_family_register(default_group->nl80211, "mlme",
+					frame_xchg_mlme_notify, NULL, NULL)) {
+		l_error("Registering for MLME notification failed");
+		frame_watch_group_destroy(default_group);
+		default_group =3D NULL;
+		return -EIO;
+	}
+
 	watch_groups =3D l_queue_new();
 	l_queue_push_tail(watch_groups, default_group);
+	nl80211 =3D default_group->nl80211;
 =

 	return 0;
 }
@@ -535,9 +1087,13 @@ static void frame_xchg_exit(void)
 {
 	l_queue_destroy(watch_groups, frame_watch_group_destroy);
 	watch_groups =3D NULL;
+	nl80211 =3D NULL;
 =

 	l_queue_destroy(wdevs, l_free);
 	wdevs =3D NULL;
+
+	l_queue_destroy(frame_xchgs, frame_xchg_cancel);
+	frame_xchgs =3D NULL;
 }
 =

 IWD_MODULE(frame_xchg, frame_xchg_init, frame_xchg_exit);
diff --git a/src/frame-xchg.h b/src/frame-xchg.h
index 1875bd22..1855492c 100644
--- a/src/frame-xchg.h
+++ b/src/frame-xchg.h
@@ -25,11 +25,26 @@ struct mmpdu_header;
 typedef void (*frame_watch_cb_t)(const struct mmpdu_header *frame,
 					const void *body, size_t body_len,
 					int rssi, void *user_data);
+typedef bool (*frame_xchg_resp_cb_t)(const struct mmpdu_header *frame,
+					const void *body, size_t body_len,
+					int rssi, void *user_data);
+typedef void (*frame_xchg_cb_t)(int err, void *user_data);
 typedef void (*frame_xchg_destroy_func_t)(void *user_data);
 =

+struct frame_xchg_prefix {
+	const uint8_t *data;
+	size_t len;
+};
+
 bool frame_watch_add(uint64_t wdev_id, uint32_t group, uint16_t frame_type,
 			const uint8_t *prefix, size_t prefix_len,
 			frame_watch_cb_t handler, void *user_data,
 			frame_xchg_destroy_func_t destroy);
 bool frame_watch_group_remove(uint64_t wdev_id, uint32_t group);
 bool frame_watch_wdev_remove(uint64_t wdev_id);
+
+void frame_xchg_startv(uint64_t wdev_id, struct iovec *frame, uint32_t fre=
q,
+			unsigned int retry_interval, unsigned int resp_timeout,
+			uint32_t group_id, frame_xchg_cb_t cb, void *user_data,
+			va_list resp_args);
+void frame_xchg_stop(uint64_t wdev_id);
-- =

2.20.1

--===============1822120178332480418==--

