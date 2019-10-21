Content-Type: multipart/mixed; boundary="===============5979472381061653383=="
MIME-Version: 1.0
From: Andrew Zaborowski <balrogg@gmail.com>
Subject: [PATCH 09/11] wsc: Accept extra IEs in wsc_new_p2p_enrollee
Date: Mon, 21 Oct 2019 15:55:08 +0200
Message-ID: <20191021135510.12657-9-balrogg@gmail.com>
In-Reply-To: <20191021135510.12657-1-balrogg@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5979472381061653383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Andrew Zaborowski <andrew.zaborowski@intel.com>

---
 src/wsc.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/src/wsc.c b/src/wsc.c
index 61683e7b..6d232139 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -440,7 +440,8 @@ static inline enum wsc_rf_band freq_to_rf_band(uint32_t=
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
@@ -449,7 +450,7 @@ static void wsc_connect(struct wsc *wsc)
 	struct wsc_association_request request;
 	uint8_t *pdu;
 	size_t pdu_len;
-	struct iovec ie_iov;
+	struct iovec ie_iov[1 + ies_num];
 =

 	wsc->target =3D NULL;
 =

@@ -496,18 +497,20 @@ static void wsc_connect(struct wsc *wsc)
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
@@ -562,7 +565,7 @@ static void station_state_watch(enum station_state stat=
e, void *userdata)
 	station_remove_state_watch(wsc->station, wsc->station_state_watch);
 	wsc->station_state_watch =3D 0;
 =

-	wsc_connect(wsc);
+	wsc_connect(wsc, NULL, 0);
 }
 =

 static void wsc_check_can_connect(struct wsc *wsc, struct scan_bss *target)
@@ -594,7 +597,7 @@ static void wsc_check_can_connect(struct wsc *wsc, stru=
ct scan_bss *target)
 =

 	switch (station_get_state(wsc->station)) {
 	case STATION_STATE_DISCONNECTED:
-		wsc_connect(wsc);
+		wsc_connect(wsc, NULL, 0);
 		return;
 	case STATION_STATE_CONNECTING:
 	case STATION_STATE_CONNECTED:
@@ -1188,8 +1191,9 @@ static void wsc_netdev_watch(struct netdev *netdev,
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

@@ -1202,7 +1206,7 @@ struct wsc *wsc_new_p2p_enrollee(struct netdev *netde=
v, struct scan_bss *target,
 	wsc->done_data =3D user_data;
 	wsc->pin =3D l_strdup(pin);
 =

-	wsc_connect(wsc);
+	wsc_connect(wsc, ies, ies_num);
 =

 	/*
 	 * Wsc objects created this way are not handled in wsc_remove_interface,
-- =

2.20.1

--===============5979472381061653383==--

