Content-Type: multipart/mixed; boundary="===============5459187133533367222=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 4/5] dpp: refactor calls to offchannel_start into common
 function
Date: Fri, 07 Jan 2022 14:31:11 -0800
Message-ID: <20220107223112.715855-4-prestwoj@gmail.com>
In-Reply-To: 20220107223112.715855-1-prestwoj@gmail.com

--===============5459187133533367222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will aid in channel switching during authentication by allowing
an arbitrary channel to be passed in rather than dpp->current_freq.
---
 src/dpp.c | 203 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 107 insertions(+), 96 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 25359075..68a7d2bf 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1204,6 +1204,112 @@ static bool dpp_check_roles(struct dpp_sm *dpp, uin=
t8_t peer_capa)
 	return true;
 }
 =

+static void dpp_presence_announce(struct dpp_sm *dpp)
+{
+	struct netdev *netdev =3D dpp->netdev;
+	uint8_t hdr[32];
+	uint8_t attrs[32 + 4];
+	uint8_t hash[32];
+	uint8_t *ptr =3D attrs;
+	const uint8_t *addr =3D netdev_get_address(netdev);
+	struct iovec iov[2];
+
+	iov[0].iov_len =3D dpp_build_header(addr, broadcast,
+					DPP_FRAME_PRESENCE_ANNOUNCEMENT, hdr);
+	iov[0].iov_base =3D hdr;
+
+	dpp_hash(L_CHECKSUM_SHA256, hash, 2, "chirp", strlen("chirp"),
+			dpp->pub_asn1, dpp->pub_asn1_len);
+
+	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH, hash, 32);
+
+	iov[1].iov_base =3D attrs;
+	iov[1].iov_len =3D ptr - attrs;
+
+	l_debug("Sending presense annoucement on frequency %u and waiting %u",
+		dpp->current_freq, dpp->dwell);
+
+	dpp_send_frame(netdev_get_wdev_id(netdev), iov, 2, dpp->current_freq);
+}
+
+static void dpp_roc_started(void *user_data)
+{
+	struct dpp_sm *dpp =3D user_data;
+
+	/*
+	 * If not in presence procedure or in a configurator role, just stay
+	 * on channel.
+	 */
+	if (dpp->state !=3D DPP_STATE_PRESENCE ||
+			dpp->role =3D=3D DPP_CAPABILITY_CONFIGURATOR)
+		return;
+
+	dpp_presence_announce(dpp);
+}
+
+static void dpp_start_offchannel(struct dpp_sm *dpp, uint32_t freq);
+
+static void dpp_presence_timeout(int error, void *user_data)
+{
+	struct dpp_sm *dpp =3D user_data;
+
+	dpp->offchannel_id =3D 0;
+
+	/*
+	 * If cancelled this is likely due to netdev going down or from Stop().
+	 * Otherwise there was some other problem which is probably not
+	 * recoverable.
+	 */
+	if (error =3D=3D -ECANCELED)
+		return;
+	else if (error =3D=3D -EIO)
+		goto next_roc;
+	else if (error < 0)
+		goto protocol_failed;
+
+	switch (dpp->state) {
+	case DPP_STATE_PRESENCE:
+		break;
+	case DPP_STATE_NOTHING:
+		/* Protocol already terminated */
+		return;
+	case DPP_STATE_AUTHENTICATING:
+	case DPP_STATE_CONFIGURING:
+		goto next_roc;
+	}
+
+	dpp->freqs_idx++;
+
+	if (dpp->freqs_idx >=3D dpp->freqs_len) {
+		l_debug("Max retries on presence announcements");
+		dpp->freqs_idx =3D 0;
+	}
+
+	dpp->current_freq =3D dpp->freqs[dpp->freqs_idx];
+
+	l_debug("Presence timeout, moving to next frequency %u, duration %u",
+			dpp->current_freq, dpp->dwell);
+
+next_roc:
+	dpp_start_offchannel(dpp, dpp->current_freq);
+
+	return;
+
+protocol_failed:
+	dpp_reset(dpp);
+	return;
+}
+
+static void dpp_start_offchannel(struct dpp_sm *dpp, uint32_t freq)
+{
+	if (dpp->offchannel_id)
+		offchannel_cancel(dpp->wdev_id, dpp->offchannel_id);
+
+	dpp->offchannel_id =3D offchannel_start(netdev_get_wdev_id(dpp->netdev),
+				freq, dpp->dwell, dpp_roc_started,
+				dpp, dpp_presence_timeout);
+}
+
 static void authenticate_request(struct dpp_sm *dpp, const uint8_t *from,
 					const uint8_t *body, size_t body_len)
 {
@@ -1414,49 +1520,6 @@ static void dpp_handle_frame(const struct mmpdu_head=
er *frame,
 	}
 }
 =

