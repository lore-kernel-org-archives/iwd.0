Content-Type: multipart/mixed; boundary="===============7408470723464284550=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/6] client: add a few return checks
Date: Fri, 18 Mar 2022 09:44:15 -0700
Message-ID: <20220318164420.739968-1-prestwoj@gmail.com>

--===============7408470723464284550==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These were caught by static analysis
---
 client/daemon.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/client/daemon.c b/client/daemon.c
index 509f8137..64bb41c9 100644
--- a/client/daemon.c
+++ b/client/daemon.c
@@ -57,24 +57,26 @@ static void get_info_callback(struct l_dbus_message *me=
ssage, void *user_data)
 	if (dbus_message_has_error(message))
 		return;
 =

-	if (!l_dbus_message_get_arguments(message, "a{sv}", &iter)) {
-		l_error("Failed to parse GetInfo message");
-		return;
-	}
+	if (!l_dbus_message_get_arguments(message, "a{sv}", &iter))
+		goto parse_failed;
 =

 	while (l_dbus_message_iter_next_entry(&iter, &key, &variant)) {
 		if (strcmp(key, "NetworkConfigurationEnabled"))
 			continue;
 =

-		l_dbus_message_iter_get_variant(&variant, "b",
-							&netconfig_enabled);
+		if (!l_dbus_message_iter_get_variant(&variant, "b",
+							&netconfig_enabled))
+			goto parse_failed;
+
 		break;
 	}
 =

 	if (!command_is_interactive_mode())
 		return;
 =

-	l_dbus_message_get_arguments(message, "a{sv}", &iter);
+	if (!l_dbus_message_get_arguments(message, "a{sv}", &iter))
+		goto parse_failed;
+
 	display("NetworkConfigurationEnabled: %s\n",
 				netconfig_enabled ? "enabled" : "disabled");
 =

@@ -90,6 +92,12 @@ static void get_info_callback(struct l_dbus_message *mes=
sage, void *user_data)
 			display("%s: %s\n", key, sval);
 		}
 	}
+
+	return;
+
+parse_failed:
+	l_error("Failed to parse GetInfo message");
+	return;
 }
 =

 static bool daemon_get_info(void)
-- =

2.34.1

--===============7408470723464284550==--

