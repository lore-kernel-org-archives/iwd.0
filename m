Content-Type: multipart/mixed; boundary="===============7341262476857997439=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/6] auto-t: remove old AdHoc APIs
Date: Mon, 14 Sep 2020 14:04:07 -0700
Message-ID: <20200914210407.428918-7-prestwoj@gmail.com>
In-Reply-To: <20200914210407.428918-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7341262476857997439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/iwd.py | 55 -------------------------------------------
 1 file changed, 55 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 2713d774..67bb6e41 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -525,61 +525,6 @@ class Device(IWDDBusAbstract):
     def stop_adhoc(self):
         self._prop_proxy.Set(IWD_DEVICE_INTERFACE, 'Mode', 'station')
 =

-    def adhoc_wait_for_disconnected(self, addr):
-        self._adhoc_prop_found =3D False
-        self._adhoc_timed_out =3D False
-
-        def wait_timeout_cb():
-            self._adhoc_timed_out =3D True
-            return False
-
-        def adhoc_props_changed(iface, changed, invalid):
-            if changed.get('ConnectedPeers', None):
-                if addr not in changed['ConnectedPeers']:
-                    self._adhoc_prop_found =3D True
-
-        self._prop_proxy.connect_to_signal('PropertiesChanged',
-                                            adhoc_props_changed)
-        props =3D self._prop_proxy.GetAll(IWD_ADHOC_INTERFACE)
-        if props.get('ConnectedPeers', None):
-            if addr not in props['ConnectedPeers']:
-                return
-
-        GLib.timeout_add(int(50 * 1000), wait_timeout_cb)
-        context =3D ctx.mainloop.get_context()
-        while not self._adhoc_prop_found:
-            context.iteration(may_block=3DTrue)
-            if self._adhoc_timed_out:
-                raise TimeoutError("Timed out waiting for peer %s" % addr)
-
-    def adhoc_wait_for_connected(self, addr):
-        self._adhoc_prop_found =3D False
-        self._adhoc_timed_out =3D False
-
-        def wait_timeout_cb():
-            self._adhoc_timed_out =3D True
-            return False
-
-        def adhoc_props_changed(iface, changed, invalid):
-            if changed.get('ConnectedPeers', None):
-                if addr in changed['ConnectedPeers']:
-                    self._adhoc_prop_found =3D True
-
-        self._prop_proxy.connect_to_signal('PropertiesChanged',
-                                            adhoc_props_changed)
-
-        props =3D self._prop_proxy.GetAll(IWD_ADHOC_INTERFACE)
-        if props.get('ConnectedPeers', None):
-            if addr in props['ConnectedPeers']:
-                return
-
-        GLib.timeout_add(int(50 * 1000), wait_timeout_cb)
-        context =3D ctx.mainloop.get_context()
-        while not self._adhoc_prop_found:
-            context.iteration(may_block=3DTrue)
-            if self._adhoc_timed_out:
-                raise TimeoutError("Timed out waiting for peer %s" % addr)
-
     def __str__(self, prefix =3D ''):
         return prefix + 'Device: ' + self.device_path + '\n'\
                + prefix + '\tName:\t\t' + self.name + '\n'\
-- =

2.26.2

--===============7341262476857997439==--

