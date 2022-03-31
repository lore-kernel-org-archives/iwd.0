Content-Type: multipart/mixed; boundary="===============2487382152012567343=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 12/14] auto-t: hostapd.py: use IO watch for hostapd events
Date: Thu, 31 Mar 2022 16:16:39 -0700
Message-ID: <20220331231641.484200-12-prestwoj@gmail.com>
In-Reply-To: 20220331231641.484200-1-prestwoj@gmail.com

--===============2487382152012567343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With how fast UML is hostapd events were being sent out prior to
ever calling wait_for_event. Instead set an IO watch on the control
socket and cache all events as they come. Then, when wait_for_event
is called, it can reference this list. If the event is found any
older events are purged from the list.

The AP-ENABLED event needed a special case because hostapd gets
started before the IO watch can be registered. To fix this an
enabled property was added which queries the state directly. This
is checked first, and if not enabled wait_for_event continues normally.
---
 autotests/util/hostapd.py | 68 ++++++++++++++++++++++++++-------------
 tools/run-tests           |  3 +-
 2 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 4ae7c42d..6a9f37c7 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -81,27 +81,48 @@ class HostapdCLI(object):
 =

         self.ctrl_sock.connect(self.socket_path + '/' + self.ifname)
 =

+        self.events =3D []
+        self.io_watch =3D GLib.io_add_watch(self.ctrl_sock, GLib.IO_IN, se=
lf._handle_data_in)
+
         if 'OK' not in self._ctrl_request('ATTACH'):
             raise Exception('ATTACH failed')
 =

         ctrl_count =3D ctrl_count + 1
 =

-    def _poll_event(self, event):
-        if not self._data_available(0.25):
-            return False
+    def _handle_data_in(self, sock, *args):
+        newdata =3D sock.recv(4096)
+
+        decoded =3D newdata.decode('utf-8')
+        if len(decoded) >=3D 3 and decoded[0] =3D=3D '<' and decoded[2] =
=3D=3D '>':
+            decoded =3D decoded[3:]
+        while len(decoded) and decoded[-1] =3D=3D '\n':
+            decoded =3D decoded[:-1]
+
+        self.events.insert(0, decoded)
+
+        return True
 =

-        data =3D self.ctrl_sock.recv(4096).decode('utf-8')
-        if event in data:
-            return data
+    def _poll_event(self, event):
+        # Look through the list (most recent is first) until the even is f=
ound.
+        # Once found consume this event and any older ones as to not
+        # accidentally trigger a false positive later on.
+        for idx, e in enumerate(self.events):
+            if event in e:
+                self.events =3D self.events[:idx]
+                return e
 =

         return False
 =

     def wait_for_event(self, event, timeout=3D10):
+        if event =3D=3D 'AP-ENABLED':
+            if self.enabled:
+                return 'AP-ENABLED'
+
         return ctx.non_block_wait(self._poll_event, timeout, event,
                                     exception=3DTimeoutError("waiting for =
event"))
 =

-    def _data_available(self, timeout=3D2):
-        [r, w, e] =3D select.select([self.ctrl_sock], [], [], timeout)
+    def _data_available(self):
+        [r, w, e] =3D select.select([self.ctrl_sock], [], [])
         if r:
             return True
         return False
@@ -228,25 +249,28 @@ class HostapdCLI(object):
         ctx.start_process(cmd).wait()
         self.wait_for_event('AP-CSA-FINISHED')
 =

-    @property
-    def bssid(self):
+    def _get_status(self):
+        ret =3D {}
+
         cmd =3D self.cmdline + ['status']
         proc =3D ctx.start_process(cmd)
         proc.wait()
-        status =3D proc.out.split('\n')
+        status =3D proc.out.strip().split('\n')
 =

-        bssid =3D [x for x in status if x.startswith('bssid')]
-        bssid =3D bssid[0].split('=3D')
-        return bssid[1]
+        for kv in status:
+            k, v =3D kv.split('=3D')
+            ret[k] =3D v
+
+        return ret
 =

     @property
-    def frequency(self):
-        cmd =3D self.cmdline + ['status']
-        proc =3D ctx.start_process(cmd)
-        proc.wait()
-        status =3D proc.out.split('\n')
+    def bssid(self):
+        return self._get_status()['bssid[0]']
 =

-        frequency =3D [x for x in status if x.startswith('freq')][0]
-        frequency =3D frequency.split('=3D')[1]
+    @property
+    def frequency(self):
+        return int(self._get_status()['freq'])
 =

-        return int(frequency)
+    @property
+    def enabled(self):
+        return self._get_status()['state'] =3D=3D 'ENABLED'
diff --git a/tools/run-tests b/tools/run-tests
index c4d133a6..2b9290ed 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -540,7 +540,8 @@ class Hostapd:
 		except:
 			print("Failed to remove %s" % self.global_ctrl_iface)
 =

-		self.instances =3D None
+		for hapd in self.instances:
+			GLib.source_remove(hapd.cli.io_watch)
 =

 		# Hostapd may have already been stopped
 		if self.process:
-- =

2.34.1

--===============2487382152012567343==--

