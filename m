Content-Type: multipart/mixed; boundary="===============3600899594533888959=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 2/5] client: Add start/stop ops to agent manager proxy
Date: Fri, 08 Nov 2019 11:32:20 -0800
Message-ID: <20191108193223.1950-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191108193223.1950-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3600899594533888959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This guarantees that the agent gets registered only when the agent
manager interface is available on dbus.
---
 client/agent-manager.c | 51 +++++++++++++++++++++++++++++++++++++++++++---=
----
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/client/agent-manager.c b/client/agent-manager.c
index b7d4271b..fb371ea2 100644
--- a/client/agent-manager.c
+++ b/client/agent-manager.c
@@ -30,6 +30,7 @@
 #include "agent.h"
 #include "dbus-proxy.h"
 #include "agent-manager.h"
+#include "command.h"
 =

 #define IWD_AGENT_MANAGER_PATH		"/net/connman/iwd"
 =

@@ -39,6 +40,46 @@ static void check_errors_method_callback(struct l_dbus_m=
essage *message,
 	dbus_message_has_error(message);
 }
 =

+static bool agent_manager_start(const struct proxy_interface *proxy)
+{
+	const char *path;
+
+	if (command_needs_no_agent())
+		return true;
+
+	path =3D proxy_interface_get_data(proxy);
+	if (!path)
+		return false;
+
+	if (!agent_init(path))
+		return false;
+
+	proxy_interface_method_call(proxy, "RegisterAgent", "o",
+					check_errors_method_callback, path);
+
+	return true;
+}
+
+static void agent_manager_stop(const struct proxy_interface *proxy)
+{
+	const char *path;
+
+	if (command_needs_no_agent())
+		return;
+
+	if (!proxy)
+		return;
+
+	path =3D proxy_interface_get_data(proxy);
+	if (!path)
+		return;
+
+	proxy_interface_method_call(proxy, "UnregisterAgent", "o",
+					check_errors_method_callback, path);
+
+	agent_exit(path);
+}
+
 bool agent_manager_register_agent(void)
 {
 	const char *path;
@@ -81,25 +122,21 @@ bool agent_manager_unregister_agent(void)
 =

 static void *agent_manager_create(void)
 {
-	char *path =3D l_strdup_printf("/agent/%i", getpid());
-
-	agent_init(path);
-
-	return path;
+	return l_strdup_printf("/agent/%i", getpid());
 }
 =

 static void agent_manager_destroy(void *data)
 {
 	char *path =3D data;
 =

-	agent_exit(path);
-
 	l_free(path);
 }
 =

 static const struct proxy_interface_type_ops agent_manager_ops =3D {
 	.create =3D agent_manager_create,
 	.destroy =3D agent_manager_destroy,
+	.start =3D agent_manager_start,
+	.stop =3D agent_manager_stop,
 };
 =

 static struct proxy_interface_type agent_manager_interface_type =3D {
-- =

2.13.6

--===============3600899594533888959==--

