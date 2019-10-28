Content-Type: multipart/mixed; boundary="===============8042035499901739392=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 11/16] eapol: Drop unused eapol_sm_set_event_func
Date: Mon, 28 Oct 2019 15:05:03 +0100
Message-ID: <20191028140508.13518-11-andrew.zaborowski@intel.com>
In-Reply-To: <20191028140508.13518-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8042035499901739392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/eapol.c  | 6 ------
 src/eapol.h  | 1 -
 src/netdev.c | 2 --
 3 files changed, 9 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index f2a5611f..a7f1a039 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -823,7 +823,6 @@ struct eapol_sm {
 	struct handshake_state *handshake;
 	enum eapol_protocol_version protocol_version;
 	uint64_t replay_counter;
-	eapol_sm_event_func_t event_func;
 	void *user_data;
 	struct l_timeout *timeout;
 	struct l_timeout *eapol_start_timeout;
@@ -901,11 +900,6 @@ void eapol_sm_set_user_data(struct eapol_sm *sm, void =
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
diff --git a/src/eapol.h b/src/eapol.h
index 063315ce..0f9a6917 100644
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
diff --git a/src/netdev.c b/src/netdev.c
index eab7bd8f..72d4fc27 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2553,8 +2553,6 @@ int netdev_connect_wsc(struct netdev *netdev, struct =
scan_bss *bss,
 	l_free(ie);
 =

 	sm =3D eapol_sm_new(hs);
-	eapol_sm_set_user_data(sm, user_data);
-	eapol_sm_set_event_func(sm, eapol_cb);
 =

 	return netdev_connect_common(netdev, cmd_connect, bss, hs, sm,
 						event_filter, cb, user_data);
-- =

2.20.1

--===============8042035499901739392==--

