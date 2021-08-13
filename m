Content-Type: multipart/mixed; boundary="===============2243829354373826077=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] auto-t: return existing instance from HostapdCLI
Date: Fri, 13 Aug 2021 15:45:51 -0700
Message-ID: <20210813224554.816379-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2243829354373826077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This addresses the TODO where HostapdCLI was creating separate
objects each time HostapdCLI was called. This was worked around
by manually setting the important members but instead the class
can be re-worked to act as somewhat of a singleton, per-config
at least.

If there is no HostapdCLI instance for a given config one is
created and initialized. Subsequent HostapdCLI calls (for the
same config) will be returned the same object rather than a
new one.
---
 autotests/util/hostapd.py | 48 +++++++++++++++++++++++----------------
 tools/test-runner         |  4 ++++
 2 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index a61b2d39..aabc997b 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -28,10 +28,28 @@ chan_freq_map =3D [
 ctrl_count =3D 0
 mainloop =3D GLib.MainLoop()
 =

-class HostapdCLI:
-    def _init_hostapd(self, config=3DNone):
+class HostapdCLI(object):
+    _instances =3D {}
+
+    def __new__(cls, config=3DNone, *args, **kwargs):
+        hapd =3D ctx.hostapd[config]
+
+        if not config:
+            config =3D hapd.config
+
+        if not config in cls._instances.keys():
+            cls._instances[config] =3D object.__new__(cls, *args, **kwargs)
+            cls._instances[config]._initialized =3D False
+
+        return cls._instances[config]
+
+    def _init_hostapd(self, config):
         global ctrl_count
-        interface =3D None
+
+        if self._initialized:
+            return
+
+        self._initialized =3D True
         self.ctrl_sock =3D None
 =

         if not ctx.hostapd:
@@ -45,21 +63,6 @@ class HostapdCLI:
         if not hasattr(self, '_hostapd_restarted'):
             self._hostapd_restarted =3D False
 =

-        #
-        # TODO: In theory some type of instance singleton could be created=
 for
-        #       HostapdCLI where test-runner initializes but any subsequent
-        #       call to HostapdCLI (with the same config) returns the same
-        #       object that test-runner has. This would avoid setting these
-        #       variables.
-        #
-        if hapd.cli:
-            self.ifname =3D hapd.cli.ifname
-            self.ctrl_sock =3D hapd.cli.ctrl_sock
-            self.cmdline =3D hapd.cli.cmdline
-            self.interface =3D hapd.intf
-            self.config =3D hapd.config
-            return
-
         self.interface =3D hapd.intf
         self.config =3D hapd.config
 =

@@ -83,7 +86,7 @@ class HostapdCLI:
 =

         ctrl_count =3D ctrl_count + 1
 =

-    def __init__(self, config=3DNone):
+    def __init__(self, config=3DNone, *args, **kwargs):
         self._init_hostapd(config)
 =

     def _poll_event(self, event):
@@ -137,6 +140,13 @@ class HostapdCLI:
     def __del__(self):
         self._del_hostapd()
 =

+        HostapdCLI._instances[self.config] =3D None
+
+        # Check if this is the final instance
+        destroy =3D len([hapd for hapd in HostapdCLI._instances.values() i=
f hapd is not None]) =3D=3D 0
+        if destroy:
+            HostapdCLI._instances =3D {}
+
     def set_value(self, key, value):
         cmd =3D self.cmdline + ['set', key, value]
         ctx.start_process(cmd, wait=3DTrue)
diff --git a/tools/test-runner b/tools/test-runner
index 0ca50ddb..5a8006a5 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -545,6 +545,10 @@ class Hostapd:
 		except:
 			print("Failed to remove %s" % self.global_ctrl_iface)
 =

+		for hapd in self.instances:
+			hapd.cli._instances[hapd.config] =3D None
+			hapd.cli =3D None
+
 		self.instances =3D None
 =

 		# Hostapd may have already been stopped
-- =

2.31.1

--===============2243829354373826077==--

