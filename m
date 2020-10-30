Content-Type: multipart/mixed; boundary="===============6090862992134303888=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/5] ap: add provisioning file parsing
Date: Fri, 30 Oct 2020 09:34:11 -0700
Message-ID: <20201030163413.2446645-3-prestwoj@gmail.com>
In-Reply-To: <20201030163413.2446645-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6090862992134303888==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently AP's are quite limited in configuration options. The
Start() method is great for very basic cases but if the user
requires specific options (security, DHCP, etc.) there is not
any way of configuring them.

For these cases we can allow additional options to be added using
AP provisioning files similar to how we define station networks.
The provisioning files for AP will reside in $STATE_DIRECTORY/ap
(/var/lib/iwd/ap by default). The name of the file indicates the
SSID and, for now, the only value will be [Security].Passphrase
until more options are added. The file extension does not matter at
this point, but in tests and examples *.ap will be used.

AP provisioning files will be loaded in at startup and remain as
static configs in a queue.
---
 src/ap.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/ap.h |  3 ++
 2 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/src/ap.c b/src/ap.c
index f08835f7..956b7be9 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -28,6 +28,7 @@
 #include <linux/if_ether.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
+#include <dirent.h>
 =

 #include <ell/ell.h>
 =

@@ -51,6 +52,7 @@
 #include "src/wscutil.h"
 #include "src/eap-wsc.h"
 #include "src/ap.h"
+#include "src/storage.h"
 =

 struct ap_state {
 	struct netdev *netdev;
@@ -125,6 +127,7 @@ struct ap_ip_pool {
 struct ap_ip_pool pool;
 static uint32_t netdev_watch;
 struct l_netlink *rtnl;
+static struct l_queue *ap_configs;
 =

 /*
  * Creates pool of IPs which AP intefaces can use. Each call to ip_pool_get
@@ -231,6 +234,10 @@ void ap_config_free(struct ap_config *config)
 	explicit_bzero(config->psk, sizeof(config->psk));
 	l_free(config->authorized_macs);
 	l_free(config->wsc_name);
+
+	if (config->config_file)
+		l_free(config->config_file);
+
 	l_free(config);
 }
 =

@@ -303,7 +310,13 @@ static void ap_reset(struct ap_state *ap)
 	if (ap->rates)
 		l_uintset_free(ap->rates);
 =

-	ap_config_free(ap->config);
+	/*
+	 * Only free a non file based config. Configs which are created from
+	 * provisioning files should be kept around until IWD exits
+	 */
+	if (ap->config->config_file)
+		ap_config_free(ap->config);
+
 	ap->config =3D NULL;
 =

 	l_queue_destroy(ap->wsc_pbc_probes, l_free);
@@ -2780,10 +2793,41 @@ static void ap_netdev_watch(struct netdev *netdev,
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
 	const struct l_settings *settings =3D iwd_get_config();
 	bool dhcp_enable =3D false;
+	DIR *dir;
+	struct dirent *dirent;
+	L_AUTO_FREE_VAR(char *, ap_dir) =3D storage_get_ap_path(NULL);
 =

 	netdev_watch =3D netdev_watch_add(ap_netdev_watch, NULL, NULL);
 =

@@ -2814,6 +2858,44 @@ static int ap_init(void)
 		rtnl =3D iwd_get_rtnl();
 	}
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
+		ssid =3D storage_network_filename_from_path(filename);
+
+		config =3D ap_config_from_settings(s, ssid);
+		if (!config)
+			goto next;
+
+		config->config_file =3D l_strdup(filename);
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

@@ -2823,6 +2905,8 @@ static void ap_exit(void)
 	l_dbus_unregister_interface(dbus_get_bus(), IWD_AP_INTERFACE);
 =

 	ip_pool_destroy();
+
+	l_queue_destroy(ap_configs, (l_queue_destroy_func_t) ap_config_free);
 }
 =

 IWD_MODULE(ap, ap_init, ap_exit)
diff --git a/src/ap.h b/src/ap.h
index 1f2d438a..b3fcb882 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -63,6 +63,9 @@ struct ap_config {
 	unsigned int authorized_macs_num;
 	char *wsc_name;
 	struct wsc_primary_device_type wsc_primary_device_type;
+
+	char *config_file;
+
 	bool no_cck_rates : 1;
 };
 =

-- =

2.26.2

--===============6090862992134303888==--

