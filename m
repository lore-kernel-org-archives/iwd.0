Content-Type: multipart/mixed; boundary="===============2819550235316462183=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 09/11] auto-t: add iftype/cipher disable to hwsim.py
Date: Thu, 17 Dec 2020 11:36:09 -0800
Message-ID: <20201217193611.1177006-9-prestwoj@gmail.com>
In-Reply-To: <20201217193611.1177006-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2819550235316462183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/hwsim.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index 9ad8ce09..9aa14cbc 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -249,7 +249,8 @@ class RadioList(collections.Mapping):
     def _interfaces_removed_handler(self, path, interfaces):
         del _dict[path]
 =

-    def create(self, name=3DNone, p2p_device=3DFalse):
+    def create(self, name=3DNone, p2p_device=3DFalse, iftype_disable=3DNon=
e,
+                cipher_disable=3DNone):
         args =3D dbus.Dictionary({
             'P2P': p2p_device,
         }, signature=3D'sv')
@@ -257,6 +258,12 @@ class RadioList(collections.Mapping):
         if name:
             args['Name'] =3D name
 =

+        if iftype_disable:
+            args['InterfaceTypeDisable'] =3D iftype_disable
+
+        if cipher_disable:
+            args['CipherTypeDisable'] =3D cipher_disable
+
         path =3D self._radio_manager.CreateRadio(args)
         obj =3D Radio(path)
         self._dict[path] =3D obj
-- =

2.26.2

--===============2819550235316462183==--

