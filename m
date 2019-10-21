Content-Type: multipart/mixed; boundary="===============8242638240113811459=="
MIME-Version: 1.0
From: Andrew Zaborowski <balrogg@gmail.com>
Subject: [PATCH 04/11] eapol: Move the EAP event handler to handshake state
Date: Mon, 21 Oct 2019 15:55:03 +0200
Message-ID: <20191021135510.12657-4-balrogg@gmail.com>
In-Reply-To: <20191021135510.12657-1-balrogg@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8242638240113811459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Andrew Zaborowski <andrew.zaborowski@intel.com>

Move the storage of the eapol event callback from the eapol_sm struct to
the handshake_state struct.  Rename from eapol event to eap event as the
callback is only used to relay eap-specific event in eapol.c.

This is allows the handler to be set before calling
netdev_connect/netdev_connect_wsc.  It's also in theory more type-safe
because don't need the cast in netdev_connect_wsc anymore.

Note that eapol_sm_set_user_data is now unused.  I'm not sure if it
should be removed on its own, the user_data that it sets will also
affect rekey_offload callbacks.  However rekey_offload's user_data
parameter is not used by the only implementation of that callback, so
both could be removed together.
---
 src/eapol.c     | 10 +++-------
 src/eapol.h     |  1 -
 src/handshake.c |  8 ++++++++
 src/handshake.h | 10 +++++++++-
 src/netdev.c    |  6 ++++--
 5 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 349e824f..f370cbed 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -901,11 +901,6 @@ void eapol_sm_set_user_data(struct eapol_sm *sm, void =
*user_data)
 	sm->user_data =3D user_data;
 }
 =

-void eapol_sm_set_event_func(struct eapol_sm *sm, eapol_sm_event_func_t fu=
nc)
-{
-	sm->event_func =3D func;
-}
-
 static void eapol_sm_write(struct eapol_sm *sm, const struct eapol_frame *=
ef,
 				bool noencrypt)
 {
@@ -2167,10 +2162,11 @@ static void eapol_eap_event_cb(unsigned int event,
 {
 	struct eapol_sm *sm =3D user_data;
 =

-	if (!sm->event_func)
+	if (!sm->handshake->eap_event_func)
 		return;
 =

-	sm->event_func(event, event_data, sm->user_data);
+	sm->handshake->eap_event_func(event, event_data,
+					sm->handshake->eap_user_data);
 }
 =

 void eapol_sm_set_use_eapol_start(struct eapol_sm *sm, bool enabled)
diff --git a/src/eapol.h b/src/eapol.h
index 9462b56d..7143b53a 100644
--- a/src/eapol.h
+++ b/src/eapol.h
@@ -117,7 +117,6 @@ void eapol_sm_set_use_eapol_start(struct eapol_sm *sm, =
bool enabled);
 void eapol_sm_set_require_handshake(struct eapol_sm *sm, bool enabled);
 void eapol_sm_set_listen_interval(struct eapol_sm *sm, uint16_t interval);
 void eapol_sm_set_user_data(struct eapol_sm *sm, void *user_data);
-void eapol_sm_set_event_func(struct eapol_sm *sm, eapol_sm_event_func_t fu=
nc);
 =

 void eapol_register(struct eapol_sm *sm);
 bool eapol_start(struct eapol_sm *sm);
diff --git a/src/handshake.c b/src/handshake.c
index 514f47db..d3f2a3ca 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -249,6 +249,14 @@ void handshake_state_set_event_func(struct handshake_s=
tate *s,
 	s->user_data =3D user_data;
 }
 =

+void handshake_state_set_eap_event_func(struct handshake_state *s,
+						handshake_eap_event_func_t func,
+						void *user_data)
+{
+	s->eap_event_func =3D func;
+	s->eap_user_data =3D user_data;
+}
+
 void handshake_state_set_passphrase(struct handshake_state *s,
 					const char *passphrase)
 {
diff --git a/src/handshake.h b/src/handshake.h
index 4b9d438b..2c144fea 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -69,6 +69,9 @@ typedef void (*handshake_install_igtk_func_t)(struct hand=
shake_state *hs,
 					const uint8_t *igtk, uint8_t igtk_len,
 					const uint8_t *ipn, uint8_t ipn_len,
 					uint32_t cipher);
+typedef void (*handshake_eap_event_func_t)(unsigned int event,
+					const void *event_data,
+					void *user_data);
 =

 void __handshake_set_get_nonce_func(handshake_get_nonce_func_t func);
 void __handshake_set_install_tk_func(handshake_install_tk_func_t func);
@@ -123,11 +126,13 @@ struct handshake_state {
 	uint8_t proto_version : 2;
 	unsigned int gtk_index;
 	struct erp_cache_entry *erp_cache;
-	void *user_data;
 =

 	void (*free)(struct handshake_state *s);
 =

 	handshake_event_func_t event_func;
+	void *user_data;
+	handshake_eap_event_func_t eap_event_func;
+	void *eap_user_data;
 };
 =

 void handshake_state_free(struct handshake_state *s);
@@ -160,6 +165,9 @@ void handshake_state_set_kh_ids(struct handshake_state =
*s,
 void handshake_state_set_event_func(struct handshake_state *s,
 					handshake_event_func_t func,
 					void *user_data);
+void handshake_state_set_eap_event_func(struct handshake_state *s,
+						handshake_eap_event_func_t func,
+						void *user_data);
 void handshake_state_set_passphrase(struct handshake_state *s,
 					const char *passphrase);
 void handshake_state_set_no_rekey(struct handshake_state *s, bool no_rekey=
);
diff --git a/src/netdev.c b/src/netdev.c
index d9357a22..48cdb5c1 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2551,9 +2551,11 @@ int netdev_connect_wsc(struct netdev *netdev, struct=
 scan_bss *bss,
 	l_genl_msg_append_attr(cmd_connect, NL80211_ATTR_IE, ie_len, ie);
 	l_free(ie);
 =

+	handshake_state_set_eap_event_func(hs,
+					(handshake_eap_event_func_t) eapol_cb,
+					user_data);
+
 	sm =3D eapol_sm_new(hs);
-	eapol_sm_set_user_data(sm, user_data);
-	eapol_sm_set_event_func(sm, eapol_cb);
 =

 	return netdev_connect_common(netdev, cmd_connect, bss, hs, sm,
 						event_filter, cb, user_data);
-- =

2.20.1

--===============8242638240113811459==--

