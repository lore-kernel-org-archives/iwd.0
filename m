Content-Type: multipart/mixed; boundary="===============4337281060204254779=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 1/2] client: Reorder interface creation ops
Date: Wed, 26 Feb 2020 15:32:23 -0800
Message-ID: <20200226233224.31261-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4337281060204254779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the newly created proxy objects into the queue before the
interface specific initialization logic takes place. This way the new
proxy objects can be used within the initialization procedures.
---
 client/dbus-proxy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
index 83f91eea..37a09512 100644
--- a/client/dbus-proxy.c
+++ b/client/dbus-proxy.c
@@ -572,10 +572,10 @@ static void proxy_interface_create(const char *path,
 		proxy->path =3D l_strdup(path);
 		proxy->type =3D interface_type;
 =

+		l_queue_push_tail(proxy_interfaces, proxy);
+
 		if (interface_type->ops && interface_type->ops->create)
 			proxy->data =3D interface_type->ops->create();
-
-		l_queue_push_tail(proxy_interfaces, proxy);
 	}
 }
 =

-- =

2.13.6

--===============4337281060204254779==--

