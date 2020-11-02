Content-Type: multipart/mixed; boundary="===============1179277529242809720=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/3] ap: add StartProfile DBus method
Date: Mon, 02 Nov 2020 10:28:49 -0800
Message-ID: <20201102182851.2580877-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1179277529242809720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Users can now start an AP from settings based on a profile
on disk. The only argument is the SSID which will be used to
lookup the profile. If no profile is found a NotFound error
will be returned. Any invalid profiles will result in an
Invalid return.
---
 src/ap.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 src/ap.h |  3 +++
 2 files changed, 71 insertions(+), 2 deletions(-)

v2:
 * Removed the profile loading from ap_init and squashed that into
   this commit. =

 * This now loads the profiles on the fly when the dbus method is
   called. This avoids the need for any special ap_config handling
   of transient vs disk profiles.

diff --git a/src/ap.c b/src/ap.c
index f08835f7..4aabcd89 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -51,6 +51,7 @@
 #include "src/wscutil.h"
 #include "src/eap-wsc.h"
 #include "src/ap.h"
+#include "src/storage.h"
 =

 struct ap_state {
 	struct netdev *netdev;
@@ -231,6 +232,10 @@ void ap_config_free(struct ap_config *config)
 	explicit_bzero(config->psk, sizeof(config->psk));
 	l_free(config->authorized_macs);
 	l_free(config->wsc_name);
+
+	if (config->profile)
+		l_free(config->profile);
+
 	l_free(config);
 }
 =

@@ -2207,6 +2212,30 @@ static void ap_mlme_notify(struct l_genl_msg *msg, v=
oid *user_data)
 	}
 }
 =

+static bool ap_load_profile(struct ap_state *ap)
+{
+	char *passphrase;
+	L_AUTO_FREE_VAR(struct l_settings *, settings) =3D l_settings_new();
+
+	if (!l_settings_load_from_file(settings, ap->config->profile))
+		return false;
+
+	passphrase =3D l_settings_get_string(settings, "Security", "Passphrase");
+	if (passphrase) {
+		if (strlen(passphrase) > 63) {
+			l_error("[Security].Passphrase must not exceed "
+					"63 characters");
+			return false;
+		}
+
+		strcpy(ap->config->passphrase, passphrase);
+		l_free(passphrase);
+	}
+
+	l_info("Loaded AP configuration %s", ap->config->ssid);
+	return true;
+}
+
 /*
  * Start a simple independent WPA2 AP on given netdev.
  *
@@ -2237,8 +2266,8 @@ struct ap_state *ap_start(struct netdev *netdev, stru=
ct ap_config *config,
 	if (L_WARN_ON(!config->ssid))
 		return NULL;
 =

-	if (L_WARN_ON(!config->passphrase[0] && util_mem_is_zero(config->psk,
-							sizeof(config->psk))))
+	if (L_WARN_ON(!config->profile && !config->passphrase[0] &&
+			util_mem_is_zero(config->psk, sizeof(config->psk))))
 		return NULL;
 =

 	ap =3D l_new(struct ap_state, 1);
@@ -2248,6 +2277,9 @@ struct ap_state *ap_start(struct netdev *netdev, stru=
ct ap_config *config,
 	ap->ops =3D ops;
 	ap->user_data =3D user_data;
 =

+	if (config->profile && !ap_load_profile(ap))
+		goto error;
+
 	if (!config->channel)
 		/* TODO: Start a Get Survey to decide the channel */
 		config->channel =3D 6;
@@ -2698,6 +2730,37 @@ static struct l_dbus_message *ap_dbus_stop(struct l_=
dbus *dbus,
 	return NULL;
 }
 =

+static struct l_dbus_message *ap_dbus_start_profile(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct ap_if_data *ap_if =3D user_data;
+	const char *ssid;
+	struct ap_config *config;
+	int err;
+
+	if (ap_if->ap && ap_if->ap->started)
+		return dbus_error_already_exists(message);
+
+	if (ap_if->ap || ap_if->pending)
+		return dbus_error_busy(message);
+
+	if (!l_dbus_message_get_arguments(message, "s", &ssid))
+		return dbus_error_invalid_args(message);
+
+	config =3D l_new(struct ap_config, 1);
+	config->ssid =3D l_strdup(ssid);
+	/* This tells ap_start to pull settings from a profile on disk */
+	config->profile =3D storage_get_path("ap/%s.ap", ssid);
+
+	ap_if->ap =3D ap_start(ap_if->netdev, config, &ap_dbus_ops, &err, ap_if);
+	if (!ap_if->ap)
+		return dbus_error_from_errno(err, message);
+
+	ap_if->pending =3D l_dbus_message_ref(message);
+	return NULL;
+}
+
 static bool ap_dbus_property_get_started(struct l_dbus *dbus,
 					struct l_dbus_message *message,
 					struct l_dbus_message_builder *builder,
@@ -2716,6 +2779,9 @@ static void ap_setup_interface(struct l_dbus_interfac=
e *interface)
 	l_dbus_interface_method(interface, "Start", 0, ap_dbus_start, "",
 			"ss", "ssid", "wpa2_passphrase");
 	l_dbus_interface_method(interface, "Stop", 0, ap_dbus_stop, "", "");
+	l_dbus_interface_method(interface, "StartProfile", 0,
+					ap_dbus_start_profile, "", "s",
+					"ssid");
 =

 	l_dbus_interface_property(interface, "Started", 0, "b",
 					ap_dbus_property_get_started, NULL);
diff --git a/src/ap.h b/src/ap.h
index 1f2d438a..dc57a0bb 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -63,6 +63,9 @@ struct ap_config {
 	unsigned int authorized_macs_num;
 	char *wsc_name;
 	struct wsc_primary_device_type wsc_primary_device_type;
+
+	char *profile;
+
 	bool no_cck_rates : 1;
 };
 =

-- =

2.26.2

--===============1179277529242809720==--

