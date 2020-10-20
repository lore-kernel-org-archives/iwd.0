Content-Type: multipart/mixed; boundary="===============0092054782781459530=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 08/13] ap: remove 'psk' from Start()
Date: Tue, 20 Oct 2020 11:02:51 -0700
Message-ID: <20201020180256.1630120-8-prestwoj@gmail.com>
In-Reply-To: <20201020180256.1630120-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0092054782781459530==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This has been replaced by dedicated provisioning files.
---
 src/ap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 9df6e14e..41de69a9 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2394,7 +2394,7 @@ static struct l_dbus_message *ap_dbus_start(struct l_=
dbus *dbus,
 		struct l_dbus_message *message, void *user_data)
 {
 	struct ap_if_data *ap_if =3D user_data;
-	const char *ssid, *wpa2_passphrase;
+	const char *ssid;
 	struct ap_config *config;
 =

 	if (ap_if->ap && ap_if->ap->started)
@@ -2403,8 +2403,7 @@ static struct l_dbus_message *ap_dbus_start(struct l_=
dbus *dbus,
 	if (ap_if->ap || ap_if->pending)
 		return dbus_error_busy(message);
 =

-	if (!l_dbus_message_get_arguments(message, "ss",
-						&ssid, &wpa2_passphrase))
+	if (!l_dbus_message_get_arguments(message, "s", &ssid))
 		return dbus_error_invalid_args(message);
 =

 	config =3D l_queue_find(ap_configs, match_config_ssid, ssid);
@@ -2473,7 +2472,7 @@ static bool ap_dbus_property_get_started(struct l_dbu=
s *dbus,
 static void ap_setup_interface(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_method(interface, "Start", 0, ap_dbus_start, "",
-			"ss", "ssid", "wpa2_passphrase");
+			"s", "ssid");
 	l_dbus_interface_method(interface, "Stop", 0, ap_dbus_stop, "", "");
 =

 	l_dbus_interface_property(interface, "Started", 0, "b",
-- =

2.26.2

--===============0092054782781459530==--

