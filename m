Content-Type: multipart/mixed; boundary="===============8292381264077616178=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] auto-t: hwsim.py: turn Hwsim into singleton
 (per-namespace)
Date: Thu, 26 Aug 2021 13:33:31 -0700
Message-ID: <20210826203333.1067317-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8292381264077616178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This prevents reallocation of new Hwsim classes on each call if one
already exists. This is a bit more efficient on memory.
---
 autotests/util/hwsim.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index db106dcb..cc62495c 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -3,6 +3,7 @@ import dbus
 import sys
 import collections
 =

+from weakref import WeakValueDictionary
 from abc import ABCMeta, abstractmethod
 from enum import Enum
 =

@@ -297,7 +298,25 @@ class RadioList(collections.Mapping):
         return obj
 =

 class Hwsim(iwd.AsyncOpAbstract):
+    _instances =3D WeakValueDictionary()
+
+    def __new__(cls, namespace=3Dctx):
+        name =3D namespace.name
+
+        if name not in cls._instances.keys():
+            obj =3D object.__new__(cls)
+            obj._initialized =3D False
+
+            cls._instances[name] =3D obj
+
+        return cls._instances[name]
+
     def __init__(self, namespace=3Dctx):
+        if self._initialized:
+            return
+
+        self._initialized =3D True
+
         self._bus =3D namespace.get_bus()
 =

         self._rule_manager_if =3D dbus.Interface(
-- =

2.31.1

--===============8292381264077616178==--

