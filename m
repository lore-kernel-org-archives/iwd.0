Content-Type: multipart/mixed; boundary="===============7159365690449672569=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 12/12] eap: utilize IWD_MODULE
Date: Fri, 11 Oct 2019 12:29:33 -0700
Message-ID: <20191011192933.13550-12-prestwoj@gmail.com>
In-Reply-To: <20191011192933.13550-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7159365690449672569==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Converts eap into an IWD module.
---
 src/eap.c  | 7 ++++++-
 src/eap.h  | 2 +-
 src/main.c | 4 ----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/src/eap.c b/src/eap.c
index b0fa72cf..23868811 100644
--- a/src/eap.c
+++ b/src/eap.c
@@ -33,6 +33,7 @@
 #include "src/missing.h"
 #include "src/eap.h"
 #include "src/eap-private.h"
+#include "src/iwd.h"
 =

 static uint32_t default_mtu;
 static struct l_queue *eap_methods;
@@ -721,7 +722,7 @@ static void __eap_method_disable(struct eap_method_desc=
 *start,
 extern struct eap_method_desc __start___eap[];
 extern struct eap_method_desc __stop___eap[];
 =

-void eap_init(void)
+int eap_init(void)
 {
 	eap_methods =3D l_queue_new();
 	__eap_method_enable(__start___eap, __stop___eap);
@@ -733,6 +734,8 @@ void eap_init(void)
 	 */
 	if (default_mtu =3D=3D 0)
 		default_mtu =3D 1020;
+
+	return 0;
 }
 =

 void eap_exit(void)
@@ -740,3 +743,5 @@ void eap_exit(void)
 	__eap_method_disable(__start___eap, __stop___eap);
 	l_queue_destroy(eap_methods, NULL);
 }
+
+IWD_MODULE(eap, eap_init, eap_exit);
diff --git a/src/eap.h b/src/eap.h
index 8f128304..8b2de8c9 100644
--- a/src/eap.h
+++ b/src/eap.h
@@ -95,5 +95,5 @@ void eap_rx_packet(struct eap_state *eap, const uint8_t *=
pkt, size_t len);
 =

 void __eap_set_config(struct l_settings *config);
 =

-void eap_init(void);
+int eap_init(void);
 void eap_exit(void);
diff --git a/src/main.c b/src/main.c
index 1ff8d5d8..871104dd 100644
--- a/src/main.c
+++ b/src/main.c
@@ -493,15 +493,11 @@ int main(int argc, char *argv[])
 	l_dbus_set_disconnect_handler(dbus, dbus_disconnected, NULL, NULL);
 	dbus_init(dbus);
 =

-	eap_init();
-
 	exit_status =3D l_main_run_with_signal(signal_handler, NULL);
 	plugin_exit();
 =

 	iwd_modules_exit();
 =

-	eap_exit();
-
 	dbus_exit();
 	l_dbus_destroy(dbus);
 	storage_cleanup_dirs();
-- =

2.17.1

--===============7159365690449672569==--

