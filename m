Content-Type: multipart/mixed; boundary="===============3547996782627909793=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] anqp: refactor to use frame-xchg
Date: Wed, 27 May 2020 13:45:58 -0700
Message-ID: <20200527204559.2571-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3547996782627909793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The new frame-xchg module now handles a lot of what ANQP used to do. ANQP
now does not need to depend on nl80211/netdev for building and sending
frames. It also no longer needs any of the request lookups or frame
watches because frame-xchg filters this for us. The request queue did
need to remain in ANQP because station fires off ANQP requests all in
a row, and frame-xchg cannot handle this. Now ANQP just sends out the
first request, and queue's the rest. As the responses come in it will
send out the next frame in the queue until there are no more left.

The anqp_request API was changed to only return a bool, as well as
take the wdev_id rather than ifindex. Station was updated to remove
the 'pending' member since it was not actually used, as well as fix
a bug on the timeout path where the request queue would get popped
twice.

There is somewhat of a TODO that was overlooked initially with ANQP
and was realized when testing these patches. Since the network_info
depends on ANQP completing there is a race condition between scanning
finishing and being ready to connect to networks which require ANQP.
The autoconnect case does not have this issue, but explicit Dbus
connects do. In practice this may not matter since the user would have
to issue a connect at just the right time, but it could still happen.
This may need to be fixed in network where we see if there are any
pending ANQP requests before we return NotConfigured. If there are
pending requests we should wait for those, then attempt to connect.
---
 src/anqp.c    | 438 +++++++++++++-------------------------------------
 src/anqp.h    |   2 +-
 src/station.c |  16 +-
 3 files changed, 114 insertions(+), 342 deletions(-)

diff --git a/src/anqp.c b/src/anqp.c
index 6627bd81..504b5bdf 100644
--- a/src/anqp.c
+++ b/src/anqp.c
@@ -31,105 +31,63 @@
 #include "src/module.h"
 #include "src/anqp.h"
 #include "src/util.h"
-#include "src/eap-private.h"
 #include "src/ie.h"
-#include "src/nl80211util.h"
-#include "src/nl80211cmd.h"
 #include "src/scan.h"
-#include "src/netdev.h"
 #include "src/iwd.h"
 #include "src/mpdu.h"
-#include "src/wiphy.h"
+#include "src/frame-xchg.h"
 =

 #include "linux/nl80211.h"
 =

+#define ANQP_GROUP	1
+
 struct anqp_request {
-	uint32_t ifindex;
+	uint64_t wdev_id;
 	anqp_response_func_t anqp_cb;
 	anqp_destroy_func_t anqp_destroy;
 	void *anqp_data;
-	uint64_t anqp_cookie;
 	uint8_t anqp_token;
+	uint32_t frequency;
+	uint8_t *frame;
+	size_t frame_len;
 };
 =

-static struct l_genl_family *nl80211 =3D NULL;
-
 static struct l_queue *anqp_requests;
 static uint8_t anqp_token =3D 0;
 =

-static uint32_t netdev_watch;
-static uint32_t unicast_watch;
-
 static void anqp_destroy(void *user_data)
 {
 	struct anqp_request *request =3D user_data;
 =

 	if (request->anqp_destroy)
 		request->anqp_destroy(request->anqp_data);
-}
-
-static void netdev_gas_request_cb(struct l_genl_msg *msg, void *user_data)
-{
-	struct anqp_request *request =3D user_data;
-
-	if (l_genl_msg_get_error(msg) !=3D 0)
-		goto error;
-
-	if (nl80211_parse_attrs(msg, NL80211_ATTR_COOKIE, &request->anqp_cookie,
-					NL80211_ATTR_UNSPEC) < 0)
-		goto error;
-
-	return;
-
-error:
-	l_debug("Error sending CMD_FRAME (%d)", l_genl_msg_get_error(msg));
-
-	if (request->anqp_cb)
-		request->anqp_cb(ANQP_FAILED, NULL, 0, request->anqp_data);
-
-	if (request->anqp_destroy)
-		request->anqp_destroy(request->anqp_data);
 =

+	l_free(request->frame);
 	l_free(request);
 }
 =

