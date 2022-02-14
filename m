Content-Type: multipart/mixed; boundary="===============1358121214960722302=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/3] auto-t: hwsim.py: support async radio creation
Date: Mon, 14 Feb 2022 12:34:39 -0800
Message-ID: <20220214203439.989936-3-prestwoj@gmail.com>
In-Reply-To: 20220214203439.989936-1-prestwoj@gmail.com

--===============1358121214960722302==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adds a new wait argument which, if false, will call the DBus method
and return immediately. This allows the caller to create multiple
radios very quickly, simulating (as close as we can) a wifi card
with dual phy's which appear in the kernel simultaneously.
---
 autotests/util/hwsim.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index 34859910..d4a511bf 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -310,7 +310,7 @@ class RadioList(collections.Mapping):
         del _dict[path]
 =

     def create(self, name=3DNone, p2p_device=3DFalse, iftype_disable=3DNon=
e,
-                cipher_disable=3DNone):
+                cipher_disable=3DNone, wait=3DFalse):
         args =3D dbus.Dictionary({
             'P2P': p2p_device,
         }, signature=3D'sv')
@@ -324,11 +324,22 @@ class RadioList(collections.Mapping):
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

--===============1358121214960722302==--

