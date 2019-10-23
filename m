Content-Type: multipart/mixed; boundary="===============3842719095739922189=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 2/8] client: Ignore invalid notifications
Date: Wed, 23 Oct 2019 13:23:57 -0700
Message-ID: <20191023202403.9690-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191023202403.9690-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3842719095739922189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 client/dbus-proxy.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
index 1bd90aff..26c0511d 100644
--- a/client/dbus-proxy.c
+++ b/client/dbus-proxy.c
@@ -651,7 +651,9 @@ static void interfaces_added_callback(struct l_dbus_mes=
sage *message,
 	if (dbus_message_has_error(message))
 		return;
 =

-	l_dbus_message_get_arguments(message, "oa{sa{sv}}", &path, &object);
+	if (!l_dbus_message_get_arguments(message, "oa{sa{sv}}", &path,
+								&object))
+		return;
 =

 	proxy_interface_create(path, &object);
 }
@@ -667,7 +669,8 @@ static void interfaces_removed_callback(struct l_dbus_m=
essage *message,
 	if (dbus_message_has_error(message))
 		return;
 =

-	l_dbus_message_get_arguments(message, "oas", &path, &interfaces);
+	if (!l_dbus_message_get_arguments(message, "oas", &path, &interfaces))
+		return;
 =

 	while (l_dbus_message_iter_next_entry(&interfaces, &interface)) {
 		proxy =3D proxy_interface_find(interface, path);
-- =

2.13.6

--===============3842719095739922189==--

