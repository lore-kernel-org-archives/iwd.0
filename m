Content-Type: multipart/mixed; boundary="===============3067510312618199129=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 2/2] auto-t: hwsim.py: support async radio creation
Date: Tue, 15 Feb 2022 08:52:42 -0800
Message-ID: <20220215165242.1086346-2-prestwoj@gmail.com>
In-Reply-To: 20220215165242.1086346-1-prestwoj@gmail.com

--===============3067510312618199129==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adds a new wait argument which, if false, will call the DBus method
and return immediately. This allows the caller to create multiple
radios very quickly, simulating (as close as we can) a wifi card
with dual phy's which appear in the kernel simultaneously.

The name argument was also changed to be mandatory, which is now
required by hwsim.
---
 autotests/util/hwsim.py | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index 34859910..ce85f43d 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -309,26 +309,35 @@ class RadioList(collections.Mapping):
     def _interfaces_removed_handler(self, path, interfaces):
         del _dict[path]
 =

-    def create(self, name=3DNone, p2p_device=3DFalse, iftype_disable=3DNon=
e,
-                cipher_disable=3DNone):
+    def create(self, name, p2p_device=3DFalse, iftype_disable=3DNone,
+                cipher_disable=3DNone, wait=3DTrue):
         args =3D dbus.Dictionary({
+            'Name': name,
             'P2P': p2p_device,
         }, signature=3D'sv')
 =

-        if name:
-            args['Name'] =3D name
-
         if iftype_disable:
             args['InterfaceTypeDisable'] =3D iftype_disable
 =

         if cipher_disable:
             args['CipherTypeDisable'] =3D cipher_disable
 =

+        if not wait:
+            self._radio_manager.CreateRadio(args, reply_handler=3Dself._su=
ccess,
+                                                error_handler=3Dself._fail=
ure)
+            return None
+
         path =3D self._radio_manager.CreateRadio(args)
         obj =3D Radio(path)
         self._dict[path] =3D obj
         return obj
 =

+    def _success(self, bla):
+        pass
+
+    def _failure(self, ex):
+        pass
+
 class Hwsim(iwd.AsyncOpAbstract):
     _instances =3D WeakValueDictionary()
 =

-- =

2.34.1

--===============3067510312618199129==--

