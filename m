Content-Type: multipart/mixed; boundary="===============0730919492092922519=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/4] dpp: wait before retransmitting frames with no-ACK
Date: Fri, 15 Apr 2022 09:59:20 -0700
Message-ID: <20220415165921.9892-3-prestwoj@gmail.com>
In-Reply-To: 20220415165921.9892-1-prestwoj@gmail.com

--===============0730919492092922519==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The upstream code immediately retransmitted any no-ACK frames.
This would work in cases where the peer wasn't actively switching
channels (e.g. the ACK was simply lost) but caused unintended
behavior in the case of a channel switch when the peer was not
listening.

If either IWD or the peer needed to switch channels based on the
authenticate request the response may end up not getting ACKed
because the peer is idle, or in the middle of the hardware changing
channels. IWD would get no-ACK and immediately send the frame again
and most likely the same behavior would result. This would very
quickly increment frame_retry past the maximum and DPP would fail.

Instead when no ACK is received wait 1 second before sending out
the next frame. This can re-use the existing frame_pending buffer
and the same logic for re-transmitting.
---
 src/dpp.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 090a3211..b70b9871 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -55,6 +55,7 @@
 #include "src/nl80211util.h"
 =

 #define DPP_FRAME_MAX_RETRIES 5
+#define DPP_FRAME_RETRY_TIMEOUT 1
 =

 static uint32_t netdev_watch;
 static struct l_genl_family *nl80211;
@@ -140,6 +141,7 @@ struct dpp_sm {
 	uint8_t frame_retry;
 	void *frame_pending;
 	size_t frame_size;
+	struct l_timeout *retry_timeout;
 =

 	struct l_dbus_message *pending;
 =

@@ -241,6 +243,11 @@ static void dpp_reset(struct dpp_sm *dpp)
 		dpp->frame_pending =3D NULL;
 	}
 =

+	if (dpp->retry_timeout) {
+		l_timeout_remove(dpp->retry_timeout);
+		dpp->retry_timeout =3D NULL;
+	}
+
 	dpp->state =3D DPP_STATE_NOTHING;
 	dpp->new_freq =3D 0;
 	dpp->frame_retry =3D 0;
@@ -1422,6 +1429,13 @@ static void dpp_roc_started(void *user_data)
 =

 	dpp->roc_started =3D true;
 =

+	/*
+	 * The retry timer indicates a frame was not acked in which case we
+	 * should not change any state or send any frames until that expires.
+	 */
+	if (dpp->retry_timeout)
+		return;
+
 	if (dpp->frame_pending) {
 		dpp_frame_retry(dpp);
 		return;
@@ -2082,6 +2096,25 @@ static bool match_wdev(const void *a, const void *b)
 	return *wdev_id =3D=3D dpp->wdev_id;
 }
 =

+static void dpp_frame_timeout(struct l_timeout *timeout, void *user_data)
+{
+	struct dpp_sm *dpp =3D user_data;
+
+	l_timeout_remove(timeout);
+	dpp->retry_timeout =3D NULL;
+
+	/*
+	 * ROC has not yet started (in between an ROC timeout and starting a
+	 * new session), this will most likely result in the frame failing to
+	 * send. Just bail out now and the roc_started callback will take care
+	 * of sending this out.
+	 */
+	if (!dpp->roc_started)
+		return;
+
+	dpp_frame_retry(dpp);
+}
+
 static void dpp_mlme_notify(struct l_genl_msg *msg, void *user_data)
 {
 	struct dpp_sm *dpp;
@@ -2120,11 +2153,19 @@ static void dpp_mlme_notify(struct l_genl_msg *msg,=
 void *user_data)
 		return;
 	}
 =

-	l_debug("No ACK from peer, re-transmitting");
+	/* This should never happen */
+	if (L_WARN_ON(dpp->frame_pending))
+		return;
+
+	l_debug("No ACK from peer, re-transmitting in %us",
+			DPP_FRAME_RETRY_TIMEOUT);
 =

 	dpp->frame_retry++;
 =

-	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
+	dpp->frame_pending =3D l_memdup(iov.iov_base, iov.iov_len);
+	dpp->frame_size =3D iov.iov_len;
+	dpp->retry_timeout =3D l_timeout_create(DPP_FRAME_RETRY_TIMEOUT,
+						dpp_frame_timeout, dpp, NULL);
 }
 =

 static void dpp_unicast_notify(struct l_genl_msg *msg, void *user_data)
-- =

2.34.1

--===============0730919492092922519==--

