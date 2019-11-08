Content-Type: multipart/mixed; boundary="===============7850864761578708492=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: =?utf-8?q?=5BPATCH_5/5=5D_client=3A_Fail_in_non-interactive_mode_if_iwd_s?=
 =?utf-8?q?ervice_isn=E2=80=99t_running?=
Date: Fri, 08 Nov 2019 11:32:23 -0800
Message-ID: <20191108193223.1950-5-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191108193223.1950-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7850864761578708492==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In non-interactive mode request the managed object right away and do
not wait for the service to appear. This way client can fail right
away instead of endlessly waiting in non-interactive mode.
---
 client/dbus-proxy.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
index 37f0e75c..313cd5a6 100644
--- a/client/dbus-proxy.c
+++ b/client/dbus-proxy.c
@@ -740,11 +740,17 @@ static void get_managed_objects_callback(struct l_dbu=
s_message *message,
 	display_enable_cmd_prompt();
 }
 =

-static void service_appeared_callback(struct l_dbus *dbus, void *user_data)
+static void get_managed_objects(void)
 {
-	if (!command_is_interactive_mode())
-		goto get_objects;
+	l_dbus_method_call(dbus, IWD_SERVICE, IWD_ROOT_PATH,
+					L_DBUS_INTERFACE_OBJECT_MANAGER,
+					"GetManagedObjects", NULL,
+					get_managed_objects_callback,
+					NULL, NULL);
+}
 =

+static void service_appeared_callback(struct l_dbus *dbus, void *user_data)
+{
 	l_dbus_add_signal_watch(dbus, IWD_SERVICE, IWD_ROOT_PATH,
 					L_DBUS_INTERFACE_OBJECT_MANAGER,
 					"InterfacesAdded", L_DBUS_MATCH_NONE,
@@ -759,12 +765,8 @@ static void service_appeared_callback(struct l_dbus *d=
bus, void *user_data)
 					L_DBUS_INTERFACE_PROPERTIES,
 					"PropertiesChanged", L_DBUS_MATCH_NONE,
 					properties_changed_callback, NULL);
-get_objects:
-	l_dbus_method_call(dbus, IWD_SERVICE, IWD_ROOT_PATH,
-					L_DBUS_INTERFACE_OBJECT_MANAGER,
-					"GetManagedObjects", NULL,
-					get_managed_objects_callback,
-					NULL, NULL);
+
+	get_managed_objects();
 }
 =

 static void service_disappeared_callback(struct l_dbus *dbus,
@@ -834,9 +836,13 @@ bool dbus_proxy_init(void)
 	l_dbus_set_disconnect_handler(dbus, dbus_disconnect_callback, NULL,
 									NULL);
 =

-	l_dbus_add_service_watch(dbus, IWD_SERVICE, service_appeared_callback,
+	if (command_is_interactive_mode())
+		l_dbus_add_service_watch(dbus, IWD_SERVICE,
+						service_appeared_callback,
 						service_disappeared_callback,
 						NULL, NULL);
+	else
+		get_managed_objects();
 =

 	return true;
 }
-- =

2.13.6

--===============7850864761578708492==--

