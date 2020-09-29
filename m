Content-Type: multipart/mixed; boundary="===============0499670433238349882=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/6] frame-xchg: Cancel NL80211_CMD_FRAME commands when
 interrupted
Date: Tue, 29 Sep 2020 18:37:05 +0200
Message-ID: <20200929163717.754459-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200929163717.754459-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0499670433238349882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The callback for the FRAME command was causing a crash in
wiphy_radio_work_done when not cancelled when the wiphy was being
removed from the system.  This was likely to happen if this radio work
item was waiting for another item to finish.  When the first one was
being cancelled due to the wiphy being removed, this one would be
started and immediately stopped by the radio work queue.

Now this crash could be fixed by dropping all frame exchange instances
on an interface that is being removed which is easy to do, but properly
cancelling the commands saves us the headache of analysing whether
there's a race condition in other situations where a frame exchange is
being aborted.
---
 src/frame-xchg.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index d26e0c54..0e3e330d 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -116,6 +116,7 @@ struct frame_xchg_data {
 	unsigned int retries_on_ack;
 	struct wiphy_radio_work_item work;
 	bool no_cck_rates;
+	unsigned int tx_cmd_id;
 };
 =

 struct frame_xchg_watch_data {
@@ -772,6 +773,9 @@ static void frame_xchg_reset(struct frame_xchg_data *fx)
 	if (fx->timeout)
 		l_timeout_remove(fx->timeout);
 =

+	if (fx->tx_cmd_id)
+		l_genl_family_cancel(nl80211, fx->tx_cmd_id);
+
 	l_free(fx->early_frame.mpdu);
 	fx->early_frame.mpdu =3D NULL;
 	l_queue_destroy(fx->rx_watches, l_free);
@@ -930,12 +934,18 @@ error:
 	frame_xchg_done(fx, error);
 }
 =

+static void frame_xchg_tx_destroy(void *user_data)
+{
+	struct frame_xchg_data *fx =3D user_data;
+
+	fx->tx_cmd_id =3D 0;
+}
+
 static bool frame_xchg_tx_retry(struct wiphy_radio_work_item *item)
 {
 	struct frame_xchg_data *fx =3D l_container_of(item,
 						struct frame_xchg_data, work);
 	struct l_genl_msg *msg;
-	uint32_t cmd_id;
 	uint32_t duration =3D fx->resp_timeout;
 =

 	/*
@@ -963,8 +973,9 @@ static bool frame_xchg_tx_retry(struct wiphy_radio_work=
_item *item)
 		l_genl_msg_append_attr(msg, NL80211_ATTR_DURATION, 4,
 					&duration);
 =

-	cmd_id =3D l_genl_family_send(nl80211, msg, frame_xchg_tx_cb, fx, NULL);
-	if (!cmd_id) {
+	fx->tx_cmd_id =3D l_genl_family_send(nl80211, msg, frame_xchg_tx_cb, fx,
+						frame_xchg_tx_destroy);
+	if (!fx->tx_cmd_id) {
 		l_error("Error sending frame");
 		l_genl_msg_unref(msg);
 		frame_xchg_done(fx, -EIO);
-- =

2.25.1

--===============0499670433238349882==--

