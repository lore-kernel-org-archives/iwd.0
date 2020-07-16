Content-Type: multipart/mixed; boundary="===============2649791469131665646=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/4] agent: Don't remove object at IWD_AGENT_MANAGER_PATH
Date: Thu, 16 Jul 2020 02:10:15 +0200
Message-ID: <20200716001018.311387-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2649791469131665646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This same object is used for the P2P service manager, let each module
remove the interfaces it added only.

Reported-by: Denis Kenzior
---
 src/agent.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/agent.c b/src/agent.c
index d213f3cd..101eaffd 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -651,7 +651,6 @@ static void agent_exit(void)
 {
 	struct l_dbus *dbus =3D dbus_get_bus();
 =

-	l_dbus_unregister_object(dbus, IWD_AGENT_MANAGER_PATH);
 	l_dbus_unregister_interface(dbus, IWD_AGENT_MANAGER_INTERFACE);
 =

 	l_queue_destroy(agents, agent_free);
-- =

2.25.1

--===============2649791469131665646==--

