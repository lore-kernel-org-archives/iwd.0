Content-Type: multipart/mixed; boundary="===============6816397714124295978=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/4] dpp: handle sending a frame after ROC ends
Date: Fri, 15 Apr 2022 09:59:18 -0700
Message-ID: <20220415165921.9892-1-prestwoj@gmail.com>

--===============6816397714124295978==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a potential corner case of an offchannel frame callback
being called after ROC has ended.

This could happen in theory if a received frame is queued right as
the ROC session expires. If the ROC cancel event makes it to user
space before the frame IWD will schedule another ROC then receive
the frame. This doesn't prevent IWD from sending out another
frame since OFFCHANNEL_TX_OK is used, but it will prevent IWD from
receiving a response frame since no dwell duration is used with DPP.

To handle this an roc_started bool was added to the dpp_sm which
tracks the ROC state. If dpp_send_frame is called when roc_started
is false the frame will be saved and sent out once the ROC session
is started again.
---
 src/dpp.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/src/dpp.c b/src/dpp.c
index 1719a89d..e817ca5a 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -138,12 +138,39 @@ struct dpp_sm {
 	uint32_t connect_scan_id;
 	uint64_t frame_cookie;
 	uint8_t frame_retry;
+	void *frame_pending;
+	size_t frame_size;
 =

 	struct l_dbus_message *pending;
 =

 	bool mcast_support : 1;
+	bool roc_started : 1;
 };
 =

+static void *dpp_serialize_iovec(struct iovec *iov, size_t iov_len,
+				size_t *out_len)
+{
+	unsigned int i;
+	size_t size =3D 0;
+	uint8_t *ret;
+
+	for (i =3D 0; i < iov_len; i++)
+		size +=3D iov[i].iov_len;
+
+	ret =3D l_malloc(size);
+	size =3D 0;
+
+	for (i =3D 0; i < iov_len; i++) {
+		memcpy(ret + size, iov[i].iov_base, iov[i].iov_len);
+		size +=3D iov[i].iov_len;
+	}
+
+	if (out_len)
+		*out_len =3D size;
+
+	return ret;
+}
+
 static void dpp_free_auth_data(struct dpp_sm *dpp)
 {
 	if (dpp->own_proto_public) {
@@ -209,6 +236,11 @@ static void dpp_reset(struct dpp_sm *dpp)
 		dpp->peer_asn1 =3D NULL;
 	}
 =

+	if (dpp->frame_pending) {
+		l_free(dpp->frame_pending);
+		dpp->frame_pending =3D NULL;
+	}
+
 	dpp->state =3D DPP_STATE_NOTHING;
 	dpp->new_freq =3D 0;
 	dpp->frame_retry =3D 0;
@@ -267,6 +299,19 @@ static void dpp_send_frame(struct dpp_sm *dpp,
 {
 	struct l_genl_msg *msg;
 =

+	/*
+	 * A received frame could potentially come in after the ROC session has
+	 * ended. In this case the frame needs to be stored until ROC is started
+	 * and sent at that time. The offchannel_id is also checked since
+	 * this is not applicable when DPP is in a responder role waiting
+	 * on the currently connected channel i.e. offchannel is never used.
+	 */
+	if (!dpp->roc_started && dpp->offchannel_id) {
+		dpp->frame_pending =3D dpp_serialize_iovec(iov, iov_len,
+							&dpp->frame_size);
+		return;
+	}
+
 	msg =3D l_genl_msg_new_sized(NL80211_CMD_FRAME, 512);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_WDEV, 8, &dpp->wdev_id);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY_FREQ, 4, &freq);
@@ -281,6 +326,20 @@ static void dpp_send_frame(struct dpp_sm *dpp,
 	}
 }
 =

+static void dpp_frame_retry(struct dpp_sm *dpp)
+{
+	struct iovec iov;
+
+	iov.iov_base =3D dpp->frame_pending;
+	iov.iov_len =3D dpp->frame_size;
+
+	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
+
+	l_free(dpp->frame_pending);
+	dpp->frame_pending =3D NULL;
+}
+
+
 static size_t dpp_build_header(const uint8_t *src, const uint8_t *dest,
 				enum dpp_frame_type type,
 				uint8_t buf[static 32])
@@ -1360,6 +1419,13 @@ static void dpp_roc_started(void *user_data)
 	 *   the authenticate response now.
 	 */
 =

+	dpp->roc_started =3D true;
+
+	if (dpp->frame_pending) {
+		dpp_frame_retry(dpp);
+		return;
+	}
+
 	switch (dpp->state) {
 	case DPP_STATE_PRESENCE:
 		if (dpp->role =3D=3D DPP_CAPABILITY_CONFIGURATOR)
@@ -1409,6 +1475,7 @@ static void dpp_presence_timeout(int error, void *use=
r_data)
 	struct dpp_sm *dpp =3D user_data;
 =

 	dpp->offchannel_id =3D 0;
+	dpp->roc_started =3D false;
 =

 	/*
 	 * If cancelled this is likely due to netdev going down or from Stop().
-- =

2.34.1

--===============6816397714124295978==--

