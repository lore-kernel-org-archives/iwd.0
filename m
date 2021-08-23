Content-Type: multipart/mixed; boundary="===============5348020038779424993=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] auto-t: hostapd.py: remove ungraceful_restart
Date: Mon, 23 Aug 2021 11:32:21 -0700
Message-ID: <20210823183221.558154-3-prestwoj@gmail.com>
In-Reply-To: <20210823183221.558154-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5348020038779424993==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is no longer needed and greatly simplifies the class
---
 autotests/util/hostapd.py | 37 +++++--------------------------------
 1 file changed, 5 insertions(+), 32 deletions(-)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 8b81d467..2dcf38f9 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -43,10 +43,10 @@ class HostapdCLI(object):
 =

         return cls._instances[config]
 =

-    def _init_hostapd(self, config, reinit=3DFalse):
+    def __init__(self, config=3DNone, *args, **kwargs):
         global ctrl_count
 =

-        if self._initialized and not reinit:
+        if self._initialized:
             return
 =

         self._initialized =3D True
@@ -83,9 +83,6 @@ class HostapdCLI(object):
 =

         ctrl_count =3D ctrl_count + 1
 =

-    def __init__(self, config=3DNone, *args, **kwargs):
-        self._init_hostapd(config)
-
     def _poll_event(self, event):
         if not self._data_available(0.25):
             return False
@@ -117,20 +114,15 @@ class HostapdCLI(object):
 =

         return self.ctrl_sock.recv(4096).decode('utf-8')
 =

-    def _del_hostapd(self, force=3DFalse):
-        if not self.ctrl_sock:
-            return
-
-        self.ctrl_sock.close()
+    def __del__(self):
+        if self.ctrl_sock:
+            self.ctrl_sock.close()
 =

         try:
             os.remove(self.local_ctrl)
         except:
             pass
 =

-    def __del__(self):
-        self._del_hostapd()
-
         HostapdCLI._instances[self.config] =3D None
 =

         # Check if this is the final instance
@@ -202,25 +194,6 @@ class HostapdCLI(object):
         if 'OK' not in proc.out:
             raise Exception('BSS_TM_REQ failed, is hostapd built with CONF=
IG_WNM_AP=3Dy?')
 =

-    def ungraceful_restart(self):
-        '''
-            Ungracefully kill and restart hostapd
-        '''
-        ctx.stop_process(ctx.hostapd.process, True)
-
-        self.interface.set_interface_state('down')
-        self.interface.set_interface_state('up')
-
-        self._del_hostapd(force=3DTrue)
-
-        ctx.start_hostapd()
-
-        # Give hostapd a second to start and initialize the control interf=
ace
-        time.sleep(1)
-
-        # New hostapd process, so re-init
-        self._init_hostapd(config=3Dself.config, reinit=3DTrue)
-
     def req_beacon(self, addr, request):
         '''
             Send a RRM Beacon request
-- =

2.31.1

--===============5348020038779424993==--

