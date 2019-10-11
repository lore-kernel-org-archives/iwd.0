Content-Type: multipart/mixed; boundary="===============3862214171391745402=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 05/11] agent: utilize IWD_MODULE
Date: Fri, 11 Oct 2019 10:24:11 -0700
Message-ID: <20191011172417.23328-5-prestwoj@gmail.com>
In-Reply-To: <20191011172417.23328-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3862214171391745402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Converts agent into an IWD module. This removes the dbus dependency
on agent. Since dbus is initialized very early we can assume
dbus_get_bus is going to return a valid object.
---
 src/agent.c | 19 ++++++++++++-------
 src/agent.h |  2 --
 src/dbus.c  |  3 +--
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/src/agent.c b/src/agent.c
index 2c04c546..3a266746 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -29,6 +29,7 @@
 #include <ell/ell.h>
 #include "src/dbus.h"
 #include "src/agent.h"
+#include "src/iwd.h"
 =

 static unsigned int next_request_id =3D 0;
 =

@@ -619,8 +620,10 @@ static bool release_agent(void *data, void *user_data)
 	return true;
 }
 =

-bool agent_init(struct l_dbus *dbus)
+static int agent_init(void)
 {
+	struct l_dbus *dbus =3D dbus_get_bus();
+
 	agents =3D l_queue_new();
 =

 	if (!l_dbus_register_interface(dbus, IWD_AGENT_MANAGER_INTERFACE,
@@ -628,7 +631,7 @@ bool agent_init(struct l_dbus *dbus)
 						NULL, false)) {
 		l_info("Unable to register %s interface",
 				IWD_AGENT_MANAGER_INTERFACE);
-		return false;
+		return -EIO;
 	}
 =

 	if (!l_dbus_object_add_interface(dbus, IWD_AGENT_MANAGER_PATH,
@@ -637,24 +640,26 @@ bool agent_init(struct l_dbus *dbus)
 		l_info("Unable to register the agent manager object on '%s'",
 				IWD_AGENT_MANAGER_PATH);
 		l_dbus_unregister_interface(dbus, IWD_AGENT_MANAGER_INTERFACE);
-		return false;
+		return -EIO;
 	}
 =

-	return true;
+	return 0;
 }
 =

-bool agent_exit(struct l_dbus *dbus)
+static void agent_exit(void)
 {
+	struct l_dbus *dbus =3D dbus_get_bus();
+
 	l_dbus_unregister_object(dbus, IWD_AGENT_MANAGER_PATH);
 	l_dbus_unregister_interface(dbus, IWD_AGENT_MANAGER_INTERFACE);
 =

 	l_queue_destroy(agents, agent_free);
 	agents =3D NULL;
-
-	return true;
 }
 =

 void agent_shutdown(void)
 {
 	l_queue_foreach_remove(agents, release_agent, NULL);
 }
+
+IWD_MODULE(agent, agent_init, agent_exit);
diff --git a/src/agent.h b/src/agent.h
index f4dcd46b..e9f78c39 100644
--- a/src/agent.h
+++ b/src/agent.h
@@ -37,8 +37,6 @@ typedef void (*agent_request_user_name_passwd_func_t) (en=
um agent_result result,
 					void *user_data);
 typedef void (*agent_request_destroy_func_t)(void *user_data);
 =

-bool agent_init(struct l_dbus *dbus);
-bool agent_exit(struct l_dbus *dbus);
 void agent_shutdown(void);
 =

 unsigned int agent_request_passphrase(const char *path,
diff --git a/src/dbus.c b/src/dbus.c
index 5bc32c26..43dfb567 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -210,12 +210,11 @@ struct l_dbus *dbus_get_bus(void)
 bool dbus_init(struct l_dbus *dbus)
 {
 	g_dbus =3D dbus;
-	return agent_init(dbus);
+	return true;
 }
 =

 void dbus_exit(void)
 {
-	agent_exit(g_dbus);
 	g_dbus =3D NULL;
 }
 =

-- =

2.17.1

--===============3862214171391745402==--

