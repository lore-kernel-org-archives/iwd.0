Content-Type: multipart/mixed; boundary="===============8678142900021591835=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2] client: Fix proxy object's dependency resolution
Date: Fri, 07 Feb 2020 13:11:22 -0800
Message-ID: <20200207211122.24801-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8678142900021591835==
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
 client/dbus-proxy.c | 99 ++++++++++++++++++++++++++++++++++---------------=
----
 1 file changed, 63 insertions(+), 36 deletions(-)

diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
index 0555880d..83f91eea 100644
--- a/client/dbus-proxy.c
+++ b/client/dbus-proxy.c
@@ -511,6 +511,33 @@ static bool is_ignorable(const char *interface)
 	return false;
 }
 =

+static void proxy_interfaces_update_properties(const char *path,
+					struct l_dbus_message_iter *interfaces)
+{
+	const char *interface;
+	struct l_dbus_message_iter properties;
+	struct proxy_interface *proxy;
+	struct proxy_interface_type *interface_type;
+
+	if (!path)
+		return;
+
+	while (l_dbus_message_iter_next_entry(interfaces, &interface,
+								&properties)) {
+		interface_type =3D l_queue_find(proxy_interface_types,
+						interface_match_by_type_name,
+						interface);
+		if (!interface_type)
+			continue;
+
+		proxy =3D proxy_interface_find(interface_type->interface, path);
+		if (!proxy)
+			continue;
+
+		interface_update_properties(proxy, &properties, NULL);
+	}
+}
+
 static void proxy_interface_create(const char *path,
 					struct l_dbus_message_iter *interfaces)
 {
@@ -538,22 +565,16 @@ static void proxy_interface_create(const char *path,
 =

 		proxy =3D proxy_interface_find(interface_type->interface, path);
 =

-		if (proxy) {
-			interface_update_properties(proxy, &properties, NULL);
-
+		if (proxy)
 			continue;
-		}
 =

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
@@ -656,6 +677,12 @@ static void interfaces_added_callback(struct l_dbus_me=
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
@@ -692,52 +719,52 @@ static void get_managed_objects_callback(struct l_dbu=
s_message *message,
 	const char *path;
 =

 	if (dbus_message_has_error(message)) {
-		l_error("Failed to retrieve IWD dbus objects, quitting...\n");
-
-		if (!command_is_interactive_mode())
-			command_set_exit_status(EXIT_FAILURE);
-
-		l_main_quit();
+		display_error("Failed to retrieve IWD dbus objects, "
+							"quitting...\n");
 =

-		return;
+		goto error;
 	}
 =

 	if (!l_dbus_message_get_arguments(message, "a{oa{sa{sv}}}", &objects)) {
-		l_error("Failed to parse IWD dbus objects, quitting...\n");
+		display_error("Failed to parse IWD dbus objects, "
+							"quitting...\n");
 =

-		if (!command_is_interactive_mode())
-			command_set_exit_status(EXIT_FAILURE);
-
-		l_main_quit();
-
-		return;
+		goto error;
 	}
 =

 	while (l_dbus_message_iter_next_entry(&objects, &path, &object))
 		proxy_interface_create(path, &object);
 =

-	if (command_needs_no_agent())
-		goto no_agent;
-
-	if (!agent_manager_register_agent()) {
-		display_error("Failed to register Agent.\n");
+	if (!l_dbus_message_get_arguments(message, "a{oa{sa{sv}}}", &objects))
+		/*
+		 * Shouldn't happen since we parsed it above, but check return
+		 * anyway.
+		 */
+		goto error;
 =

-		if (!command_is_interactive_mode())
-			command_set_exit_status(EXIT_FAILURE);
+	while (l_dbus_message_iter_next_entry(&objects, &path, &object))
+		proxy_interfaces_update_properties(path, &object);
 =

-		l_main_quit();
+	if (!command_needs_no_agent()) {
+		if (!agent_manager_register_agent()) {
+			display_error("Failed to register Agent.\n");
 =

-		return;
+			goto error;
+		}
 	}
 =

-no_agent:
-	if (!command_is_interactive_mode()) {
+	if (command_is_interactive_mode())
+		display_enable_cmd_prompt();
+	else
 		command_noninteractive_trigger();
 =

-		return;
-	}
+	return;
+
+error:
+	if (!command_is_interactive_mode())
+		command_set_exit_status(EXIT_FAILURE);
 =

-	display_enable_cmd_prompt();
+	l_main_quit();
 }
 =

 static void get_managed_objects(void)
-- =

2.13.6

--===============8678142900021591835==--

