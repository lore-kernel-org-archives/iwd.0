Content-Type: multipart/mixed; boundary="===============1876511149599864206=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 16/16] wsc: Accept extra IEs in wsc_new_p2p_enrollee
Date: Mon, 28 Oct 2019 15:05:08 +0100
Message-ID: <20191028140508.13518-16-andrew.zaborowski@intel.com>
In-Reply-To: <20191028140508.13518-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1876511149599864206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/wsc.c | 30 +++++++++++++++++-------------
 src/wsc.h |  6 ++++--
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/src/wsc.c b/src/wsc.c
index 6866571a..c094ac88 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -448,7 +448,8 @@ static inline enum wsc_rf_band freq_to_rf_band(uint32_t=
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
@@ -457,7 +458,7 @@ static void wsc_connect(struct wsc *wsc)
 	struct wsc_association_request request;
 	uint8_t *pdu;
 	size_t pdu_len;
-	struct iovec ie_iov;
+	struct iovec ie_iov[1 + ies_num];
 =

 	wsc->target =3D NULL;
 =

@@ -503,18 +504,20 @@ static void wsc_connect(struct wsc *wsc)
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
@@ -572,7 +575,7 @@ static void station_state_watch(enum station_state stat=
e, void *userdata)
 	station_remove_state_watch(wsc->station, wsc->station_state_watch);
 	wsc->station_state_watch =3D 0;
 =

-	wsc_connect(wsc);
+	wsc_connect(wsc, NULL, 0);
 }
 =

 static void wsc_check_can_connect(struct wsc *wsc, struct scan_bss *target)
@@ -604,7 +607,7 @@ static void wsc_check_can_connect(struct wsc *wsc, stru=
ct scan_bss *target)
 =

 	switch (station_get_state(wsc->station)) {
 	case STATION_STATE_DISCONNECTED:
-		wsc_connect(wsc);
+		wsc_connect(wsc, NULL, 0);
 		return;
 	case STATION_STATE_CONNECTING:
 	case STATION_STATE_CONNECTED:
@@ -1198,8 +1201,9 @@ static void wsc_netdev_watch(struct netdev *netdev,
 }
 =

 struct wsc *wsc_new_p2p_enrollee(struct netdev *netdev, struct scan_bss *t=
arget,
-					char *pin, wsc_done_cb_t done_cb,
-					void *user_data)
+					char *pin,
+					struct iovec *ies, unsigned int ies_num,
+					wsc_done_cb_t done_cb, void *user_data)
 {
 	struct wsc *wsc;
 =

@@ -1212,7 +1216,7 @@ struct wsc *wsc_new_p2p_enrollee(struct netdev *netde=
v, struct scan_bss *target,
 	wsc->done_data =3D user_data;
 	wsc->pin =3D l_strdup(pin);
 =

-	wsc_connect(wsc);
+	wsc_connect(wsc, ies, ies_num);
 =

 	/*
 	 * Wsc objects created this way are not handled in wsc_remove_interface,
diff --git a/src/wsc.h b/src/wsc.h
index 3995a647..4ae1c45c 100644
--- a/src/wsc.h
+++ b/src/wsc.h
@@ -23,6 +23,7 @@
 struct wsc;
 struct netdev;
 struct scan_bss;
+struct iovec;
 =

 struct wsc_credentials_info {
 	char ssid[33];
@@ -39,6 +40,7 @@ typedef void (*wsc_done_cb_t)(int err, struct wsc_credent=
ials_info *creds,
 				unsigned int n_creds, void *user_data);
 =

 struct wsc *wsc_new_p2p_enrollee(struct netdev *netdev, struct scan_bss *t=
arget,
-					char *pin, wsc_done_cb_t done_cb,
-					void *user_data);
+					char *pin,
+					struct iovec *ies, unsigned int ies_num,
+					wsc_done_cb_t done_cb, void *user_data);
 void wsc_destroy(struct wsc *wsc);
-- =

2.20.1

--===============1876511149599864206==--

