Content-Type: multipart/mixed; boundary="===============6968050329841179496=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/6] frame-xchg: Add no-cck-rate flag only for P2P interfaces
Date: Tue, 29 Sep 2020 18:37:04 +0200
Message-ID: <20200929163717.754459-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6968050329841179496==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We want to use this flag only on the interfaces with one of the three
P2P iftypes so set the flag automatically depending on the iftype from
the last 'config' notification.
---
 src/frame-xchg.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 2ea8504a..d26e0c54 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -115,6 +115,7 @@ struct frame_xchg_data {
 	unsigned int resp_timeout;
 	unsigned int retries_on_ack;
 	struct wiphy_radio_work_item work;
+	bool no_cck_rates;
 };
 =

 struct frame_xchg_watch_data {
@@ -951,10 +952,13 @@ static bool frame_xchg_tx_retry(struct wiphy_radio_wo=
rk_item *item)
 	l_genl_msg_append_attr(msg, NL80211_ATTR_WDEV, 8, &fx->wdev_id);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY_FREQ, 4, &fx->freq);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_OFFCHANNEL_TX_OK, 0, NULL);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_TX_NO_CCK_RATE, 0, NULL);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME,
 				fx->tx_mpdu_len, fx->tx_mpdu);
 =

+	if (fx->no_cck_rates)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_TX_NO_CCK_RATE, 0,
+					NULL);
+
 	if (duration)
 		l_genl_msg_append_attr(msg, NL80211_ATTR_DURATION, 4,
 					&duration);
@@ -1102,6 +1106,14 @@ static const struct wiphy_radio_work_item_ops work_o=
ps =3D {
 	.destroy =3D frame_xchg_destroy,
 };
 =

+static bool frame_xchg_wdev_match(const void *a, const void *b)
+{
+	const struct wdev_info *wdev =3D a;
+	const uint64_t *id =3D b;
+
+	return wdev->id =3D=3D *id;
+}
+
 uint32_t frame_xchg_startv(uint64_t wdev_id, struct iovec *frame, uint32_t=
 freq,
 			unsigned int retry_interval, unsigned int resp_timeout,
 			unsigned int retries_on_ack, uint32_t group_id,
@@ -1112,6 +1124,7 @@ uint32_t frame_xchg_startv(uint64_t wdev_id, struct i=
ovec *frame, uint32_t freq,
 	size_t frame_len;
 	struct iovec *iov;
 	uint8_t *ptr;
+	struct wdev_info *wdev;
 =

 	for (frame_len =3D 0, iov =3D frame; iov->iov_base; iov++)
 		frame_len +=3D iov->iov_len;
@@ -1150,6 +1163,12 @@ uint32_t frame_xchg_startv(uint64_t wdev_id, struct =
iovec *frame, uint32_t freq,
 	for (iov =3D frame; iov->iov_base; ptr +=3D iov->iov_len, iov++)
 		memcpy(ptr, iov->iov_base, iov->iov_len);
 =

+	wdev =3D l_queue_find(wdevs, frame_xchg_wdev_match, &wdev_id);
+	fx->no_cck_rates =3D wdev &&
+		(wdev->iftype =3D=3D NL80211_IFTYPE_P2P_DEVICE ||
+		 wdev->iftype =3D=3D NL80211_IFTYPE_P2P_CLIENT ||
+		 wdev->iftype =3D=3D NL80211_IFTYPE_P2P_GO);
+
 	/*
 	 * Subscribe to the response frames now instead of in the ACK
 	 * callback to save ourselves race condition considerations.
@@ -1265,14 +1284,6 @@ static void frame_xchg_mlme_notify(struct l_genl_msg=
 *msg, void *user_data)
 	}
 }
 =

-static bool frame_xchg_wdev_match(const void *a, const void *b)
-{
-	const struct wdev_info *wdev =3D a;
-	const uint64_t *id =3D b;
-
-	return wdev->id =3D=3D *id;
-}
-
 static void frame_xchg_config_notify(struct l_genl_msg *msg, void *user_da=
ta)
 {
 	uint64_t wdev_id;
-- =

2.25.1

--===============6968050329841179496==--

