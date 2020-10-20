Content-Type: multipart/mixed; boundary="===============1626150936763664109=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 06/13] ap: refactor AP to use provisioning files
Date: Tue, 20 Oct 2020 11:02:49 -0700
Message-ID: <20201020180256.1630120-6-prestwoj@gmail.com>
In-Reply-To: <20201020180256.1630120-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1626150936763664109==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently the AP DBus APIs take an SSID and passphrase to start
an access point. This works for basic access points but isn't very
scaleable once other AP options are added.

Instead we can define AP networks similar to how we define station
networks by providing a provisioning file. The provisioning files
for AP will reside in $STATE_DIRECTORY/ap (/var/lib/iwd/ap by
default). The name of the file indicates the SSID and, for now,
the only value will be [Security].Passphrase to match the DBus
API. The file extension does not matter at this point, but in tests
and examples *.ap will be used.

AP provisioning files will be loaded in at startup and remain as
static configs in a queue. When Start() is called the ssid will be
looked up and that config will be used. If no config is found
a "Not Found" error will be returned.
---
 src/ap.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 src/ap.h |   1 +
 2 files changed, 99 insertions(+), 8 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 3c4ae907..9df6e14e 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -26,6 +26,7 @@
 =

 #include <errno.h>
 #include <linux/if_ether.h>
+#include <dirent.h>
 =

 #include <ell/ell.h>
 =

@@ -49,6 +50,7 @@
 #include "src/wscutil.h"
 #include "src/eap-wsc.h"
 #include "src/ap.h"
+#include "src/storage.h"
 =

 struct ap_state {
 	struct netdev *netdev;
@@ -105,6 +107,7 @@ struct ap_wsc_pbc_probe_record {
 };
 =

 static uint32_t netdev_watch;
+static struct l_queue *ap_configs;
 =

 void ap_config_free(struct ap_config *config)
 {
@@ -186,7 +189,10 @@ static void ap_reset(struct ap_state *ap)
 	if (ap->rates)
 		l_uintset_free(ap->rates);
 =

-	ap_config_free(ap->config);
+
+	if (!ap->config->no_free)
+		ap_config_free(ap->config);
+
 	ap->config =3D NULL;
 =

 	l_queue_destroy(ap->wsc_pbc_probes, l_free);
@@ -2376,6 +2382,14 @@ static const struct ap_ops ap_dbus_ops =3D {
 	.handle_event =3D ap_if_event_func,
 };
 =

+static bool match_config_ssid(const void *data, const void *user_data)
+{
+	const struct ap_config *config =3D data;
+	const char *ssid =3D user_data;
+
+	return !strcmp(config->ssid, ssid);
+}
+
 static struct l_dbus_message *ap_dbus_start(struct l_dbus *dbus,
 		struct l_dbus_message *message, void *user_data)
 {
@@ -2393,16 +2407,13 @@ static struct l_dbus_message *ap_dbus_start(struct =
l_dbus *dbus,
 						&ssid, &wpa2_passphrase))
 		return dbus_error_invalid_args(message);
 =

-	config =3D l_new(struct ap_config, 1);
-	config->ssid =3D l_strdup(ssid);
-	l_strlcpy(config->passphrase, wpa2_passphrase,
-			sizeof(config->passphrase));
+	config =3D l_queue_find(ap_configs, match_config_ssid, ssid);
+	if (!config)
+		return dbus_error_not_found(message);
 =

 	ap_if->ap =3D ap_start(ap_if->netdev, config, &ap_dbus_ops, ap_if);
-	if (!ap_if->ap) {
-		ap_config_free(config);
+	if (!ap_if->ap)
 		return dbus_error_invalid_args(message);
-	}
 =

 	ap_if->pending =3D l_dbus_message_ref(message);
 	return NULL;
@@ -2528,13 +2539,90 @@ static void ap_netdev_watch(struct netdev *netdev,
 	}
 }
 =

+static struct ap_config *ap_config_from_settings(struct l_settings *settin=
gs,
+							const char *ssid)
+{
+	struct ap_config *config =3D l_new(struct ap_config, 1);
+	char *passphrase;
+
+	/*
+	 * Dont free when ap interface goes up/down. This is a static config
+	 * that we want to keep around until IWD stops.
+	 */
+	config->no_free =3D true;
+	config->ssid =3D l_strdup(ssid);
+
+	passphrase =3D l_settings_get_string(settings, "Security", "Passphrase");
+	if (passphrase) {
+		if (strlen(passphrase) > 63) {
+			l_error("[Security].Passphrase must not exceed "
+					"63 characters");
+			goto failed;
+		}
+
+		strcpy(config->passphrase, passphrase);
+		l_free(passphrase);
+	}
+
+done:
+	l_info("Loaded AP configuration %s", config->ssid);
+	return config;
+
+failed:
+	ap_config_free(config);
+	return NULL;
+}
+
 static int ap_init(void)
 {
+	DIR *dir;
+	struct dirent *dirent;
+
+	L_AUTO_FREE_VAR(char *, ap_dir) =3D storage_get_ap_path(NULL);
+
 	netdev_watch =3D netdev_watch_add(ap_netdev_watch, NULL, NULL);
 =

 	l_dbus_register_interface(dbus_get_bus(), IWD_AP_INTERFACE,
 			ap_setup_interface, ap_destroy_interface, false);
 =

+	ap_configs =3D l_queue_new();
+
+	dir =3D opendir(ap_dir);
+	if (!dir)
+		return -ENOENT;
+
+	while ((dirent =3D readdir(dir))) {
+		struct ap_config *config;
+		struct l_settings *s;
+		char *filename;
+		const char *ssid;
+
+		if (dirent->d_type !=3D DT_REG && dirent->d_type !=3D DT_LNK)
+			continue;
+
+		filename =3D l_strdup_printf("%s/%s", ap_dir, dirent->d_name);
+		s =3D l_settings_new();
+
+		if (!l_settings_load_from_file(s, filename))
+			goto next;
+
+		ssid =3D storage_network_ssid_from_path(filename, NULL);
+
+		config =3D ap_config_from_settings(s, ssid);
+		if (!config)
+			goto next;
+
+		l_debug("loaded ap config %s", filename);
+
+		l_queue_push_head(ap_configs, config);
+
+next:
+		l_free(filename);
+		l_settings_free(s);
+	}
+
+	closedir(dir);
+
 	return 0;
 }
 =

@@ -2542,6 +2630,8 @@ static void ap_exit(void)
 {
 	netdev_watch_remove(netdev_watch);
 	l_dbus_unregister_interface(dbus_get_bus(), IWD_AP_INTERFACE);
+
+	l_queue_destroy(ap_configs, (l_queue_destroy_func_t) ap_config_free);
 }
 =

 IWD_MODULE(ap, ap_init, ap_exit)
diff --git a/src/ap.h b/src/ap.h
index a39797aa..90497008 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -64,6 +64,7 @@ struct ap_config {
 	char *wsc_name;
 	struct wsc_primary_device_type wsc_primary_device_type;
 	bool no_cck_rates : 1;
+	bool no_free : 1;
 };
 =

 struct ap_ops {
-- =

2.26.2

--===============1626150936763664109==--

