Content-Type: multipart/mixed; boundary="===============4950980744305591397=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 08/11] eap: remove mtu argument from eap_init
Date: Fri, 11 Oct 2019 10:24:14 -0700
Message-ID: <20191011172417.23328-8-prestwoj@gmail.com>
In-Reply-To: <20191011172417.23328-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4950980744305591397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This was refactored to set the mtu via __eap_set_config rather than
passing the MTU into eap_init. This makes eap work in a similar fashion
as eapol (i.e. __eapol_set_config).

If __eap_set_config is not used, the MTU will be set to 1020, which is
the same as previously passing 0 to eap_init.
---
 src/eap.c  | 12 ++++++++----
 src/eap.h  |  4 +++-
 src/main.c |  7 ++-----
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/src/eap.c b/src/eap.c
index f605f432..b0fa72cf 100644
--- a/src/eap.c
+++ b/src/eap.c
@@ -676,6 +676,12 @@ int eap_unregister_method(struct eap_method *method)
 	return -ENOENT;
 }
 =

+void __eap_set_config(struct l_settings *config)
+{
+	if (!l_settings_get_uint(config, "EAP", "mtu", &default_mtu))
+		default_mtu =3D 1400; /* on WiFi the real MTU is around 2304 */
+}
+
 static void __eap_method_enable(struct eap_method_desc *start,
 					struct eap_method_desc *stop)
 {
@@ -715,7 +721,7 @@ static void __eap_method_disable(struct eap_method_desc=
 *start,
 extern struct eap_method_desc __start___eap[];
 extern struct eap_method_desc __stop___eap[];
 =

-void eap_init(uint32_t mtu)
+void eap_init(void)
 {
 	eap_methods =3D l_queue_new();
 	__eap_method_enable(__start___eap, __stop___eap);
@@ -725,10 +731,8 @@ void eap_init(uint32_t mtu)
 	 * EAP is capable of functioning on lower layers that
 	 *        provide an EAP MTU size of 1020 octets or greater.
 	 */
-	if (mtu =3D=3D 0)
+	if (default_mtu =3D=3D 0)
 		default_mtu =3D 1020;
-	else
-		default_mtu =3D mtu;
 }
 =

 void eap_exit(void)
diff --git a/src/eap.h b/src/eap.h
index de939cdc..8f128304 100644
--- a/src/eap.h
+++ b/src/eap.h
@@ -93,5 +93,7 @@ const char *eap_get_identity(struct eap_state *eap);
 =

 void eap_rx_packet(struct eap_state *eap, const uint8_t *pkt, size_t len);
 =

-void eap_init(uint32_t default_mtu);
+void __eap_set_config(struct l_settings *config);
+
+void eap_init(void);
 void eap_exit(void);
diff --git a/src/main.c b/src/main.c
index 9d0da143..7123f7a9 100644
--- a/src/main.c
+++ b/src/main.c
@@ -365,7 +365,6 @@ int main(int argc, char *argv[])
 	struct l_dbus *dbus;
 	const char *config_dir;
 	char **config_dirs;
-	uint32_t eap_mtu;
 	int i;
 =

 	for (;;) {
@@ -463,9 +462,7 @@ int main(int argc, char *argv[])
 	l_strv_free(config_dirs);
 =

 	__eapol_set_config(iwd_config);
-
-	if (!l_settings_get_uint(iwd_config, "EAP", "mtu", &eap_mtu))
-		eap_mtu =3D 1400; /* on WiFi the real MTU is around 2304 */
+	__eap_set_config(iwd_config);
 =

 	exit_status =3D EXIT_FAILURE;
 =

@@ -494,7 +491,7 @@ int main(int argc, char *argv[])
 	l_dbus_set_disconnect_handler(dbus, dbus_disconnected, NULL, NULL);
 	dbus_init(dbus);
 =

-	eap_init(eap_mtu);
+	eap_init();
 =

 	plugin_init(plugins, noplugins);
 	exit_status =3D l_main_run_with_signal(signal_handler, NULL);
-- =

2.17.1

--===============4950980744305591397==--

