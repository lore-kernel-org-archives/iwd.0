Content-Type: multipart/mixed; boundary="===============4047557386460085264=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 6/8] autotests: Add basic wpa_supplicant P2P python wrapper
Date: Tue, 29 Sep 2020 18:37:15 +0200
Message-ID: <20200929163717.754459-12-andrew.zaborowski@intel.com>
In-Reply-To: <20200929163717.754459-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4047557386460085264==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the new wpas.Wpas class roughly based on hostapd.HostapdCLI but only
adding methods for the P2P-related stuff.

Adding "wpa_supplicant" to will enable output from the wpa_supplicant
process to be printed and "wpa_supplicant-dbg" will make it more verbose
("wpa_supplicant" is not needed because it seems to be automatically
enabled because of the glob matching in ctx.is_verbose)
---
 autotests/util/wpas.py | 222 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 222 insertions(+)
 create mode 100644 autotests/util/wpas.py

diff --git a/autotests/util/wpas.py b/autotests/util/wpas.py
new file mode 100644
index 00000000..e871b1b1
--- /dev/null
+++ b/autotests/util/wpas.py
@@ -0,0 +1,222 @@
+#!/usr/bin/python3
+import os
+import socket
+from gi.repository import GLib
+from config import ctx
+
+ctrl_count =3D 0
+mainloop =3D GLib.MainLoop()
+
+class Wpas:
+    def _start_wpas(self, config_path, socket_path, main_interface, ifname=
=3DNone):
+        global ctrl_count
+
+        self.interface =3D main_interface
+        self.ifname =3D main_interface.name if ifname is None else ifname
+        self.socket_path =3D socket_path
+        self.io_watch =3D None
+
+        cmd =3D ['wpa_supplicant', '-i', self.interface.name, '-c', config=
_path]
+        if ctx.is_verbose('wpa_supplicant-dbg'):
+            cmd +=3D ['-d']
+
+        self.wpa_supplicant =3D ctx.start_process(cmd)
+
+        self.local_ctrl =3D '/tmp/wpas_' + str(os.getpid()) + '_' + str(ct=
rl_count)
+        ctrl_count =3D ctrl_count + 1
+        self.ctrl_sock =3D socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM)
+        self.ctrl_sock.bind(self.local_ctrl)
+
+        self.remote_ctrl =3D self.socket_path + '/' + self.ifname
+        self.wpa_supplicant.wait_for_socket(self.remote_ctrl, 2)
+        self.ctrl_sock.connect(self.remote_ctrl)
+        self.io_watch =3D GLib.io_add_watch(self.ctrl_sock, GLib.IO_IN, se=
lf._handle_data_in)
+
+        self.p2p_peers =3D {}
+        self.p2p_go_neg_requests =3D {}
+        self.p2p_clients =3D {}
+        self.p2p_group =3D None
+
+        self._rx_data =3D []
+        self._ctrl_request('ATTACH')
+        self.wait_for_event('OK')
+
+    def __init__(self, *args, **kwargs):
+        self._start_wpas(*args, **kwargs)
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
+            context.iteration(may_block=3DTrue)
+
+            if event in self._rx_data:
+                GLib.source_remove(timeout)
+                return self._rx_data
+
+            if self._wait_timed_out:
+                raise TimeoutError('waiting for wpas event timed out')
+
+    def _event_parse(self, line):
+        # Unescape event parameter values in '', other escaping rules not =
implemented
+        key =3D None
+        value =3D ''
+        count =3D 0
+        quoted =3D False
+        event =3D {}
+
+        def handle_eow():
+            nonlocal key, value, count, event
+            if count =3D=3D 0:
+                if key is not None or not value:
+                    raise Exception('Bad event name')
+                key =3D 'event'
+            elif key is None:
+                if not value:
+                    return
+                key =3D 'arg' + str(count)
+            event[key] =3D value
+            key =3D None
+            value =3D ''
+            count +=3D 1
+
+        for ch in line:
+            if ch =3D=3D '\'':
+                quoted =3D not quoted
+            elif quoted:
+                value +=3D ch
+            elif ch =3D=3D '=3D' and key is None:
+                key =3D value
+                value =3D ''
+            elif ch in ' \n':
+                handle_eow()
+            else:
+                value +=3D ch
+        handle_eow()
+        return event
+
+    def _handle_data_in(self, sock, *args):
+        newdata =3D sock.recv(4096)
+        if len(newdata) =3D=3D 0:
+            raise Exception('Wpa_s control socket error')
+
+        decoded =3D newdata.decode('utf-8')
+        if len(decoded) >=3D 3 and decoded[0] =3D=3D '<' and decoded[2] =
=3D=3D '>':
+            decoded =3D decoded[3:]
+        while len(decoded) and decoded[-1] =3D=3D '\n':
+            decoded =3D decoded[:-1]
+
+        self._rx_data.append(decoded)
+
+        event =3D self._event_parse(decoded)
+        if event['event'] =3D=3D 'P2P-DEVICE-FOUND':
+            event.pop('event')
+            event.pop('arg1')
+            self.p2p_peers[event['p2p_dev_addr']] =3D event
+        elif event['event'] =3D=3D 'P2P-DEVICE-LOST':
+            del self.p2p_peers[event['p2p_dev_addr']]
+        elif event['event'] =3D=3D 'P2P-GO-NEG-REQUEST':
+            event.pop('event')
+            event['p2p_dev_addr'] =3D event.pop('arg1')
+            self.p2p_go_neg_requests[event['p2p_dev_addr']] =3D event
+        elif event['event'] =3D=3D 'P2P-GO-NEG-SUCCESS':
+            event.pop('event')
+            addr =3D event.pop('peer_dev')
+            event['success'] =3D True
+            event['p2p_dev_addr'] =3D addr
+
+            if addr in self.p2p_go_neg_requests:
+                self.p2p_go_neg_requests[addr].update(event)
+            else:
+                self.p2p_go_neg_requests[addr] =3D event
+        elif event['event'] =3D=3D 'AP-STA-CONNECTED':
+            event.pop('event')
+            addr =3D event.pop('arg1')
+            self.p2p_clients[addr] =3D event
+        elif event['event'] =3D=3D 'AP-STA-DISCONNECTED':
+            addr =3D event.pop('arg1')
+            del self.p2p_clients[addr]
+        elif event['event'] =3D=3D 'P2P-GROUP-STARTED':
+            event.pop('event')
+            event['ifname'] =3D event.pop('arg1')
+            self.p2p_group =3D event
+        elif event['event'] =3D=3D 'P2P-GROUP-REMOVED':
+            self.p2p_group =3D None
+
+        return True
+
+    def _ctrl_request(self, command, timeout=3D10):
+        if type(command) is str:
+            command =3D str.encode(command)
+
+        self.ctrl_sock.send(bytes(command))
+
+    # Normal find phase with listen and active scan states
+    def p2p_find(self):
+        self._rx_data =3D []
+        self._ctrl_request('P2P_SET disc_int 2 3 300')
+        self.wait_for_event('OK')
+        self._rx_data =3D []
+        self._ctrl_request('P2P_FIND type=3Dsocial')
+        self.wait_for_event('OK')
+
+    # Like p2p_find but uses only listen states
+    def p2p_listen(self):
+        self._rx_data =3D []
+        self._ctrl_request('P2P_LISTEN')
+        self.wait_for_event('OK')
+
+    # Stop a p2p_find or p2p_listen
+    def p2p_stop_find_listen(self):
+        self._rx_data =3D []
+        self._ctrl_request('P2P_STOP_FIND')
+        self.wait_for_event('OK')
+
+    def p2p_connect(self, peer, pin=3DNone, go_intent=3DNone):
+        self._rx_data =3D []
+        self._ctrl_request('P2P_CONNECT ' + peer['p2p_dev_addr'] + ' ' + (=
'pbc' if pin is None else pin) +
+                        ('' if go_intent is None else 'go_intent=3D' + str=
(go_intent)))
+        self.wait_for_event('OK')
+
+    def p2p_accept_go_neg_request(self, request, pin=3DNone, go_intent=3DN=
one):
+        self._rx_data =3D []
+        self._ctrl_request('P2P_CONNECT ' + request['p2p_dev_addr'] + ' ' =
+ ('pbc' if pin is None else pin) +
+                        ('' if go_intent is None else 'go_intent=3D' + str=
(go_intent)))
+        self.wait_for_event('OK')
+
+    # Pre-accept the next GO Negotiation Request from this peer to avoid t=
he extra Respone + Request frames
+    def p2p_authorize(self, peer, pin=3DNone, go_intent=3DNone):
+        self._rx_data =3D []
+        self._ctrl_request('P2P_CONNECT ' + peer['p2p_dev_addr'] + ' ' + (=
'pbc' if pin is None else pin) +
+                        ('' if go_intent is None else 'go_intent=3D' + str=
(go_intent)) + ' auth')
+        self.wait_for_event('OK')
+
+    # Probably needed: remove references to self so that the GC can call _=
_del__ automatically
+    def clean_up(self):
+        if self.io_watch is not None:
+            GLib.source_remove(self.io_watch)
+            self.io_watch =3D None
+        if self.wpa_supplicant is not None:
+            ctx.stop_process(self.wpa_supplicant)
+            self.wpa_supplicant =3D None
+
+    def _stop_wpas(self):
+        self.clean_up()
+        if self.ctrl_sock:
+            self.ctrl_sock.close()
+            self.ctrl_sock =3D None
+        if os.path.exists(self.remote_ctrl):
+            os.remove(self.remote_ctrl)
+        if os.path.exists(self.local_ctrl):
+            os.remove(self.local_ctrl)
+
+    def __del__(self):
+        self._stop_wpas()
-- =

2.25.1

--===============4047557386460085264==--

