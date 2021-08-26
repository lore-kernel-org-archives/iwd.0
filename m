Content-Type: multipart/mixed; boundary="===============6646761624415558981=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] auto-t: hostapd.py: properly implement singleton
 (per-config)
Date: Thu, 26 Aug 2021 13:33:32 -0700
Message-ID: <20210826203333.1067317-2-prestwoj@gmail.com>
In-Reply-To: <20210826203333.1067317-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6646761624415558981==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This shouldn't change any functionality but it is much more convenient
in the cleanup path i.e. nothing special needs to be done.
---
 autotests/util/hostapd.py | 16 ++++++----------
 tools/test-runner         |  7 -------
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 10104862..07d27f1b 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -5,6 +5,7 @@ import socket
 import select
 import time
 from gi.repository import GLib
+from weakref import WeakValueDictionary
 from config import ctx
 =

 chan_freq_map =3D [
@@ -29,7 +30,7 @@ ctrl_count =3D 0
 mainloop =3D GLib.MainLoop()
 =

 class HostapdCLI(object):
-    _instances =3D {}
+    _instances =3D WeakValueDictionary()
 =

     def __new__(cls, config=3DNone, *args, **kwargs):
         hapd =3D ctx.hostapd[config]
@@ -38,8 +39,10 @@ class HostapdCLI(object):
             config =3D hapd.config
 =

         if not config in cls._instances.keys():
-            cls._instances[config] =3D object.__new__(cls, *args, **kwargs)
-            cls._instances[config]._initialized =3D False
+            obj =3D object.__new__(cls, *args, **kwargs)
+            obj._initialized =3D False
+
+            cls._instances[config] =3D obj
 =

         return cls._instances[config]
 =

@@ -123,13 +126,6 @@ class HostapdCLI(object):
         except:
             pass
 =

-        HostapdCLI._instances[self.config] =3D None
-
-        # Check if this is the final instance
-        destroy =3D len([hapd for hapd in HostapdCLI._instances.values() i=
f hapd is not None]) =3D=3D 0
-        if destroy:
-            HostapdCLI._instances =3D {}
-
     def set_value(self, key, value):
         cmd =3D self.cmdline + ['set', key, value]
         ctx.start_process(cmd).wait()
diff --git a/tools/test-runner b/tools/test-runner
index 8b244e99..b7a283d1 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -541,13 +541,6 @@ class Hostapd:
 		except:
 			print("Failed to remove %s" % self.global_ctrl_iface)
 =

-		for hapd in self.instances:
-			if not hapd.cli:
-				continue
-
-			hapd.cli._instances[hapd.config] =3D None
-			hapd.cli =3D None
-
 		self.instances =3D None
 =

 		# Hostapd may have already been stopped
-- =

2.31.1

--===============6646761624415558981==--

