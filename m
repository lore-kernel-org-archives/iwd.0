Content-Type: multipart/mixed; boundary="===============0148774244636297641=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/3] wsc: Accept extra IEs in wsc_enrollee_new
Date: Mon, 13 Jan 2020 14:36:14 +0100
Message-ID: <20200113133614.2888-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0148774244636297641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/wsc.c | 23 ++++++++++++++---------
 src/wsc.h |  1 +
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/src/wsc.c b/src/wsc.c
index 74fe8aa8..56018825 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -320,7 +320,8 @@ static inline enum wsc_rf_band freq_to_rf_band(uint32_t=
 freq)
 }
 =

 static int wsc_enrollee_connect(struct wsc_enrollee *wsce, struct scan_bss=
 *bss,
-					const char *pin)
+					const char *pin, struct iovec *ies,
+					unsigned int ies_num)
 {
 	struct handshake_state *hs;
 	struct l_settings *settings =3D l_settings_new();
@@ -328,7 +329,7 @@ static int wsc_enrollee_connect(struct wsc_enrollee *ws=
ce, struct scan_bss *bss,
 	struct wsc_association_request request;
 	uint8_t *pdu;
 	size_t pdu_len;
-	struct iovec ie_iov;
+	struct iovec ie_iov[1 + ies_num];
 =

 	hs =3D netdev_handshake_state_new(wsce->netdev);
 =

@@ -372,19 +373,22 @@ static int wsc_enrollee_connect(struct wsc_enrollee *=
wsce, struct scan_bss *bss,
 		goto error;
 	}
 =

-	ie_iov.iov_base =3D ie_tlv_encapsulate_wsc_payload(pdu, pdu_len,
-							&ie_iov.iov_len);
+	ie_iov[0].iov_base =3D ie_tlv_encapsulate_wsc_payload(pdu, pdu_len,
+							&ie_iov[0].iov_len);
 	l_free(pdu);
 =

-	if (!ie_iov.iov_base) {
+	if (!ie_iov[0].iov_base) {
 		r =3D -ENOMEM;
 		goto error;
 	}
 =

-	r =3D netdev_connect(wsce->netdev, bss, hs, &ie_iov, 1,
+	if (ies_num)
+		memcpy(ie_iov + 1, ies, sizeof(struct iovec) * ies_num);
+
+	r =3D netdev_connect(wsce->netdev, bss, hs, ie_iov, 1 + ies_num,
 				wsc_enrollee_netdev_event,
 				wsc_enrollee_connect_cb, wsce);
-	l_free(ie_iov.iov_base);
+	l_free(ie_iov[0].iov_base);
 =

 	if (r =3D=3D 0)
 		return 0;
@@ -397,6 +401,7 @@ error:
 struct wsc_enrollee *wsc_enrollee_new(struct netdev *netdev,
 					struct scan_bss *target,
 					const char *pin,
+					struct iovec *ies, unsigned int ies_num,
 					wsc_done_cb_t done_cb, void *user_data)
 {
 	struct wsc_enrollee *wsce;
@@ -406,7 +411,7 @@ struct wsc_enrollee *wsc_enrollee_new(struct netdev *ne=
tdev,
 	wsce->done_cb =3D done_cb;
 	wsce->done_data =3D user_data;
 =

-	if (wsc_enrollee_connect(wsce, target, pin) =3D=3D 0)
+	if (wsc_enrollee_connect(wsce, target, pin, ies, ies_num) =3D=3D 0)
 		return wsce;
 =

 	wsc_enrollee_free(wsce);
@@ -577,7 +582,7 @@ static void wsc_connect(struct wsc_station_dbus *wsc)
 		l_dbus_message_get_arguments(wsc->super.pending_connect, "s",
 						&pin);
 =

-	wsc->enrollee =3D wsc_enrollee_new(wsc->netdev, wsc->target, pin,
+	wsc->enrollee =3D wsc_enrollee_new(wsc->netdev, wsc->target, pin, NULL, 0,
 						wsc_dbus_done_cb, wsc);
 	if (wsc->enrollee)
 		return;
diff --git a/src/wsc.h b/src/wsc.h
index 3cb7ab18..570aa7cb 100644
--- a/src/wsc.h
+++ b/src/wsc.h
@@ -39,6 +39,7 @@ typedef void (*wsc_done_cb_t)(int err, struct wsc_credent=
ials_info *creds,
 struct wsc_enrollee *wsc_enrollee_new(struct netdev *netdev,
 					struct scan_bss *target,
 					const char *pin,
+					struct iovec *ies, unsigned int ies_num,
 					wsc_done_cb_t done_cb, void *user_data);
 void wsc_enrollee_cancel(struct wsc_enrollee *wsce);
 =

-- =

2.20.1

--===============0148774244636297641==--

