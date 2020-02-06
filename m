Content-Type: multipart/mixed; boundary="===============9021582814738507229=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH] client: Fix proxy object's dependency resolution
Date: Thu, 06 Feb 2020 15:33:02 -0800
Message-ID: <20200206233302.30338-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9021582814738507229==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Previously, the parsing of the OMs objects has been done in one pass,
therefore, the proxy object's dependencies may not have been parsed at the
time when they were looked up for the dependency assignments. Now, the
parsing of the OM objects is done in two passes: 1) Create proxy objects -
one per interface and path, 2) Populate the proxy objects with properties
and assign dependencies. Therefore, we are guaranteed to have the proxy
objects created by the time they are looked up for the dependency
assignments.
---
 client/dbus-proxy.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++--=
----
 1 file changed, 54 insertions(+), 7 deletions(-)

diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
index 0555880d..9d6f4bcb 100644
--- a/client/dbus-proxy.c
+++ b/client/dbus-proxy.c
@@ -511,7 +511,7 @@ static bool is_ignorable(const char *interface)
 	return false;
 }
 =

-static void proxy_interface_create(const char *path,
+static void proxy_interfaces_update_properties(const char *path,
 					struct l_dbus_message_iter *interfaces)
 {
 	const char *interface;
@@ -537,23 +537,50 @@ static void proxy_interface_create(const char *path,
 		}
 =

 		proxy =3D proxy_interface_find(interface_type->interface, path);
+		if (!proxy)
+			continue;
+
+		interface_update_properties(proxy, &properties, NULL);
+	}
+}
+
+static void proxy_interface_create(const char *path,
+					struct l_dbus_message_iter *interfaces)
+{
+	const char *interface;
+	struct l_dbus_message_iter properties;
+	struct proxy_interface *proxy;
+	struct proxy_interface_type *interface_type;
 =

-		if (proxy) {
-			interface_update_properties(proxy, &properties, NULL);
+	if (!path)
+		return;
+
+	while (l_dbus_message_iter_next_entry(interfaces, &interface,
+								&properties)) {
+		interface_type =3D l_queue_find(proxy_interface_types,
+						interface_match_by_type_name,
+						interface);
+
+		if (!interface_type) {
+			if (!is_ignorable(interface))
+				l_debug("Unknown DBus interface type %s",
+								interface);
 =

 			continue;
 		}
 =

+		proxy =3D proxy_interface_find(interface_type->interface, path);
+
+		if (proxy)
+			continue;
+
 		proxy =3D l_new(struct proxy_interface, 1);
 		proxy->path =3D l_strdup(path);
 		proxy->type =3D interface_type;
 =

-		if (interface_type->ops && interface_type->ops->create) {
+		if (interface_type->ops && interface_type->ops->create)
 			proxy->data =3D interface_type->ops->create();
 =

-			interface_update_properties(proxy, &properties, NULL);
-		}
-
 		l_queue_push_tail(proxy_interfaces, proxy);
 	}
 }
@@ -656,6 +683,12 @@ static void interfaces_added_callback(struct l_dbus_me=
ssage *message,
 		return;
 =

 	proxy_interface_create(path, &object);
+
+	if (!l_dbus_message_get_arguments(message, "oa{sa{sv}}", &path,
+								&object))
+		return;
+
+	proxy_interfaces_update_properties(path, &object);
 }
 =

 static void interfaces_removed_callback(struct l_dbus_message *message,
@@ -716,6 +749,20 @@ static void get_managed_objects_callback(struct l_dbus=
_message *message,
 	while (l_dbus_message_iter_next_entry(&objects, &path, &object))
 		proxy_interface_create(path, &object);
 =

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
+
+	while (l_dbus_message_iter_next_entry(&objects, &path, &object))
+		proxy_interfaces_update_properties(path, &object);
+
 	if (command_needs_no_agent())
 		goto no_agent;
 =

-- =

2.13.6

--===============9021582814738507229==--

