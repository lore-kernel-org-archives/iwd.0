Content-Type: multipart/mixed; boundary="===============4205548993151783461=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] auto-t: fix hostapd.ungraceful_restart
Date: Tue, 14 Jul 2020 11:49:07 -0700
Message-ID: <20200714184908.2776-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4205548993151783461==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Restarting hostapd from python was actually leaking memory and
causing the hostapd object to stay referenced in python. The
GLib timeout in wait_for_event was the ultimate cause, but this
had no come to light because no tests restarted hostapd then
used wait_for_event.

In addition, any use of wait_for_event after a restart would
cause an exception because the event socket was never re-attached
after hostapd restarted.

Now we properly clean up the timeout in wait_for_event and
re-initialize the hostapd object on restart.
---
 autotests/util/hostapd.py | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 49047f38..0ed4e004 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -33,7 +33,7 @@ hostapd_map =3D {ifname: intf for wname, wiphy in wiphy_m=
ap.items()
         if wiphy.use =3D=3D 'hostapd'}
 =

 class HostapdCLI:
-    def __init__(self, interface=3DNone, config=3DNone):
+    def _init_hostapd(self, interface=3DNone, config=3DNone):
         global ctrl_count
 =

         if not interface and not config:
@@ -54,7 +54,8 @@ class HostapdCLI:
         self.cmdline =3D 'hostapd_cli -p"' + self.socket_path + '" -i"' + \
                 self.ifname + '"'
 =

-        self._hostapd_restarted =3D False
+        if not hasattr(self, '_hostapd_restarted'):
+            self._hostapd_restarted =3D False
 =

         self.local_ctrl =3D '/tmp/hostapd_' + str(os.getpid()) + '_' + \
                             str(ctrl_count)
@@ -67,6 +68,9 @@ class HostapdCLI:
 =

         ctrl_count =3D ctrl_count + 1
 =

+    def __init__(self, interface=3DNone, config=3DNone):
+        self._init_hostapd(interface, config)
+
     def wait_for_event(self, event, timeout=3D10):
         global mainloop
         self._wait_timed_out =3D False
@@ -84,6 +88,7 @@ class HostapdCLI:
             while self._data_available(0.25):
                 data =3D self.ctrl_sock.recv(4096).decode('utf-8')
                 if event in data:
+                    GLib.source_remove(timeout)
                     return data
 =

             if self._wait_timed_out:
@@ -108,11 +113,20 @@ class HostapdCLI:
 =

         raise Exception('timeout waiting for control response')
 =

-    def __del__(self):
+    def _del_hostapd(self, force=3DFalse):
+        self.ctrl_sock.close()
+
         if self._hostapd_restarted:
-            os.system('killall hostapd')
+            if force:
+                os.system('killall -9 hostapd')
+            else:
+                os.system('killall hostapd')
 =

-        self.ctrl_sock.close()
+            os.system('ifconfig %s down' % self.ifname)
+            os.system('ifconfig %s up' % self.ifname)
+
+    def __del__(self):
+        self._del_hostapd()
 =

     def wps_push_button(self):
         os.system(self.cmdline + ' wps_pbc')
@@ -193,15 +207,20 @@ class HostapdCLI:
         '''
             Ungracefully kill and restart hostapd
         '''
+        # set flag so hostapd can be killed after the test
+        self._hostapd_restarted =3D True
         intf =3D hostapd_map[self.ifname]
-        os.system('killall -9 hostapd')
-        os.system('ifconfig %s down' % intf.name)
-        os.system('ifconfig %s up' % intf.name)
+
+        self._del_hostapd(force=3DTrue)
+
         os.system('hostapd -g %s -i %s %s &' %
                   (intf.ctrl_interface, intf.name, intf.config))
 =

-        # set flag so hostapd can be killed after the test
-        self._hostapd_restarted =3D True
+        # Give hostapd a second to start and initialize the control interf=
ace
+        time.sleep(1)
+
+        # New hostapd process, so re-init
+        self._init_hostapd(intf)
 =

     def req_beacon(self, addr, request):
         '''
-- =

2.21.1

--===============4205548993151783461==--

