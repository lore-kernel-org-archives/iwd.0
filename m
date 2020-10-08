Content-Type: multipart/mixed; boundary="===============0175585270075886108=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/5] station: Stop autoconnect for the hidden SSID scan
Date: Thu, 08 Oct 2020 10:49:10 +0200
Message-ID: <20201008084911.1046485-4-andrew.zaborowski@intel.com>
In-Reply-To: <20201008084911.1046485-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0175585270075886108==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/src/station.c b/src/station.c
index b70d3416..befc4e25 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2557,12 +2557,12 @@ static bool station_hidden_network_scan_results(int=
 err,
 =

 	if (err) {
 		dbus_pending_reply(&msg, dbus_error_failed(msg));
-		return false;
+		goto error;
 	}
 =

 	if (!l_dbus_message_get_arguments(msg, "s", &ssid)) {
 		dbus_pending_reply(&msg, dbus_error_invalid_args(msg));
-		return false;
+		goto error;
 	}
 =

 	ssid_len =3D strlen(ssid);
@@ -2587,19 +2587,17 @@ next:
 		scan_bss_free(bss);
 	}
 =

-	l_queue_destroy(bss_list, NULL);
-
 	network_psk =3D station_network_find(station, ssid, SECURITY_PSK);
 	network_open =3D station_network_find(station, ssid, SECURITY_NONE);
 =

 	if (!network_psk && !network_open) {
 		dbus_pending_reply(&msg, dbus_error_not_found(msg));
-		return true;
+		goto error;
 	}
 =

 	if (network_psk && network_open) {
 		dbus_pending_reply(&msg, dbus_error_service_set_overlap(msg));
-		return true;
+		goto error;
 	}
 =

 	network =3D network_psk ? : network_open;
@@ -2607,6 +2605,12 @@ next:
 	network_connect_new_hidden_network(network, &msg);
 	l_dbus_message_unref(msg);
 =

+	l_queue_destroy(bss_list, NULL);
+	return true;
+
+error:
+	l_queue_destroy(bss_list, (l_queue_destroy_func_t) scan_bss_free);
+	station_set_autoconnect(station, true);
 	return true;
 }
 =

@@ -2659,6 +2663,7 @@ static struct l_dbus_message *station_dbus_connect_hi=
dden_network(
 		return dbus_error_failed(message);
 =

 	station->hidden_pending =3D l_dbus_message_ref(message);
+	station_set_autoconnect(station, false);
 =

 	return NULL;
 }
-- =

2.25.1

--===============0175585270075886108==--

