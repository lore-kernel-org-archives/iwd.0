Content-Type: multipart/mixed; boundary="===============7629130938151964038=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] main: Add D-Bus Daemon.GetInfo method
Date: Thu, 06 May 2021 00:29:13 +0200
Message-ID: <20210505222914.50570-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7629130938151964038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Expose the state directory/storage directory path on D-Bus because it
can't be known to clients until IWD runs, and client might need to
occasionally fiddle with the network config files.  While there also
expose the IWD version string, similar to how some other D-Bus services
do.
---
 src/dbus.h |  1 +
 src/main.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/src/dbus.h b/src/dbus.h
index 4936dc6c..b3896108 100644
--- a/src/dbus.h
+++ b/src/dbus.h
@@ -24,6 +24,7 @@
 =

 #define IWD_SERVICE "net.connman.iwd"
 =

+#define IWD_DAEMON_INTERFACE "net.connman.iwd.Daemon"
 #define IWD_AGENT_MANAGER_INTERFACE "net.connman.iwd.AgentManager"
 #define IWD_WIPHY_INTERFACE "net.connman.iwd.Adapter"
 #define IWD_DEVICE_INTERFACE "net.connman.iwd.Device"
diff --git a/src/main.c b/src/main.c
index 2ee6188c..f65fa7f4 100644
--- a/src/main.c
+++ b/src/main.c
@@ -185,6 +185,16 @@ static void request_name_callback(struct l_dbus *dbus,=
 bool success,
 	if (!l_dbus_object_manager_enable(dbus, "/"))
 		l_warn("Unable to register the ObjectManager");
 =

+	if (!l_dbus_object_add_interface(dbus, IWD_BASE_PATH,
+						IWD_DAEMON_INTERFACE,
+						NULL) ||
+			!l_dbus_object_add_interface(dbus, IWD_BASE_PATH,
+						L_DBUS_INTERFACE_PROPERTIES,
+						NULL))
+		l_info("Unable to add %s and/or %s at %s",
+			IWD_DAEMON_INTERFACE, L_DBUS_INTERFACE_PROPERTIES,
+			IWD_BASE_PATH);
+
 	/* TODO: Always request nl80211 for now, ignoring auto-loading */
 	l_genl_request_family(genl, NL80211_GENL_NAME, nl80211_appeared,
 				NULL, NULL);
@@ -194,12 +204,44 @@ fail_exit:
 	l_main_quit();
 }
 =

+static struct l_dbus_message *iwd_dbus_get_info(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct l_dbus_message *reply;
+	struct l_dbus_message_builder *builder;
+	L_AUTO_FREE_VAR(char *, storage_dir) =3D storage_get_path(NULL);
+
+	reply =3D l_dbus_message_new_method_return(message);
+	builder =3D l_dbus_message_builder_new(reply);
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+
+	dbus_append_dict_basic(builder, "StateDirectory", 's', storage_dir);
+	dbus_append_dict_basic(builder, "Version", 's', VERSION);
+
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+
+	return reply;
+}
+
+static void iwd_setup_deamon_interface(struct l_dbus_interface *interface)
+{
+	l_dbus_interface_method(interface, "GetInfo", 0, iwd_dbus_get_info,
+				"a{sv}", "", "info");
+}
+
 static void dbus_ready(void *user_data)
 {
 	struct l_dbus *dbus =3D user_data;
 =

 	l_dbus_name_acquire(dbus, "net.connman.iwd", false, false, false,
 				request_name_callback, NULL);
+
+	l_dbus_register_interface(dbus, IWD_DAEMON_INTERFACE,
+					iwd_setup_deamon_interface,
+					NULL, false);
 }
 =

 static void dbus_disconnected(void *user_data)
-- =

2.27.0

--===============7629130938151964038==--

