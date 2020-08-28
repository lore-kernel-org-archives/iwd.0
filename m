Content-Type: multipart/mixed; boundary="===============3192763584175594891=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 13/15] auto-t: remove device.wait_for_connected
Date: Fri, 28 Aug 2020 11:47:37 -0700
Message-ID: <20200828184739.8616-14-prestwoj@gmail.com>
In-Reply-To: <20200828184739.8616-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3192763584175594891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I had added this without realizing wait_for_object_condition
can do this already using the device object.
---
 autotests/testSAE/clogging_test.py |  3 ++-
 autotests/util/iwd.py              | 25 -------------------------
 2 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/autotests/testSAE/clogging_test.py b/autotests/testSAE/cloggin=
g_test.py
index e94e2ad6..c46c5821 100644
--- a/autotests/testSAE/clogging_test.py
+++ b/autotests/testSAE/clogging_test.py
@@ -48,7 +48,8 @@ class Test(unittest.TestCase):
             wd.wait_for_object_condition(n.network_object, condition)
 =

         for d in devices:
-            d.wait_for_connected()
+            condition =3D 'obj.state =3D=3D DeviceState.connected'
+            wd.wait_for_object_condition(d, condition)
 =

         for d in devices:
             d.disconnect()
diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 113039b6..9c106b89 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -568,31 +568,6 @@ class Device(IWDDBusAbstract):
             if self._adhoc_timed_out:
                 raise TimeoutError("Timed out waiting for peer %s" % addr)
 =

-    def wait_for_connected(self):
-        if str(self.state) =3D=3D "connected":
-            return
-
-        self._connected_success =3D False
-        self._connected_timed_out =3D False
-
-        def wait_timeout_cb():
-            self._connected_timed_out =3D True
-            return False
-
-        def connected_prop_changed(iface, changed, invalid):
-            if changed.get('State', None):
-                if changed['State'] =3D=3D 'connected':
-                    self._connected_success =3D True
-
-        self._prop_proxy.connect_to_signal('PropertiesChanged',
-                                            connected_prop_changed)
-        GLib.timeout_add(int(15 * 1000), wait_timeout_cb)
-        context =3D mainloop.get_context()
-        while not self._connected_success:
-            context.iteration(may_block=3DTrue)
-            if self._connected_timed_out:
-                raise TimeoutError("Timed out waiting for connected")
-
     def __str__(self, prefix =3D ''):
         return prefix + 'Device: ' + self.device_path + '\n'\
                + prefix + '\tName:\t\t' + self.name + '\n'\
-- =

2.21.1

--===============3192763584175594891==--

