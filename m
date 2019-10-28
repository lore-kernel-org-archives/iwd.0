Content-Type: multipart/mixed; boundary="===============7718870729544464209=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 05/16] handshake: Convert handshake event callbacks variadic
 functions
Date: Mon, 28 Oct 2019 15:04:57 +0100
Message-ID: <20191028140508.13518-5-andrew.zaborowski@intel.com>
In-Reply-To: <20191028140508.13518-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7718870729544464209==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Convert the handshake event callback type to use variable argument
list to allow for more flexibility in event-specific arguments
passed to the callbacks.
---
 src/adhoc.c     |  2 +-
 src/ap.c        |  9 +++++++--
 src/handshake.c |  7 -------
 src/handshake.h | 13 +++++++++----
 src/station.c   |  9 +++++++--
 src/wsc.c       | 11 +++++++++--
 6 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/src/adhoc.c b/src/adhoc.c
index 00f3a7e3..755e9493 100644
--- a/src/adhoc.c
+++ b/src/adhoc.c
@@ -159,7 +159,7 @@ static bool ap_sta_match_addr(const void *a, const void=
 *b)
 }
 =

 static void adhoc_handshake_event(struct handshake_state *hs,
-		enum handshake_event event, void *event_data, void *user_data)
+		enum handshake_event event, void *user_data, ...)
 {
 	struct sta_state *sta =3D user_data;
 	struct adhoc_state *adhoc =3D sta->adhoc;
diff --git a/src/ap.c b/src/ap.c
index b06b6691..cacfa807 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -382,16 +382,19 @@ static uint32_t ap_send_mgmt_frame(struct ap_state *a=
p,
 }
 =

 static void ap_handshake_event(struct handshake_state *hs,
-		enum handshake_event event, void *event_data, void *user_data)
+		enum handshake_event event, void *user_data, ...)
 {
 	struct sta_state *sta =3D user_data;
+	va_list args;
+
+	va_start(args, user_data);
 =

 	switch (event) {
 	case HANDSHAKE_EVENT_COMPLETE:
 		ap_new_rsna(sta);
 		break;
 	case HANDSHAKE_EVENT_FAILED:
-		netdev_handshake_failed(hs, l_get_u16(event_data));
+		netdev_handshake_failed(hs, l_get_u16(va_arg(args, void *)));
 		/* fall through */
 	case HANDSHAKE_EVENT_SETTING_KEYS_FAILED:
 		sta->sm =3D NULL;
@@ -399,6 +402,8 @@ static void ap_handshake_event(struct handshake_state *=
hs,
 	default:
 		break;
 	}
+
+	va_end(args);
 }
 =

 static void ap_start_rsna(struct sta_state *sta, const uint8_t *gtk_rsc)
diff --git a/src/handshake.c b/src/handshake.c
index 8e1aeec9..a3e236bb 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -912,10 +912,3 @@ bool handshake_decode_fte_key(struct handshake_state *=
s, const uint8_t *wrapped,
 =

 	return true;
 }
-
-void handshake_event(struct handshake_state *hs,
-			enum handshake_event event, void *event_data)
-{
-	if (hs->event_func)
-		hs->event_func(hs, event, event_data, hs->user_data);
-}
diff --git a/src/handshake.h b/src/handshake.h
index 08503190..cd0c1dc9 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -54,7 +54,7 @@ enum handshake_event {
 =

 typedef void (*handshake_event_func_t)(struct handshake_state *hs,
 					enum handshake_event event,
-					void *event_data, void *user_data);
+					void *user_data, ...);
 =

 typedef bool (*handshake_get_nonce_func_t)(uint8_t nonce[]);
 typedef void (*handshake_install_tk_func_t)(struct handshake_state *hs,
@@ -130,6 +130,14 @@ struct handshake_state {
 	handshake_event_func_t event_func;
 };
 =

+#define handshake_event(hs, event, ...)	\
+	do {	\
+		if (!(hs)->event_func)	\
+			break;	\
+	\
+		(hs)->event_func(hs, event, (hs)->user_data, ##__VA_ARGS__); \
+	} while (0)
+
 void handshake_state_free(struct handshake_state *s);
 =

 void handshake_state_set_supplicant_address(struct handshake_state *s,
@@ -216,6 +224,3 @@ const uint8_t *handshake_util_find_pmkid_kde(const uint=
8_t *data,
 					size_t data_len);
 void handshake_util_build_gtk_kde(enum crypto_cipher cipher, const uint8_t=
 *key,
 					unsigned int key_index, uint8_t *to);
-
-void handshake_event(struct handshake_state *hs, enum handshake_event even=
t,
-		void *event_data);
diff --git a/src/station.c b/src/station.c
index 315b3dcd..80a487cb 100644
--- a/src/station.c
+++ b/src/station.c
@@ -650,10 +650,13 @@ static void station_reconnect(struct station *station=
);
 =

 static void station_handshake_event(struct handshake_state *hs,
 					enum handshake_event event,
-					void *event_data, void *user_data)
+					void *user_data, ...)
 {
 	struct station *station =3D user_data;
 	struct network *network =3D station->connected_network;
+	va_list args;
+
+	va_start(args, user_data);
 =

 	switch (event) {
 	case HANDSHAKE_EVENT_STARTED:
@@ -666,7 +669,7 @@ static void station_handshake_event(struct handshake_st=
ate *hs,
 		network_sync_psk(network);
 		break;
 	case HANDSHAKE_EVENT_FAILED:
-		netdev_handshake_failed(hs, l_get_u16(event_data));
+		netdev_handshake_failed(hs, l_get_u16(va_arg(args, void *)));
 		break;
 	case HANDSHAKE_EVENT_REKEY_FAILED:
 		station_reconnect(station);
@@ -680,6 +683,8 @@ static void station_handshake_event(struct handshake_st=
ate *hs,
 		 */
 		break;
 	}
+
+	va_end(args);
 }
 =

 static bool station_has_erp_identity(struct network *network)
diff --git a/src/wsc.c b/src/wsc.c
index 9e8adf04..b659be5d 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -402,15 +402,22 @@ static void wsc_netdev_event(struct netdev *netdev, e=
num netdev_event event,
 }
 =

 static void wsc_handshake_event(struct handshake_state *hs,
-		enum handshake_event event, void *event_data, void *user_data)
+				enum handshake_event event, void *user_data,
+				...)
 {
+	va_list args;
+
+	va_start(args, user_data);
+
 	switch (event) {
 	case HANDSHAKE_EVENT_FAILED:
-		netdev_handshake_failed(hs, l_get_u16(event_data));
+		netdev_handshake_failed(hs, l_get_u16(va_arg(args, void *)));
 		break;
 	default:
 		break;
 	}
+
+	va_end(args);
 }
 =

 static inline enum wsc_rf_band freq_to_rf_band(uint32_t freq)
-- =

2.20.1

--===============7718870729544464209==--

