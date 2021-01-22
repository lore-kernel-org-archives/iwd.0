Content-Type: multipart/mixed; boundary="===============8917759965301093004=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 7/7] client: update station to use diagnostic_display
Date: Fri, 22 Jan 2021 10:14:34 -0800
Message-ID: <20210122181434.644707-7-prestwoj@gmail.com>
In-Reply-To: <20210122181434.644707-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8917759965301093004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 client/station.c | 50 ++----------------------------------------------
 1 file changed, 2 insertions(+), 48 deletions(-)

diff --git a/client/station.c b/client/station.c
index 93b1a4da..0bda604c 100644
--- a/client/station.c
+++ b/client/station.c
@@ -31,6 +31,7 @@
 #include "client/device.h"
 #include "client/network.h"
 #include "client/display.h"
+#include "client/diagnostic.h"
 =

 struct station {
 	bool scanning;
@@ -597,8 +598,6 @@ static void get_diagnostics_callback(struct l_dbus_mess=
age *message,
 					void *user_data)
 {
 	struct l_dbus_message_iter iter;
-	struct l_dbus_message_iter variant;
-	const char *key;
 =

 	if (dbus_message_has_error(message))
 		return;
@@ -608,52 +607,7 @@ static void get_diagnostics_callback(struct l_dbus_mes=
sage *message,
 		goto done;
 	}
 =

-	while (l_dbus_message_iter_next_entry(&iter, &key, &variant)) {
-		const char *s_value;
-		uint32_t u_value;
-		int16_t i_value;
-		uint8_t y_value;
-
-		if (!strcmp(key, "ConnectedBss") || !strcmp(key, "RxMode") ||
-				!strcmp(key, "TxMode")) {
-			/* String variants with no special handling */
-
-			l_dbus_message_iter_get_variant(&variant, "s",
-							&s_value);
-
-			display("%s%*s  %-*s%-*s\n", MARGIN, 8, "", 20,
-				key, 47, s_value);
-		} else if (!strcmp(key, "RxBitrate") ||
-				!strcmp(key, "TxBitrate")) {
-			/* Bitrates expressed in 100Kbit/s */
-
-			l_dbus_message_iter_get_variant(&variant, "u",
-							&u_value);
-			display("%s%*s  %-*s%u Kbit/s\n", MARGIN, 8, "", 20,
-				key, u_value * 100);
-		} else if (!strcmp(key, "ExpectedThroughput")) {
-			/* ExpectedThroughput expressed in Kbit/s */
-
-			l_dbus_message_iter_get_variant(&variant, "u",
-							&u_value);
-			display("%s%*s  %-*s%u Kbit/s\n", MARGIN, 8, "", 20,
-				key, u_value);
-		} else if (!strcmp(key, "RSSI")) {
-			/* RSSI expressed in dBm */
-
-			l_dbus_message_iter_get_variant(&variant, "n",
-							&i_value);
-			display("%s%*s  %-*s%i dBm\n", MARGIN, 8, "", 20,
-				key, i_value);
-		} else if (!strcmp(key, "RxMCS") || !strcmp(key, "TxMCS")) {
-			/* MCS index's are single byte integers */
-
-			l_dbus_message_iter_get_variant(&variant, "y",
-							&y_value);
-			display("%s%*s  %-*s%u\n", MARGIN, 8, "", 20,
-				key, y_value);
-		}
-	}
+	diagnostic_display(&iter, "            ", 20, 20);
 =

 done:
 	/* Finish the table started by cmd_show */
-- =

2.26.2

--===============8917759965301093004==--

