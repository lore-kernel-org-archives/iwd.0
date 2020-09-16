Content-Type: multipart/mixed; boundary="===============8991291365543908562=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/6] ap: Rename wpa2_psk to wpa2_passphrase on DBus
Date: Wed, 16 Sep 2020 11:17:51 +0200
Message-ID: <20200916091754.516851-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200916091754.516851-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8991291365543908562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the passphrase naming instead of PSK.
---
 src/ap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 626c983b..4f90323b 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2392,7 +2392,7 @@ static struct l_dbus_message *ap_dbus_start(struct l_=
dbus *dbus,
 		struct l_dbus_message *message, void *user_data)
 {
 	struct ap_if_data *ap_if =3D user_data;
-	const char *ssid, *wpa2_psk;
+	const char *ssid, *wpa2_passphrase;
 	struct ap_config *config;
 =

 	if (ap_if->ap && ap_if->ap->started)
@@ -2401,12 +2401,14 @@ static struct l_dbus_message *ap_dbus_start(struct =
l_dbus *dbus,
 	if (ap_if->ap || ap_if->pending)
 		return dbus_error_busy(message);
 =

-	if (!l_dbus_message_get_arguments(message, "ss", &ssid, &wpa2_psk))
+	if (!l_dbus_message_get_arguments(message, "ss",
+						&ssid, &wpa2_passphrase))
 		return dbus_error_invalid_args(message);
 =

 	config =3D l_new(struct ap_config, 1);
 	config->ssid =3D l_strdup(ssid);
-	l_strlcpy(config->passphrase, wpa2_psk, sizeof(config->passphrase));
+	l_strlcpy(config->passphrase, wpa2_passphrase,
+			sizeof(config->passphrase));
 =

 	ap_if->ap =3D ap_start(ap_if->netdev, config, &ap_dbus_ops, ap_if);
 	if (!ap_if->ap) {
@@ -2472,7 +2474,7 @@ static bool ap_dbus_property_get_started(struct l_dbu=
s *dbus,
 static void ap_setup_interface(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_method(interface, "Start", 0, ap_dbus_start, "",
-			"ss", "ssid", "wpa2_psk");
+			"ss", "ssid", "wpa2_passphrase");
 	l_dbus_interface_method(interface, "Stop", 0, ap_dbus_stop, "", "");
 =

 	l_dbus_interface_property(interface, "Started", 0, "b",
-- =

2.25.1

--===============8991291365543908562==--

