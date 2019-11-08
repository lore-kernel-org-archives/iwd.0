Content-Type: multipart/mixed; boundary="===============0869761521882526122=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 1/5] client: Extend client proxy object's API
Date: Fri, 08 Nov 2019 11:32:19 -0800
Message-ID: <20191108193223.1950-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0869761521882526122==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add Start/Stop operations to the client proxy objects. The framework
invokes these operations right after the proxy objects are created
or just before the are destroyed, so proxy objects can perform the
needed actions like start/stop a service, etc. if they choose to
implement these ops.
---
 client/dbus-proxy.c | 16 ++++++++++++++++
 client/dbus-proxy.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
index 26c0511d..eb9812f7 100644
--- a/client/dbus-proxy.c
+++ b/client/dbus-proxy.c
@@ -555,6 +555,19 @@ static void proxy_interface_create(const char *path,
 		}
 =

 		l_queue_push_tail(proxy_interfaces, proxy);
+
+		if (!interface_type->ops || !interface_type->ops->start)
+			continue;
+
+		if (interface_type->ops->start(proxy))
+			continue;
+
+		if (!command_is_interactive_mode())
+			command_set_exit_status(EXIT_FAILURE);
+
+		l_main_quit();
+
+		return;
 	}
 }
 =

@@ -562,6 +575,9 @@ static void proxy_interface_destroy(void *data)
 {
 	struct proxy_interface *proxy =3D data;
 =

+	if (proxy->type->ops && proxy->type->ops->stop)
+		proxy->type->ops->stop(proxy);
+
 	l_free(proxy->path);
 =

 	if (proxy->type->ops && proxy->type->ops->destroy)
diff --git a/client/dbus-proxy.h b/client/dbus-proxy.h
index a3304848..e6b6f8c0 100644
--- a/client/dbus-proxy.h
+++ b/client/dbus-proxy.h
@@ -50,6 +50,8 @@ struct proxy_interface_property {
 struct proxy_interface_type_ops {
 	void *(*create)(void);
 	void (*destroy)(void *data);
+	bool (*start)(const struct proxy_interface *proxy);
+	void (*stop)(const struct proxy_interface *proxy);
 	const char *(*identity)(void *data);
 	void (*display)(const char *margin, const void *data);
 };
-- =

2.13.6

--===============0869761521882526122==--

