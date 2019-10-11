Content-Type: multipart/mixed; boundary="===============1963432780823326503=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 03/11] eapol: utilize IWD_MODULE
Date: Fri, 11 Oct 2019 10:24:09 -0700
Message-ID: <20191011172417.23328-3-prestwoj@gmail.com>
In-Reply-To: <20191011172417.23328-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1963432780823326503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This converts eapol to using IWD modules. The init/exit APIs did need
to remain exposed for unit tests.

Netdev was updated to depend on eapol.
---
 src/eapol.c  | 11 ++++++-----
 src/eapol.h  |  4 ++--
 src/main.c   |  2 --
 src/netdev.c |  1 +
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 414d1c69..6732b370 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -40,6 +40,7 @@
 #include "src/handshake.h"
 #include "src/watchlist.h"
 #include "src/erp.h"
+#include "src/iwd.h"
 =

 static struct l_queue *state_machines;
 static struct l_queue *preauths;
@@ -2705,16 +2706,16 @@ void __eapol_set_config(struct l_settings *config)
 		eapol_4way_handshake_time =3D 5;
 }
 =

-bool eapol_init()
+int eapol_init(void)
 {
 	state_machines =3D l_queue_new();
 	preauths =3D l_queue_new();
 	watchlist_init(&frame_watches, &eapol_frame_watch_ops);
 =

-	return true;
+	return 0;
 }
 =

-bool eapol_exit()
+void eapol_exit(void)
 {
 	if (!l_queue_isempty(state_machines))
 		l_warn("stale eapol state machines found");
@@ -2727,6 +2728,6 @@ bool eapol_exit()
 	l_queue_destroy(preauths, preauth_sm_destroy);
 =

 	watchlist_destroy(&frame_watches);
-
-	return true;
 }
+
+IWD_MODULE(eapol, eapol_init, eapol_exit);
diff --git a/src/eapol.h b/src/eapol.h
index 1a1862bd..9462b56d 100644
--- a/src/eapol.h
+++ b/src/eapol.h
@@ -128,5 +128,5 @@ struct preauth_sm *eapol_preauth_start(const uint8_t *a=
a,
 					eapol_preauth_destroy_func_t destroy);
 void eapol_preauth_cancel(uint32_t ifindex);
 =

-bool eapol_init();
-bool eapol_exit();
+int eapol_init(void);
+void eapol_exit(void);
diff --git a/src/main.c b/src/main.c
index 7707dfb8..2e8d4a6d 100644
--- a/src/main.c
+++ b/src/main.c
@@ -480,7 +480,6 @@ int main(int argc, char *argv[])
 	dbus_init(dbus);
 =

 	eap_init(eap_mtu);
-	eapol_init();
 =

 	plugin_init(plugins, noplugins);
 	exit_status =3D l_main_run_with_signal(signal_handler, NULL);
@@ -488,7 +487,6 @@ int main(int argc, char *argv[])
 =

 	iwd_modules_exit();
 =

-	eapol_exit();
 	eap_exit();
 =

 	if (nl80211) {
diff --git a/src/netdev.c b/src/netdev.c
index 1828f5d0..0785f0c4 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4841,3 +4841,4 @@ void netdev_shutdown(void)
 }
 =

 IWD_MODULE(netdev, netdev_init, netdev_exit);
+IWD_MODULE_DEPENDS(netdev, eapol);
-- =

2.17.1

--===============1963432780823326503==--

