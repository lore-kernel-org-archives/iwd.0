Content-Type: multipart/mixed; boundary="===============4973471921817301461=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 2/3] station: move Roam() under station debug interface
Date: Thu, 12 Aug 2021 12:07:22 -0700
Message-ID: <20210812190723.732722-2-prestwoj@gmail.com>
In-Reply-To: <20210812190723.732722-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4973471921817301461==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/station.c b/src/station.c
index 49f78fce..f77fd663 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3783,10 +3783,6 @@ static void station_setup_diagnostic_interface(
 	l_dbus_interface_method(interface, "GetDiagnostics", 0,
 				station_get_diagnostics, "a{sv}", "",
 				"diagnostics");
-
-	if (iwd_is_developer_mode())
-		l_dbus_interface_method(interface, "Roam", 0,
-					station_force_roam, "", "ay", "mac");
 }
 =

 static void station_destroy_diagnostic_interface(void *user_data)
@@ -3841,6 +3837,8 @@ static void station_setup_debug_interface(
 	l_dbus_interface_method(interface, "ConnectBssid", 0,
 					station_force_connect_bssid, "", "ay",
 					"mac");
+	l_dbus_interface_method(interface, "Roam", 0,
+					station_force_roam, "", "ay", "mac");
 }
 =

 static void ap_roam_frame_event(const struct mmpdu_header *hdr,
-- =

2.31.1

--===============4973471921817301461==--

