Content-Type: multipart/mixed; boundary="===============6696212387336326430=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 3/4] client: Remove explicit agent registartion from framework
Date: Thu, 05 Dec 2019 13:52:40 -0800
Message-ID: <20191205215241.31283-3-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191205215241.31283-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6696212387336326430==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This removes the no longer needed APIs from agent-manager.
---
 Makefile.am            |  4 ++--
 client/agent-manager.c | 41 -----------------------------------------
 client/agent-manager.h | 24 ------------------------
 client/dbus-proxy.c    | 19 -------------------
 4 files changed, 2 insertions(+), 86 deletions(-)
 delete mode 100644 client/agent-manager.h

diff --git a/Makefile.am b/Makefile.am
index 1d572db5..7a6faadd 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -267,7 +267,7 @@ bin_PROGRAMS +=3D client/iwctl
 client_iwctl_SOURCES =3D client/main.c \
 			client/adapter.c \
 			client/agent.h client/agent.c \
-			client/agent-manager.h client/agent-manager.c \
+			client/agent-manager.c \
 			client/ad-hoc.c \
 			client/ap.c \
 			client/command.h client/command.c \
@@ -486,7 +486,7 @@ if CLIENT
 unit_test_client_SOURCES =3D unit/test-client.c \
 				client/adapter.c \
 				client/agent.h client/agent.c \
-				client/agent-manager.h client/agent-manager.c \
+				client/agent-manager.c \
 				client/command.h client/command.c \
 				client/dbus-proxy.h client/dbus-proxy.c \
 				client/display.h client/display.c \
diff --git a/client/agent-manager.c b/client/agent-manager.c
index fb371ea2..98a78436 100644
--- a/client/agent-manager.c
+++ b/client/agent-manager.c
@@ -29,7 +29,6 @@
 =

 #include "agent.h"
 #include "dbus-proxy.h"
-#include "agent-manager.h"
 #include "command.h"
 =

 #define IWD_AGENT_MANAGER_PATH		"/net/connman/iwd"
@@ -80,46 +79,6 @@ static void agent_manager_stop(const struct proxy_interf=
ace *proxy)
 	agent_exit(path);
 }
 =

-bool agent_manager_register_agent(void)
-{
-	const char *path;
-	const struct proxy_interface *proxy =3D
-		proxy_interface_find(IWD_AGENT_MANAGER_INTERFACE,
-							IWD_AGENT_MANAGER_PATH);
-
-	if (!proxy)
-		return false;
-
-	path =3D proxy_interface_get_data(proxy);
-	if (!path)
-		return false;
-
-	proxy_interface_method_call(proxy, "RegisterAgent", "o",
-					check_errors_method_callback, path);
-
-	return true;
-}
-
-bool agent_manager_unregister_agent(void)
-{
-	const char *path;
-	const struct proxy_interface *proxy =3D
-		proxy_interface_find(IWD_AGENT_MANAGER_INTERFACE,
-							IWD_AGENT_MANAGER_PATH);
-
-	if (!proxy)
-		return false;
-
-	path =3D proxy_interface_get_data(proxy);
-	if (!path)
-		return false;
-
-	proxy_interface_method_call(proxy, "UnregisterAgent", "o",
-					check_errors_method_callback, path);
-
-	return true;
-}
-
 static void *agent_manager_create(void)
 {
 	return l_strdup_printf("/agent/%i", getpid());
diff --git a/client/agent-manager.h b/client/agent-manager.h
deleted file mode 100644
index c0433f53..00000000
--- a/client/agent-manager.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- *
- *  Wireless daemon for Linux
- *
- *  Copyright (C) 2017-2019  Intel Corporation. All rights reserved.
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-bool agent_manager_register_agent(void);
-bool agent_manager_unregister_agent(void);
diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
index 70b63686..a8cfca55 100644
--- a/client/dbus-proxy.c
+++ b/client/dbus-proxy.c
@@ -27,7 +27,6 @@
 #include <stdio.h>
 #include <ell/ell.h>
 =

-#include "agent-manager.h"
 #include "dbus-proxy.h"
 #include "display.h"
 #include "command.h"
@@ -732,21 +731,6 @@ static void get_managed_objects_callback(struct l_dbus=
_message *message,
 	while (l_dbus_message_iter_next_entry(&objects, &path, &object))
 		proxy_interface_create(path, &object);
 =

-	if (command_needs_no_agent())
-		goto no_agent;
-
-	if (!agent_manager_register_agent()) {
-		display_error("Failed to register Agent.\n");
-
-		if (!command_is_interactive_mode())
-			command_set_exit_status(EXIT_FAILURE);
-
-		l_main_quit();
-
-		return;
-	}
-
-no_agent:
 	if (!command_is_interactive_mode()) {
 		command_noninteractive_trigger();
 =

@@ -867,9 +851,6 @@ bool dbus_proxy_exit(void)
 {
 	struct interface_type_desc *desc;
 =

-	if (!command_needs_no_agent())
-		agent_manager_unregister_agent();
-
 	for (desc =3D __start___interface; desc < __stop___interface; desc++) {
 		if (!desc->exit)
 			continue;
-- =

2.13.6

--===============6696212387336326430==--

