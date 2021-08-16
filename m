Content-Type: multipart/mixed; boundary="===============1602133913048366175=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: hostapd.py: remove _hostapd_restarted concept
Date: Mon, 16 Aug 2021 09:04:50 -0700
Message-ID: <20210816160450.11566-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1602133913048366175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The destructor was trying to do more than the scope of a destructor
by trying to handle this single case of hostapd being restarted.

Instead we can simply pass a keyword argument 'reinit' to the
constructor to tell it to reinitialize everything. And as for killing
hostapd this can be done in ungraceful_restart itself rather than
trying to handle it in the destructor.
---
 autotests/util/hostapd.py | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index aabc997b..8b81d467 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -43,10 +43,10 @@ class HostapdCLI(object):
 =

         return cls._instances[config]
 =

-    def _init_hostapd(self, config):
+    def _init_hostapd(self, config, reinit=3DFalse):
         global ctrl_count
 =

-        if self._initialized:
+        if self._initialized and not reinit:
             return
 =

         self._initialized =3D True
@@ -60,9 +60,6 @@ class HostapdCLI(object):
 =

         hapd =3D ctx.hostapd[config]
 =

-        if not hasattr(self, '_hostapd_restarted'):
-            self._hostapd_restarted =3D False
-
         self.interface =3D hapd.intf
         self.config =3D hapd.config
 =

@@ -131,12 +128,6 @@ class HostapdCLI(object):
         except:
             pass
 =

-        if self._hostapd_restarted:
-            ctx.stop_process(ctx.hostapd.process, force)
-
-            self.interface.set_interface_state('down')
-            self.interface.set_interface_state('up')
-
     def __del__(self):
         self._del_hostapd()
 =

@@ -215,8 +206,10 @@ class HostapdCLI(object):
         '''
             Ungracefully kill and restart hostapd
         '''
-        # set flag so hostapd can be killed after the test
-        self._hostapd_restarted =3D True
+        ctx.stop_process(ctx.hostapd.process, True)
+
+        self.interface.set_interface_state('down')
+        self.interface.set_interface_state('up')
 =

         self._del_hostapd(force=3DTrue)
 =

@@ -226,7 +219,7 @@ class HostapdCLI(object):
         time.sleep(1)
 =

         # New hostapd process, so re-init
-        self._init_hostapd(config=3Dself.config)
+        self._init_hostapd(config=3Dself.config, reinit=3DTrue)
 =

     def req_beacon(self, addr, request):
         '''
-- =

2.31.1

--===============1602133913048366175==--

