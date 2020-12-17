Content-Type: multipart/mixed; boundary="===============3834906465693636295=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 05/11] auto-t: update hwsim radio create to use dictionary
Date: Thu, 17 Dec 2020 11:36:05 -0800
Message-ID: <20201217193611.1177006-5-prestwoj@gmail.com>
In-Reply-To: <20201217193611.1177006-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3834906465693636295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/hwsim.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index b0e6a089..9ad8ce09 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -249,8 +249,15 @@ class RadioList(collections.Mapping):
     def _interfaces_removed_handler(self, path, interfaces):
         del _dict[path]
 =

-    def create(self, name=3D'', p2p_device=3DFalse):
-        path =3D self._radio_manager.CreateRadio(name, p2p_device)
+    def create(self, name=3DNone, p2p_device=3DFalse):
+        args =3D dbus.Dictionary({
+            'P2P': p2p_device,
+        }, signature=3D'sv')
+
+        if name:
+            args['Name'] =3D name
+
+        path =3D self._radio_manager.CreateRadio(args)
         obj =3D Radio(path)
         self._dict[path] =3D obj
         return obj
-- =

2.26.2

--===============3834906465693636295==--

