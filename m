Content-Type: multipart/mixed; boundary="===============0733821700376277358=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 06/16] handshake: Convert HANDSHAKE_EVENT_FAILED data to int
Date: Mon, 28 Oct 2019 15:04:58 +0100
Message-ID: <20191028140508.13518-6-andrew.zaborowski@intel.com>
In-Reply-To: <20191028140508.13518-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0733821700376277358==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Note the uint16_t reason code is promoted to an int when using variable
arguments so va_arg(args, int) has to be used.
---
 src/ap.c      | 2 +-
 src/eapol.c   | 2 +-
 src/station.c | 2 +-
 src/wsc.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index cacfa807..694ee885 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -394,7 +394,7 @@ static void ap_handshake_event(struct handshake_state *=
hs,
 		ap_new_rsna(sta);
 		break;
 	case HANDSHAKE_EVENT_FAILED:
-		netdev_handshake_failed(hs, l_get_u16(va_arg(args, void *)));
+		netdev_handshake_failed(hs, va_arg(args, int));
 		/* fall through */
 	case HANDSHAKE_EVENT_SETTING_KEYS_FAILED:
 		sta->sm =3D NULL;
diff --git a/src/eapol.c b/src/eapol.c
index 44d42735..e7ee9fe8 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -915,7 +915,7 @@ static void eapol_sm_write(struct eapol_sm *sm, const s=
truct eapol_frame *ef,
 =

 static inline void handshake_failed(struct eapol_sm *sm, uint16_t reason_c=
ode)
 {
-	handshake_event(sm->handshake, HANDSHAKE_EVENT_FAILED, &reason_code);
+	handshake_event(sm->handshake, HANDSHAKE_EVENT_FAILED, reason_code);
 =

 	eapol_sm_free(sm);
 }
diff --git a/src/station.c b/src/station.c
index 80a487cb..e88adf36 100644
--- a/src/station.c
+++ b/src/station.c
@@ -669,7 +669,7 @@ static void station_handshake_event(struct handshake_st=
ate *hs,
 		network_sync_psk(network);
 		break;
 	case HANDSHAKE_EVENT_FAILED:
-		netdev_handshake_failed(hs, l_get_u16(va_arg(args, void *)));
+		netdev_handshake_failed(hs, va_arg(args, int));
 		break;
 	case HANDSHAKE_EVENT_REKEY_FAILED:
 		station_reconnect(station);
diff --git a/src/wsc.c b/src/wsc.c
index b659be5d..04187f5b 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -411,7 +411,7 @@ static void wsc_handshake_event(struct handshake_state =
*hs,
 =

 	switch (event) {
 	case HANDSHAKE_EVENT_FAILED:
-		netdev_handshake_failed(hs, l_get_u16(va_arg(args, void *)));
+		netdev_handshake_failed(hs, va_arg(args, int));
 		break;
 	default:
 		break;
-- =

2.20.1

--===============0733821700376277358==--

