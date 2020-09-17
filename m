Content-Type: multipart/mixed; boundary="===============5800739619757719466=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/6] auto-t: allow IWDDBusAbstract to work with any service
Date: Thu, 17 Sep 2020 14:32:44 -0700
Message-ID: <20200917213247.788181-3-prestwoj@gmail.com>
In-Reply-To: <20200917213247.788181-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5800739619757719466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is somewhat of a hack, but the IWDDBusAbstract is a very
convenient abstraction to DBus objects. The only piece that restricts
it to IWD is the hardcoded IWD_SERVICE. Instead we can pass in a
keyword argument which defaults to IWD_SERVICE. That way other modules
(like EAD) can utilize this abstraction with their own service simply
by changing that service argument.
---
 autotests/util/iwd.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index e812a4e4..ef843a95 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -120,9 +120,9 @@ class IWDDBusAbstract(AsyncOpAbstract):
 =

     _bus =3D dbus.SystemBus()
 =

-    def __init__(self, object_path =3D None, properties =3D None):
+    def __init__(self, object_path =3D None, properties =3D None, service=
=3DIWD_SERVICE):
         self._object_path =3D object_path
-        proxy =3D self._bus.get_object(IWD_SERVICE, self._object_path)
+        proxy =3D self._bus.get_object(service, self._object_path)
         self._iface =3D dbus.Interface(proxy, self._iface_name)
         self._prop_proxy =3D dbus.Interface(proxy, DBUS_PROPERTIES)
 =

-- =

2.26.2

--===============5800739619757719466==--

