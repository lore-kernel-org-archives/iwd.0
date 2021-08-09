Content-Type: multipart/mixed; boundary="===============0544335618647276520=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/4] station: move Roam() under station debug interface
Date: Mon, 09 Aug 2021 10:42:58 -0700
Message-ID: <20210809174259.537399-3-prestwoj@gmail.com>
In-Reply-To: <20210809174259.537399-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0544335618647276520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/station.c b/src/station.c
index 9a053c85..02e61c10 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3804,10 +3804,6 @@ static void station_setup_diagnostic_interface(
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
@@ -3859,6 +3855,8 @@ static void station_setup_debug_interface(
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

--===============0544335618647276520==--

