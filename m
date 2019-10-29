Content-Type: multipart/mixed; boundary="===============6648745209726378009=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/5] auto-t: support hostapd event processing
Date: Tue, 29 Oct 2019 10:50:39 -0700
Message-ID: <20191029175043.27745-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6648745209726378009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hostapd has a feature where you can connect to its control socket and
receive events it generates. Currently we only send commands via this
socket.

First we open the socket (/var/run/hostapd/<iface>) and send the
ATTACH command. This tells hostapd we are ready and after this any
events will be sent over this socket.

A new API, wait_for_event, was added which takes an event string and
waits for some timeout. The glib event loop has been integrated into
this, though its not technically async since we are selecting over a
socket which blocks. To mitigate this a small timeout was chosen for
each select call and then wrapped in a while loop which waits for the
full timeout.
---
 autotests/util/hostapd.py | 68 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 209d8c24..49047f38 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -3,6 +3,9 @@ import os, os.path
 from wiphy import wiphy_map
 import re
 import socket
+import select
+import time
+from gi.repository import GLib
 =

 chan_freq_map =3D [
     None,
@@ -22,12 +25,17 @@ chan_freq_map =3D [
     2484
 ]
 =

+ctrl_count =3D 0
+mainloop =3D GLib.MainLoop()
+
 hostapd_map =3D {ifname: intf for wname, wiphy in wiphy_map.items()
         for ifname, intf in wiphy.interface_map.items()
         if wiphy.use =3D=3D 'hostapd'}
 =

 class HostapdCLI:
     def __init__(self, interface=3DNone, config=3DNone):
+        global ctrl_count
+
         if not interface and not config:
             raise Exception('interface or config must be provided')
 =

@@ -48,10 +56,64 @@ class HostapdCLI:
 =

         self._hostapd_restarted =3D False
 =

+        self.local_ctrl =3D '/tmp/hostapd_' + str(os.getpid()) + '_' + \
+                            str(ctrl_count)
+        self.ctrl_sock =3D socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM)
+        self.ctrl_sock.bind(self.local_ctrl)
+        self.ctrl_sock.connect(self.socket_path + '/' + self.ifname)
+
+        if 'OK' not in self._ctrl_request('ATTACH'):
+            raise Exception('ATTACH failed')
+
+        ctrl_count =3D ctrl_count + 1
+
+    def wait_for_event(self, event, timeout=3D10):
+        global mainloop
+        self._wait_timed_out =3D False
+
+        def wait_timeout_cb():
+            self._wait_timed_out =3D True
+            return False
+
+        timeout =3D GLib.timeout_add_seconds(timeout, wait_timeout_cb)
+        context =3D mainloop.get_context()
+
+        while True:
+            context.iteration(may_block=3DFalse)
+
+            while self._data_available(0.25):
+                data =3D self.ctrl_sock.recv(4096).decode('utf-8')
+                if event in data:
+                    return data
+
+            if self._wait_timed_out:
+                raise TimeoutError('waiting for hostapd event timed out')
+
+        return None
+
+    def _data_available(self, timeout=3D2):
+        [r, w, e] =3D select.select([self.ctrl_sock], [], [], timeout)
+        if r:
+            return True
+        return False
+
+    def _ctrl_request(self, command, timeout=3D10):
+        if type(command) is str:
+            command =3D str.encode(command)
+
+        self.ctrl_sock.send(bytes(command))
+
+        if self._data_available(timeout):
+            return self.ctrl_sock.recv(4096).decode('utf-8')
+
+        raise Exception('timeout waiting for control response')
+
     def __del__(self):
         if self._hostapd_restarted:
             os.system('killall hostapd')
 =

+        self.ctrl_sock.close()
+
     def wps_push_button(self):
         os.system(self.cmdline + ' wps_pbc')
 =

@@ -140,3 +202,9 @@ class HostapdCLI:
 =

         # set flag so hostapd can be killed after the test
         self._hostapd_restarted =3D True
+
+    def req_beacon(self, addr, request):
+        '''
+            Send a RRM Beacon request
+        '''
+        os.system(self.cmdline + ' req_beacon ' + addr + ' ' + request)
-- =

2.17.1

--===============6648745209726378009==--