-static bool match_token(const void *a, const void *b)
-{
-	const struct anqp_request *request =3D a;
-	const struct token_match {
-		uint32_t ifindex;
-		uint8_t token;
-
-	} *match =3D b;
+static void anqp_request_next(void);
 =

-	if (request->ifindex !=3D match->ifindex)
-		return false;
-
-	if (request->anqp_token !=3D match->token)
-		return false;
-
-	return true;
-}
-
-static void anqp_response_frame_event(uint32_t ifindex,
-					const struct mmpdu_header *hdr,
-					const void *body, size_t body_len)
+/*
+ * By using frame-xchg we should get called back here for any frame matchi=
ng our
+ * prefix until the duration expires. If frame-xchg is never signalled 'do=
ne'
+ * (returning true) we should get a timeout in anqp_frame_timeout. This is
+ * why we drop any improperly formatted frames without cleaning up the req=
uest.
+ */
+static bool anqp_response_frame_event(const struct mmpdu_header *hdr,
+					const void *body, size_t body_len,
+					int rssi, void *user_data)
 {
-	struct anqp_request *request;
+	struct anqp_request *request =3D user_data;
 	const uint8_t *ptr =3D body;
 	uint16_t status_code;
 	uint16_t delay;
 	uint16_t qrlen;
 	uint8_t adv_proto_len;
 	uint8_t token;
-	struct token_match {
-		uint32_t ifindex;
-		uint8_t token;
-
-	} match;
 =

 	if (body_len < 9)
-		return;
+		return false;
 =

 	/* Skip past category/action since this frame was prefixed matched */
 	ptr +=3D 2;
@@ -138,12 +96,8 @@ static void anqp_response_frame_event(uint32_t ifindex,
 	/* dialog token */
 	token =3D *ptr++;
 =

-	match.ifindex =3D ifindex;
-	match.token =3D token;
-
-	request =3D l_queue_find(anqp_requests, match_token, &match);
-	if (!request)
-		return;
+	if (request->anqp_token !=3D token)
+		return false;
 =

 	status_code =3D l_get_le16(ptr);
 	ptr +=3D 2;
@@ -151,7 +105,7 @@ static void anqp_response_frame_event(uint32_t ifindex,
 =

 	if (status_code !=3D 0) {
 		l_error("Bad status code on GAS response %u", status_code);
-		return;
+		return false;
 	}
 =

 	delay =3D l_get_le16(ptr);
@@ -166,12 +120,12 @@ static void anqp_response_frame_event(uint32_t ifinde=
x,
 	 */
 	if (delay !=3D 0) {
 		l_error("GAS comeback delay was not zero");
-		return;
+		return false;
 	}
 =

 	if (*ptr !=3D IE_TYPE_ADVERTISEMENT_PROTOCOL) {
 		l_error("GAS request not advertisement protocol");
-		return;
+		return false;
 	}
 =

 	ptr++;
@@ -181,339 +135,163 @@ static void anqp_response_frame_event(uint32_t ifin=
dex,
 	body_len--;
 =

 	if (body_len < adv_proto_len)
-		return;
+		return false;
 =

 	ptr +=3D adv_proto_len;
 	body_len -=3D adv_proto_len;
 =

 	if (body_len < 2)
-		return;
+		return false;
 =

 	qrlen =3D l_get_le16(ptr);
 	ptr +=3D 2;
 =

 	if (body_len < qrlen)
-		return;
-
-	l_queue_remove(anqp_requests, request);
+		return false;
 =

 	l_debug("ANQP response received from "MAC, MAC_STR(hdr->address_2));
 =

 	if (request->anqp_cb)
-		request->anqp_cb(ANQP_SUCCESS, ptr, qrlen,
-					request->anqp_data);
+		request->anqp_cb(ANQP_SUCCESS, ptr, qrlen, request->anqp_data);
 =

-	if (request->anqp_destroy)
-		request->anqp_destroy(request->anqp_data);
+	l_queue_remove(anqp_requests, request);
+	anqp_destroy(request);
 =

-	l_free(request);
+	if (l_queue_isempty(anqp_requests))
+		return true;
 =

-	return;
+	anqp_request_next();
+
+	return false;
 }
 =

-static void netdev_gas_timeout_cb(void *user_data)
+static const struct frame_xchg_prefix anqp_frame_prefix =3D {
+	.data =3D (uint8_t []) {
+		0x04, 0x0b,
+	},
+	.len =3D 2,
+};
+
+static void anqp_frame_timeout(int error, void *user_data)
 {
 	struct anqp_request *request =3D user_data;
+	enum anqp_result result =3D ANQP_TIMEOUT;
 =

-	l_debug("GAS request timed out");
+	if (error < 0) {
+		result =3D ANQP_FAILED;
+		l_error("Sending ANQP request failed: %s (%i)",
+			strerror(-error), -error);
+	}
 =

 	if (request->anqp_cb)
-		request->anqp_cb(ANQP_TIMEOUT, NULL, 0,
-					request->anqp_data);
+		request->anqp_cb(result, NULL, 0, request->anqp_data);
 =

-	/* allows anqp_request to be re-entrant */
 	if (request->anqp_destroy)
 		request->anqp_destroy(request->anqp_data);
 =

 	l_queue_remove(anqp_requests, request);
-	l_free(request);
-}
-
-static bool match_cookie(const void *a, const void *b)
-{
-	const struct anqp_request *request =3D a;
-	const struct cookie_match {
-		uint64_t cookie;
-		uint32_t ifindex;
-	} *match =3D b;
-
-	if (match->ifindex !=3D request->ifindex)
-		return false;
-
-	if (match->cookie !=3D request->anqp_cookie)
-		return false;
+	anqp_destroy(request);
 =

-	return true;
-}
-
-static void anqp_frame_wait_cancel_event(struct l_genl_msg *msg,
-						uint32_t ifindex)
-{
-	uint64_t cookie;
-	struct anqp_request *request;
-	struct cookie_match {
-		uint64_t cookie;
-		uint32_t ifindex;
-	} match;
-
-	l_debug("");
-
-	if (nl80211_parse_attrs(msg, NL80211_ATTR_COOKIE, &cookie,
-					NL80211_ATTR_UNSPEC) < 0)
-		return;
-
-	match.cookie =3D cookie;
-	match.ifindex =3D ifindex;
-
-	request =3D l_queue_find(anqp_requests, match_cookie, &match);
-	if (!request)
-		return;
-
-	if (cookie !=3D request->anqp_cookie)
+	if (l_queue_isempty(anqp_requests))
 		return;
 =

-	netdev_gas_timeout_cb(request);
+	anqp_request_next();
 }
 =

-uint32_t anqp_request(uint32_t ifindex, const uint8_t *addr,
-				struct scan_bss *bss, const uint8_t *anqp,
-				size_t len, anqp_response_func_t cb,
-				void *user_data, anqp_destroy_func_t destroy)
+static void anqp_request_next(void)
 {
 	struct anqp_request *request;
-	uint8_t frame[512];
-	struct l_genl_msg *msg;
 	struct iovec iov[2];
-	uint32_t id;
-	uint32_t duration =3D 300;
-	struct netdev *netdev =3D netdev_find(ifindex);
-
-	if (!netdev)
-		return 0;
-
-	/*
-	 * TODO: Netdev dependencies will eventually be removed so we need
-	 * another way to figure out wiphy capabilities.
-	 */
-	if (!wiphy_can_offchannel_tx(netdev_get_wiphy(netdev))) {
-		l_error("ANQP failed, driver does not support offchannel TX");
-		return 0;
-	}
-
-	frame[0] =3D 0x04;		/* Category: Public */
-	frame[1] =3D 0x0a;		/* Action: GAS initial Request */
-	frame[2] =3D anqp_token;		/* Dialog Token */
-	frame[3] =3D IE_TYPE_ADVERTISEMENT_PROTOCOL;
-	frame[4] =3D 2;
-	frame[5] =3D 0x7f;
-	frame[6] =3D IE_ADVERTISEMENT_ANQP;
-	l_put_le16(len, frame + 7);
-
-	iov[0].iov_base =3D frame;
-	iov[0].iov_len =3D 9;
-	iov[1].iov_base =3D (void *)anqp;
-	iov[1].iov_len =3D len;
-
-	request =3D l_new(struct anqp_request, 1);
-
-	request->ifindex =3D ifindex;
-	request->anqp_cb =3D cb;
-	request->anqp_destroy =3D destroy;
-	request->anqp_token =3D anqp_token++;
-	request->anqp_data =3D user_data;
-
-	msg =3D nl80211_build_cmd_frame(ifindex, addr, bss->addr,
-					bss->frequency, iov, 2);
 =

-	l_genl_msg_append_attr(msg, NL80211_ATTR_OFFCHANNEL_TX_OK, 0, "");
-	l_genl_msg_append_attr(msg, NL80211_ATTR_DURATION, 4, &duration);
+	if (l_queue_isempty(anqp_requests))
+		return;
 =

-	id =3D l_genl_family_send(nl80211, msg, netdev_gas_request_cb,
-					request, NULL);
+	request =3D l_queue_peek_head(anqp_requests);
 =

-	if (!id) {
-		l_debug("Failed to send ANQP request");
-		l_genl_msg_unref(msg);
-		l_free(request);
-		return 0;
-	}
+	iov[0].iov_base =3D request->frame;
+	iov[0].iov_len =3D request->frame_len;
+	iov[1].iov_base =3D NULL;
 =

-	l_debug("ANQP request sent to "MAC, MAC_STR(bss->addr));
-
-	l_queue_push_head(anqp_requests, request);
+	l_debug("Sending ANQP request\n");
 =

-	return id;
+	frame_xchg_start(request->wdev_id, iov, request->frequency, 0, 300, 0,
+				ANQP_GROUP, anqp_frame_timeout, request,
+				&anqp_frame_prefix, anqp_response_frame_event,
+				NULL);
 }
 =

-static void netdev_frame_cb(struct l_genl_msg *msg, void *user_data)
+static uint8_t *anqp_build_frame(const uint8_t *addr, struct scan_bss *bss,
+					const uint8_t *anqp, size_t len,
+					size_t *len_out)
 {
-	if (l_genl_msg_get_error(msg) < 0)
-		l_error("Could not register frame watch type %04x: %i",
-			L_PTR_TO_UINT(user_data), l_genl_msg_get_error(msg));
-}
-
-static void anqp_register_frame(uint32_t ifindex)
-{
-	struct l_genl_msg *msg;
-	uint16_t frame_type =3D 0x00d0;
-	uint8_t prefix[] =3D { 0x04, 0x0b };
-
-	msg =3D l_genl_msg_new_sized(NL80211_CMD_REGISTER_FRAME, 34);
+	uint8_t *frame =3D l_malloc(len + 33);
+	uint8_t *ptr;
 =

-	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &ifindex);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME_TYPE, 2, &frame_type);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME_MATCH,
-					sizeof(prefix), prefix);
+	memset(frame, 0, len + 33);
 =

-	l_genl_family_send(nl80211, msg, netdev_frame_cb,
-			L_UINT_TO_PTR(frame_type), NULL);
-}
+	l_put_le16(0x00d0, frame + 0);
+	memcpy(frame + 4, bss->addr, 6);
+	memcpy(frame + 10, addr, 6);
+	memcpy(frame + 16, bss->addr, 6);
 =

-static void anqp_netdev_watch(struct netdev *netdev,
-				enum netdev_watch_event event, void *user_data)
-{
-	switch (event) {
-	case NETDEV_WATCH_EVENT_NEW:
-		if (netdev_get_iftype(netdev) =3D=3D NETDEV_IFTYPE_STATION)
-			anqp_register_frame(netdev_get_ifindex(netdev));
+	ptr =3D frame + 24;
 =

-		return;
-	default:
-		break;
-	}
-}
+	*ptr++ =3D 0x04;			/* Category: Public */
+	*ptr++ =3D 0x0a;			/* Action: GAS initial Request */
+	*ptr++ =3D anqp_token++;		/* Dialog Token */
+	*ptr++ =3D IE_TYPE_ADVERTISEMENT_PROTOCOL;
+	*ptr++ =3D 2;
 =

-static void anqp_unicast_notify(struct l_genl_msg *msg, void *user_data)
-{
-	const struct mmpdu_header *mpdu =3D NULL;
-	const uint8_t *body;
-	struct l_genl_attr attr;
-	uint16_t type, len;
-	uint16_t frame_len =3D 0;
-	const void *data;
-	uint8_t cmd;
-	uint32_t ifindex =3D 0;
-
-	if (l_queue_isempty(anqp_requests))
-		return;
-
-	cmd =3D l_genl_msg_get_command(msg);
-	if (!cmd)
-		return;
-
-	if (!l_genl_attr_init(&attr, msg))
-		return;
-
-	while (l_genl_attr_next(&attr, &type, &len, &data)) {
-		switch (type) {
-		case NL80211_ATTR_IFINDEX:
-			if (len !=3D sizeof(uint32_t)) {
-				l_warn("Invalid interface index attribute");
-				return;
-			}
-
-			ifindex =3D *((uint32_t *) data);
-
-			break;
-		case NL80211_ATTR_FRAME:
-			if (mpdu)
-				return;
-
-			mpdu =3D mpdu_validate(data, len);
-			if (!mpdu)
-				l_error("Frame didn't validate as MMPDU");
-
-			frame_len =3D len;
-			break;
-		}
-	}
+	*ptr++ =3D 0x7f;
+	*ptr++ =3D IE_ADVERTISEMENT_ANQP;
+	l_put_le16(len, ptr);
+	ptr +=3D 2;
 =

-	if (!ifindex || !mpdu)
-		return;
+	memcpy(ptr, anqp, len);
+	ptr +=3D len;
 =

-	body =3D mmpdu_body(mpdu);
+	*len_out =3D ptr - frame;
 =

-	anqp_response_frame_event(ifindex, mpdu, body,
-				(const uint8_t *) mpdu + frame_len - body);
+	return frame;
 }
 =

-static void anqp_mlme_notify(struct l_genl_msg *msg, void *user_data)
+bool anqp_request(uint64_t wdev_id, const uint8_t *addr,
+			struct scan_bss *bss, const uint8_t *anqp,
+			size_t len, anqp_response_func_t cb,
+			void *user_data, anqp_destroy_func_t destroy)
 {
-	struct l_genl_attr attr;
-	uint16_t type, len;
-	const void *data;
-	uint8_t cmd;
-	uint32_t ifindex =3D 0;
-
-	if (l_queue_isempty(anqp_requests))
-		return;
+	struct anqp_request *request;
 =

-	cmd =3D l_genl_msg_get_command(msg);
+	request =3D l_new(struct anqp_request, 1);
 =

-	l_debug("MLME notification %s(%u)", nl80211cmd_to_string(cmd), cmd);
+	request->wdev_id =3D wdev_id;
+	request->frequency =3D bss->frequency;
+	request->anqp_cb =3D cb;
+	request->anqp_destroy =3D destroy;
+	request->anqp_token =3D anqp_token;
+	request->anqp_data =3D user_data;
 =

-	if (!l_genl_attr_init(&attr, msg))
-		return;
+	request->frame =3D anqp_build_frame(addr, bss, anqp, len,
+						&request->frame_len);
 =

-	while (l_genl_attr_next(&attr, &type, &len, &data)) {
-		switch (type) {
-		case NL80211_ATTR_IFINDEX:
-			if (len !=3D sizeof(uint32_t)) {
-				l_warn("Invalid interface index attribute");
-				return;
-			}
-
-			ifindex =3D *((uint32_t *) data);
-			break;
-		}
-	}
+	l_queue_push_head(anqp_requests, request);
 =

-	if (!ifindex) {
-		l_warn("MLME notification is missing ifindex attribute");
-		return;
-	}
+	if (l_queue_length(anqp_requests) =3D=3D 1)
+		anqp_request_next();
 =

-	switch (cmd) {
-	case NL80211_CMD_FRAME_WAIT_CANCEL:
-		anqp_frame_wait_cancel_event(msg, ifindex);
-		break;
-	}
+	return true;
 }
 =

 static int anqp_init(void)
 {
-	struct l_genl *genl =3D iwd_get_genl();
-
-	nl80211 =3D l_genl_family_new(genl, NL80211_GENL_NAME);
-
 	anqp_requests =3D l_queue_new();
 =

-	netdev_watch =3D  netdev_watch_add(anqp_netdev_watch, NULL, NULL);
-
-	unicast_watch =3D l_genl_add_unicast_watch(genl, NL80211_GENL_NAME,
-						anqp_unicast_notify,
-						NULL, NULL);
-
-	if (!l_genl_family_register(nl80211, "mlme", anqp_mlme_notify,
-								NULL, NULL))
-		l_error("Registering for MLME notification failed");
-
 	return 0;
 }
 =

 static void anqp_exit(void)
 {
-	struct l_genl *genl =3D iwd_get_genl();
-
-	l_genl_family_free(nl80211);
-	nl80211 =3D NULL;
-
 	l_queue_destroy(anqp_requests, anqp_destroy);
-
-	netdev_watch_remove(netdev_watch);
-
-	l_genl_remove_unicast_watch(genl, unicast_watch);
 }
 =

 IWD_MODULE(anqp, anqp_init, anqp_exit);
-IWD_MODULE_DEPENDS(anqp, netdev);
diff --git a/src/anqp.h b/src/anqp.h
index 998277dd..99af76d5 100644
--- a/src/anqp.h
+++ b/src/anqp.h
@@ -34,7 +34,7 @@ typedef void (*anqp_response_func_t)(enum anqp_result res=
ult,
 					const void *anqp, size_t len,
 					void *user_data);
 =

-uint32_t anqp_request(uint32_t ifindex, const uint8_t *addr,
+bool anqp_request(uint64_t wdev_id, const uint8_t *addr,
 			struct scan_bss *bss, const uint8_t *anqp, size_t len,
 			anqp_response_func_t cb, void *user_data,
 			anqp_destroy_func_t destroy);
diff --git a/src/station.c b/src/station.c
index c532319a..29f94e3b 100644
--- a/src/station.c
+++ b/src/station.c
@@ -104,7 +104,6 @@ struct station {
 struct anqp_entry {
 	struct station *station;
 	struct network *network;
-	uint32_t pending;
 };
 =

 struct wiphy *station_get_wiphy(struct station *station)
@@ -447,12 +446,9 @@ static void station_anqp_response_cb(enum anqp_result =
result,
 	char **realms =3D NULL;
 	struct nai_search search;
 =

-	entry->pending =3D 0;
-
 	l_debug("");
 =

-	if (result =3D=3D ANQP_TIMEOUT) {
-		l_queue_remove(station->anqp_pending, entry);
+	if (result !=3D ANQP_SUCCESS) {
 		/* TODO: try next BSS */
 		goto request_done;
 	}
@@ -551,12 +547,10 @@ static bool station_start_anqp(struct station *statio=
n, struct network *network,
 	 * these are checked in hs20_find_settings_file.
 	 */
 =

-	entry->pending =3D anqp_request(netdev_get_ifindex(station->netdev),
-					netdev_get_address(station->netdev),
-					bss, anqp, ptr - anqp,
-					station_anqp_response_cb,
-					entry, l_free);
-	if (!entry->pending) {
+	if (!anqp_request(netdev_get_wdev_id(station->netdev),
+				netdev_get_address(station->netdev), bss, anqp,
+				ptr - anqp, station_anqp_response_cb,
+				entry, l_free)) {
 		l_free(entry);
 		return false;
 	}
-- =

2.21.1

--===============3547996782627909793==--

