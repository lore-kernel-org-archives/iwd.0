Content-Type: multipart/mixed; boundary="===============0220797672567899915=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 6/7] wsc: Accept extra IEs in wsc_start_enrollee
Date: Thu, 05 Dec 2019 04:22:43 +0100
Message-ID: <20191205032244.5957-6-andrew.zaborowski@intel.com>
In-Reply-To: <20191205032244.5957-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0220797672567899915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/wsc.c | 24 ++++++++++++++----------
 src/wsc.h |  3 ++-
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/src/wsc.c b/src/wsc.c
index 1901feb6..423d2aa8 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -447,7 +447,8 @@ static inline enum wsc_rf_band freq_to_rf_band(uint32_t=
 freq)
 	return WSC_RF_BAND_2_4_GHZ;
 }
 =

-static void wsc_connect(struct wsc *wsc)
+static void wsc_connect(struct wsc *wsc, struct iovec *ies,
+			unsigned int ies_num)
 {
 	struct handshake_state *hs;
 	struct l_settings *settings =3D l_settings_new();
@@ -456,7 +457,7 @@ static void wsc_connect(struct wsc *wsc)
 	struct wsc_association_request request;
 	uint8_t *pdu;
 	size_t pdu_len;
-	struct iovec ie_iov;
+	struct iovec ie_iov[1 + ies_num];
 =

 	wsc->target =3D NULL;
 =

@@ -502,18 +503,20 @@ static void wsc_connect(struct wsc *wsc)
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

-	r =3D netdev_connect(wsc->netdev, bss, hs, &ie_iov, 1, wsc_netdev_event,
-				wsc_connect_cb, wsc);
-	l_free(ie_iov.iov_base);
+	memcpy(ie_iov + 1, ies, sizeof(struct iovec) * ies_num);
+
+	r =3D netdev_connect(wsc->netdev, bss, hs, ie_iov, 1 + ies_num,
+				wsc_netdev_event, wsc_connect_cb, wsc);
+	l_free(ie_iov[0].iov_base);
 =

 	if (r < 0)
 		goto error;
@@ -1079,7 +1082,8 @@ void wsc_destroy(struct wsc *wsc)
 }
 =

 void wsc_start_enrollee(struct wsc *wsc, struct netdev *netdev,
-			struct scan_bss *target, const char *pin)
+			struct scan_bss *target, const char *pin,
+			struct iovec *ies, unsigned int ies_num)
 {
 	wsc->netdev =3D netdev;
 	wsc->target =3D target;
@@ -1087,7 +1091,7 @@ void wsc_start_enrollee(struct wsc *wsc, struct netde=
v *netdev,
 		WSC_CONFIGURATION_METHOD_VIRTUAL_PUSH_BUTTON;
 	wsc->pin =3D l_strdup(pin);
 =

-	wsc_connect(wsc);
+	wsc_connect(wsc, ies, ies_num);
 }
 =

 void wsc_cancel(struct wsc *wsc, netdev_disconnect_cb_t cb)
diff --git a/src/wsc.h b/src/wsc.h
index e8a965f2..73ffdd33 100644
--- a/src/wsc.h
+++ b/src/wsc.h
@@ -47,6 +47,7 @@ struct wsc_ops {
 =

 struct wsc *wsc_new(const struct wsc_ops *ops, void *user_data);
 void wsc_start_enrollee(struct wsc *wsc, struct netdev *netdev,
-			struct scan_bss *target, const char *pin);
+			struct scan_bss *target, const char *pin,
+			struct iovec *ies, unsigned int ies_num);
 void wsc_cancel(struct wsc *wsc, netdev_disconnect_cb_t cb);
 void wsc_destroy(struct wsc *wsc);
-- =

2.20.1

--===============0220797672567899915==--