-static void dpp_presence_announce(struct dpp_sm *dpp)
-{
-	struct netdev *netdev =3D dpp->netdev;
-	uint8_t hdr[32];
-	uint8_t attrs[32 + 4];
-	uint8_t hash[32];
-	uint8_t *ptr =3D attrs;
-	const uint8_t *addr =3D netdev_get_address(netdev);
-	struct iovec iov[2];
-
-	iov[0].iov_len =3D dpp_build_header(addr, broadcast,
-					DPP_FRAME_PRESENCE_ANNOUNCEMENT, hdr);
-	iov[0].iov_base =3D hdr;
-
-	dpp_hash(L_CHECKSUM_SHA256, hash, 2, "chirp", strlen("chirp"),
-			dpp->pub_asn1, dpp->pub_asn1_len);
-
-	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH, hash, 32);
-
-	iov[1].iov_base =3D attrs;
-	iov[1].iov_len =3D ptr - attrs;
-
-	l_debug("Sending presense annoucement on frequency %u and waiting %u",
-		dpp->current_freq, dpp->dwell);
-
-	dpp_send_frame(netdev_get_wdev_id(netdev), iov, 2, dpp->current_freq);
-}
-
-static void dpp_roc_started(void *user_data)
-{
-	struct dpp_sm *dpp =3D user_data;
-
-	/*
-	 * If not in presence procedure or in a configurator role, just stay
-	 * on channel.
-	 */
-	if (dpp->state !=3D DPP_STATE_PRESENCE ||
-			dpp->role =3D=3D DPP_CAPABILITY_CONFIGURATOR)
-		return;
-
-	dpp_presence_announce(dpp);
-}
-
 static void dpp_create(struct netdev *netdev)
 {
 	struct l_dbus *dbus =3D dbus_get_bus();
@@ -1517,56 +1580,6 @@ static void dpp_netdev_watch(struct netdev *netdev,
 	}
 }
 =

-static void dpp_presence_timeout(int error, void *user_data)
-{
-	struct dpp_sm *dpp =3D user_data;
-
-	/*
-	 * If cancelled this is likely due to netdev going down or from Stop().
-	 * Otherwise there was some other problem which is probably not
-	 * recoverable.
-	 */
-	if (error =3D=3D -ECANCELED)
-		return;
-	else if (error =3D=3D -EIO)
-		goto next_roc;
-	else if (error < 0)
-		goto protocol_failed;
-
-	switch (dpp->state) {
-	case DPP_STATE_PRESENCE:
-		break;
-	case DPP_STATE_NOTHING:
-		/* Protocol already terminated */
-		return;
-	case DPP_STATE_AUTHENTICATING:
-	case DPP_STATE_CONFIGURING:
-		goto next_roc;
-	}
-
-	dpp->freqs_idx++;
-
-	if (dpp->freqs_idx >=3D dpp->freqs_len) {
-		l_debug("Max retries on presence announcements");
-		dpp->freqs_idx =3D 0;
-	}
-
-	dpp->current_freq =3D dpp->freqs[dpp->freqs_idx];
-
-	l_debug("Presence timeout, moving to next frequency %u, duration %u",
-			dpp->current_freq, dpp->dwell);
-
-next_roc:
-	dpp->offchannel_id =3D offchannel_start(netdev_get_wdev_id(dpp->netdev),
-			dpp->current_freq, dpp->dwell, dpp_roc_started,
-			dpp, dpp_presence_timeout);
-	return;
-
-protocol_failed:
-	dpp_reset(dpp);
-	return;
-}
-
 /*
  * EasyConnect 2.0 - 6.2.2
  */
@@ -1626,9 +1639,7 @@ static void dpp_start_presence(struct dpp_sm *dpp, ui=
nt32_t *limit_freqs,
 	dpp->freqs_idx =3D 0;
 	dpp->current_freq =3D dpp->freqs[0];
 =

-	dpp->offchannel_id =3D offchannel_start(netdev_get_wdev_id(dpp->netdev),
-			dpp->current_freq, dpp->dwell, dpp_roc_started,
-			dpp, dpp_presence_timeout);
+	dpp_start_offchannel(dpp, dpp->current_freq);
 }
 =

 static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
-- =

2.31.1

--===============5459187133533367222==--

