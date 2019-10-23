Content-Type: multipart/mixed; boundary="===============0294620384151193289=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 1/8] client: Treat invalid DBus reply same as an error
Date: Wed, 23 Oct 2019 13:23:56 -0700
Message-ID: <20191023202403.9690-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0294620384151193289==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 client/dbus-proxy.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
index 3e7a7f8e..1bd90aff 100644
--- a/client/dbus-proxy.c
+++ b/client/dbus-proxy.c
@@ -699,7 +699,16 @@ static void get_managed_objects_callback(struct l_dbus=
_message *message,
 		return;
 	}
 =

-	l_dbus_message_get_arguments(message, "a{oa{sa{sv}}}", &objects);
+	if (!l_dbus_message_get_arguments(message, "a{oa{sa{sv}}}", &objects)) {
+		l_error("Failed to parse IWD dbus objects, quitting...\n");
+
+		if (!command_is_interactive_mode())
+			command_set_exit_status(EXIT_FAILURE);
+
+		l_main_quit();
+
+		return;
+	}
 =

 	while (l_dbus_message_iter_next_entry(&objects, &path, &object))
 		proxy_interface_create(path, &object);
-- =

2.13.6

--===============0294620384151193289==--

