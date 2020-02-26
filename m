Content-Type: multipart/mixed; boundary="===============8356951734510145818=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 2/2] client: Rework agent registarion logic
Date: Wed, 26 Feb 2020 15:32:24 -0800
Message-ID: <20200226233224.31261-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20200226233224.31261-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8356951734510145818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Do agent registration as part of agent manager proxy creation.
This ensures that the registration call is made only after the agent
manager=E2=80=99s interface becomes available on the bus.
---
 client/agent-manager.c | 29 +++++++++++++++++++----------
 client/agent-manager.h |  3 +--
 client/dbus-proxy.c    | 13 ++-----------
 3 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/client/agent-manager.c b/client/agent-manager.c
index 0bec85e7..68d87cb0 100644
--- a/client/agent-manager.c
+++ b/client/agent-manager.c
@@ -2,7 +2,7 @@
  *
  *  Wireless daemon for Linux
  *
- *  Copyright (C) 2017-2019  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2017-2020  Intel Corporation. All rights reserved.
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -30,6 +30,7 @@
 #include "client/agent.h"
 #include "client/dbus-proxy.h"
 #include "client/agent-manager.h"
+#include "client/command.h"
 =

 #define IWD_AGENT_MANAGER_PATH		"/net/connman/iwd"
 =

@@ -39,18 +40,16 @@ static void check_errors_method_callback(struct l_dbus_=
message *message,
 	dbus_message_has_error(message);
 }
 =

-bool agent_manager_register_agent(void)
+static bool agent_manager_register_agent(const char *path)
 {
-	const char *path;
-	const struct proxy_interface *proxy =3D
-		proxy_interface_find(IWD_AGENT_MANAGER_INTERFACE,
-							IWD_AGENT_MANAGER_PATH);
+	const struct proxy_interface *proxy;
 =

-	if (!proxy)
+	if (!path)
 		return false;
 =

-	path =3D proxy_interface_get_data(proxy);
-	if (!path)
+	proxy =3D proxy_interface_find(IWD_AGENT_MANAGER_INTERFACE,
+							IWD_AGENT_MANAGER_PATH);
+	if (!proxy)
 		return false;
 =

 	proxy_interface_method_call(proxy, "RegisterAgent", "o",
@@ -81,10 +80,17 @@ bool agent_manager_unregister_agent(void)
 =

 static void *agent_manager_create(void)
 {
-	char *path =3D l_strdup_printf("/agent/%i", getpid());
+	char *path;
+
+	if (command_needs_no_agent())
+		return NULL;
+
+	path =3D l_strdup_printf("/agent/%i", getpid());
 =

 	agent_init(path);
 =

+	agent_manager_register_agent(path);
+
 	return path;
 }
 =

@@ -92,6 +98,9 @@ static void agent_manager_destroy(void *data)
 {
 	char *path =3D data;
 =

+	if (!path)
+		return;
+
 	agent_exit(path);
 =

 	l_free(path);
diff --git a/client/agent-manager.h b/client/agent-manager.h
index c0433f53..4655100d 100644
--- a/client/agent-manager.h
+++ b/client/agent-manager.h
@@ -2,7 +2,7 @@
  *
  *  Wireless daemon for Linux
  *
- *  Copyright (C) 2017-2019  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2017-2020  Intel Corporation. All rights reserved.
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -20,5 +20,4 @@
  *
  */
 =

-bool agent_manager_register_agent(void);
 bool agent_manager_unregister_agent(void);
diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
index 37a09512..ab9fb5a5 100644
--- a/client/dbus-proxy.c
+++ b/client/dbus-proxy.c
@@ -2,7 +2,7 @@
  *
  *  Wireless daemon for Linux
  *
- *  Copyright (C) 2017-2019  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2017-2020  Intel Corporation. All rights reserved.
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -745,14 +745,6 @@ static void get_managed_objects_callback(struct l_dbus=
_message *message,
 	while (l_dbus_message_iter_next_entry(&objects, &path, &object))
 		proxy_interfaces_update_properties(path, &object);
 =

-	if (!command_needs_no_agent()) {
-		if (!agent_manager_register_agent()) {
-			display_error("Failed to register Agent.\n");
-
-			goto error;
-		}
-	}
-
 	if (command_is_interactive_mode())
 		display_enable_cmd_prompt();
 	else
@@ -878,8 +870,7 @@ bool dbus_proxy_exit(void)
 {
 	struct interface_type_desc *desc;
 =

-	if (!command_needs_no_agent())
-		agent_manager_unregister_agent();
+	agent_manager_unregister_agent();
 =

 	for (desc =3D __start___interface; desc < __stop___interface; desc++) {
 		if (!desc->exit)
-- =

2.13.6

--===============8356951734510145818==--

