Content-Type: multipart/mixed; boundary="===============4995855388189963294=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 2/3] handshake: Allow event handler to free handshake
Date: Fri, 21 Jan 2022 11:24:38 +0100
Message-ID: <20220121102439.267357-2-andrew.zaborowski@intel.com>
In-Reply-To: 20220121102439.267357-1-andrew.zaborowski@intel.com

--===============4995855388189963294==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Like in ap.c, allow the event callback to mark the handshake state as
destroyed, without causing invalid accesses after the callback has
returned.  In this case the crash was because try_handshake_complete
needed to access members of handshake_state after emitting the event,
as well as access the netdev, which also has been destroyed:

=3D=3D257707=3D=3D Invalid read of size 8
=3D=3D257707=3D=3D    at 0x408C85: try_handshake_complete (netdev.c:1487)
=3D=3D257707=3D=3D    by 0x408C85: try_handshake_complete (netdev.c:1480)
(...)
=3D=3D257707=3D=3D  Address 0x4e187e8 is 856 bytes inside a block of size 8=
72 free'd
=3D=3D257707=3D=3D    at 0x484621F: free (in /usr/libexec/valgrind/vgpreloa=
d_memcheck-amd64-linux.so)
=3D=3D257707=3D=3D    by 0x437887: ap_stop_handshake (ap.c:151)
=3D=3D257707=3D=3D    by 0x439793: ap_del_station (ap.c:316)
=3D=3D257707=3D=3D    by 0x43EA92: ap_station_disconnect (ap.c:3411)
=3D=3D257707=3D=3D    by 0x43EA92: ap_station_disconnect (ap.c:3399)
=3D=3D257707=3D=3D    by 0x454276: p2p_group_event (p2p.c:1006)
=3D=3D257707=3D=3D    by 0x439147: ap_event (ap.c:281)
=3D=3D257707=3D=3D    by 0x4393AB: ap_new_rsna (ap.c:390)
=3D=3D257707=3D=3D    by 0x4393AB: ap_handshake_event (ap.c:1010)
=3D=3D257707=3D=3D    by 0x408C7F: try_handshake_complete (netdev.c:1485)
=3D=3D257707=3D=3D    by 0x408C7F: try_handshake_complete (netdev.c:1480)
(...)
---
 src/handshake.c |  5 +++++
 src/handshake.h | 24 ++++++++++++++++++------
 src/netdev.c    | 16 +++++++++++-----
 3 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/src/handshake.c b/src/handshake.c
index 60ec0969..734e997c 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -107,6 +107,11 @@ void handshake_state_free(struct handshake_state *s)
 {
 	__typeof__(s->free) destroy =3D s->free;
 =

+	if (s->in_event) {
+		s->in_event =3D false;
+		return;
+	}
+
 	l_free(s->authenticator_ie);
 	l_free(s->supplicant_ie);
 	l_free(s->authenticator_rsnxe);
diff --git a/src/handshake.h b/src/handshake.h
index 6d56dadd..34d4829d 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -159,17 +159,29 @@ struct handshake_state {
 	void *user_data;
 =

 	void (*free)(struct handshake_state *s);
+	bool in_event;
 =

 	handshake_event_func_t event_func;
 };
 =

-#define handshake_event(hs, event, ...)	\
-	do {	\
-		if (!(hs)->event_func)	\
-			break;	\
+#define handshake_event(_hs, event, ...)	\
+	(__extension__ ({	\
+		struct handshake_state *hs =3D (_hs);	\
+		bool freed =3D false;	\
 	\
-		(hs)->event_func((hs), event, (hs)->user_data, ##__VA_ARGS__); \
-	} while (0)
+		if (hs->event_func && !hs->in_event) {	\
+			hs->in_event =3D true;	\
+			hs->event_func(hs, event, hs->user_data,	\
+					##__VA_ARGS__); \
+	\
+			if (!hs->in_event) {	\
+				handshake_state_free(hs);	\
+				freed =3D true;	\
+			} else	\
+				hs->in_event =3D false;	\
+		}	\
+		freed;	\
+	}))
 =

 void handshake_state_free(struct handshake_state *s);
 =

diff --git a/src/netdev.c b/src/netdev.c
index b311c0ee..4dc9ce94 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1482,7 +1482,9 @@ static void try_handshake_complete(struct netdev_hand=
shake_state *nhs)
 	if (nhs->ptk_installed && nhs->gtk_installed && nhs->igtk_installed &&
 			!nhs->complete) {
 		nhs->complete =3D true;
-		handshake_event(&nhs->super, HANDSHAKE_EVENT_COMPLETE);
+
+		if (handshake_event(&nhs->super, HANDSHAKE_EVENT_COMPLETE))
+			return;
 =

 		if (nhs->netdev->type =3D=3D NL80211_IFTYPE_STATION ||
 				nhs->netdev->type =3D=3D NL80211_IFTYPE_P2P_CLIENT)
@@ -2006,7 +2008,9 @@ static void netdev_group_timeout_cb(struct l_timeout =
*timeout, void *user_data)
 			nhs->netdev->index);
 =

 	nhs->complete =3D true;
-	handshake_event(&nhs->super, HANDSHAKE_EVENT_COMPLETE);
+
+	if (handshake_event(&nhs->super, HANDSHAKE_EVENT_COMPLETE))
+		return;
 =

 	netdev_connect_ok(nhs->netdev);
 }
@@ -2155,7 +2159,9 @@ static void netdev_set_pmk_cb(struct l_genl_msg *msg,=
 void *user_data)
 		return;
 	}
 =

-	handshake_event(netdev->handshake, HANDSHAKE_EVENT_SETTING_KEYS);
+	if (handshake_event(netdev->handshake, HANDSHAKE_EVENT_SETTING_KEYS))
+		return;
+
 	netdev_connect_ok(netdev);
 }
 =

@@ -2906,8 +2912,8 @@ process_resp_ies:
 	}
 =

 	/* Allow station to sync the PSK to disk */
-	if (is_offload(hs))
-		handshake_event(hs, HANDSHAKE_EVENT_SETTING_KEYS);
+	if (is_offload(hs) && handshake_event(hs, HANDSHAKE_EVENT_SETTING_KEYS))
+		return;
 =

 	netdev_connect_ok(netdev);
 	return;
-- =

2.32.0

--===============4995855388189963294==--

