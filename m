Content-Type: multipart/mixed; boundary="===============2482304193482168986=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 8/8] ofono: Validate message parsing
Date: Wed, 23 Oct 2019 13:24:03 -0700
Message-ID: <20191023202403.9690-8-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191023202403.9690-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2482304193482168986==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/plugins/ofono.c b/plugins/ofono.c
index 3120ea70..b13b3fb9 100644
--- a/plugins/ofono.c
+++ b/plugins/ofono.c
@@ -624,7 +624,8 @@ static void interfaces_changed_cb(struct l_dbus_message=
 *message,
 	struct l_dbus_message_iter value;
 	const char *key;
 =

-	l_dbus_message_get_arguments(message, "sv", &key, &value);
+	if (!l_dbus_message_get_arguments(message, "sv", &key, &value))
+		return;
 =

 	if (!strcmp(key, "Interfaces"))
 		parse_interfaces(&value, modem);
@@ -718,10 +719,11 @@ static void get_modems_cb(struct l_dbus_message *repl=
y, void *user_data)
 =

 	modems =3D l_queue_new();
 =

-	l_dbus_message_get_arguments(reply, "a(oa{sv})", &modem_list);
-
-	while (l_dbus_message_iter_next_entry(&modem_list, &path, &props))
-		parse_modem(path, &props);
+	if (l_dbus_message_get_arguments(reply, "a(oa{sv})", &modem_list)) {
+		while (l_dbus_message_iter_next_entry(&modem_list, &path,
+									&props))
+			parse_modem(path, &props);
+	}
 =

 	/* watch for modems being added/removed */
 	modem_add_watch =3D l_dbus_add_signal_watch(dbus_get_bus(),
-- =

2.13.6

--===============2482304193482168986==--

