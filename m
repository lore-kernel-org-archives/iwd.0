Content-Type: multipart/mixed; boundary="===============5697548211928854255=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 08/16] eapol: Move the EAP events to handshake event handler
Date: Mon, 28 Oct 2019 15:05:00 +0100
Message-ID: <20191028140508.13518-8-andrew.zaborowski@intel.com>
In-Reply-To: <20191028140508.13518-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5697548211928854255==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On EAP events, call the handshake_event handler with the new event type
HANDSHAKE_EVENT_EAP_NOTIFY isntead of the eapol_event callback.

This allows the handler to be set before calling
netdev_connect/netdev_connect_wsc.  It's also in theory more type-safe
because we don't need the cast in netdev_connect_wsc anymore.
---
 src/eapol.c     |  6 ++----
 src/handshake.h |  1 +
 src/station.c   |  1 +
 src/wsc.c       | 27 +++++++++++++++++----------
 4 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index dbef66f5..f2a5611f 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -2167,10 +2167,8 @@ static void eapol_eap_event_cb(unsigned int event,
 {
 	struct eapol_sm *sm =3D user_data;
 =

-	if (!sm->event_func)
-		return;
-
-	sm->event_func(event, event_data, sm->user_data);
+	handshake_event(sm->handshake, HANDSHAKE_EVENT_EAP_NOTIFY, event,
+			event_data);
 }
 =

 void eapol_sm_set_use_eapol_start(struct eapol_sm *sm, bool enabled)
diff --git a/src/handshake.h b/src/handshake.h
index cd0c1dc9..c369ad50 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -50,6 +50,7 @@ enum handshake_event {
 	HANDSHAKE_EVENT_COMPLETE,
 	HANDSHAKE_EVENT_FAILED,
 	HANDSHAKE_EVENT_REKEY_FAILED,
+	HANDSHAKE_EVENT_EAP_NOTIFY,
 };
 =

 typedef void (*handshake_event_func_t)(struct handshake_state *hs,
diff --git a/src/station.c b/src/station.c
index e88adf36..5e1d2468 100644
--- a/src/station.c
+++ b/src/station.c
@@ -676,6 +676,7 @@ static void station_handshake_event(struct handshake_st=
ate *hs,
 		break;
 	case HANDSHAKE_EVENT_COMPLETE:
 	case HANDSHAKE_EVENT_SETTING_KEYS_FAILED:
+	case HANDSHAKE_EVENT_EAP_NOTIFY:
 		/*
 		 * currently we dont care about any other events. The
 		 * netdev_connect_cb will notify us when the connection is
diff --git a/src/wsc.c b/src/wsc.c
index 04187f5b..fcaae36f 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -363,16 +363,7 @@ static void wsc_credential_obtained(struct wsc *wsc,
 static void wsc_eapol_event(uint32_t event, const void *event_data,
 							void *user_data)
 {
-	struct wsc *wsc =3D user_data;
-
-	switch (event) {
-	case EAP_WSC_EVENT_CREDENTIAL_OBTAINED:
-		wsc_credential_obtained(wsc,
-				(const struct wsc_credential *) event_data);
-		break;
-	default:
-		l_debug("Got event: %d", event);
-	}
+	l_debug("Got event: %d", event);
 }
 =

 static void wsc_netdev_event(struct netdev *netdev, enum netdev_event even=
t,
@@ -405,6 +396,7 @@ static void wsc_handshake_event(struct handshake_state =
*hs,
 				enum handshake_event event, void *user_data,
 				...)
 {
+	struct wsc *wsc =3D user_data;
 	va_list args;
 =

 	va_start(args, user_data);
@@ -413,6 +405,21 @@ static void wsc_handshake_event(struct handshake_state=
 *hs,
 	case HANDSHAKE_EVENT_FAILED:
 		netdev_handshake_failed(hs, va_arg(args, int));
 		break;
+	case HANDSHAKE_EVENT_EAP_NOTIFY:
+	{
+		unsigned int eap_event =3D va_arg(args, unsigned int);
+
+		switch (eap_event) {
+		case EAP_WSC_EVENT_CREDENTIAL_OBTAINED:
+			wsc_credential_obtained(wsc,
+				va_arg(args, const struct wsc_credential *));
+			break;
+		default:
+			l_debug("Got event: %d", eap_event);
+		}
+
+		break;
+	}
 	default:
 		break;
 	}
-- =

2.20.1

--===============5697548211928854255==--

