Content-Type: multipart/mixed; boundary="===============1180450039724200117=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 14/15] autotests: Add P2P GO role test scenarios
Date: Fri, 04 Jun 2021 03:50:51 +0200
Message-ID: <20210604015052.163727-14-andrew.zaborowski@intel.com>
In-Reply-To: <20210604015052.163727-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1180450039724200117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

autotests/testP2P/client_test.py is renamed to connection_test.py to
reflect that it now tests both roles.
---
 .../{client_test.py =3D> connection_test.py}    | 71 ++++++++++++++-----
 autotests/testP2P/dhclient-script             | 17 +++++
 autotests/testP2P/main.conf                   |  3 +
 autotests/util/wpas.py                        | 63 ++++++++++------
 4 files changed, 114 insertions(+), 40 deletions(-)
 rename autotests/testP2P/{client_test.py =3D> connection_test.py} (51%)
 create mode 100755 autotests/testP2P/dhclient-script

diff --git a/autotests/testP2P/client_test.py b/autotests/testP2P/connectio=
n_test.py
similarity index 51%
rename from autotests/testP2P/client_test.py
rename to autotests/testP2P/connection_test.py
index 4994de76..9bb0e34e 100644
--- a/autotests/testP2P/client_test.py
+++ b/autotests/testP2P/connection_test.py
@@ -4,6 +4,7 @@ import unittest
 import sys
 import netifaces
 import os
+import time
 =

 import iwd
 from iwd import IWD
@@ -13,14 +14,21 @@ from wpas import Wpas
 =

 class Test(unittest.TestCase):
     def test_1_client_go_neg_responder(self):
-        self.p2p_client_test(False)
+        self.p2p_connect_test(preauthorize=3DFalse, go=3DFalse)
 =

     def test_2_client_go_neg_initiator(self):
-        self.p2p_client_test(True)
+        self.p2p_connect_test(preauthorize=3DTrue, go=3DFalse)
 =

-    def p2p_client_test(self, preauthorize):
-        wpas =3D Wpas(p2p=3DTrue)
+    def test_3_go_go_neg_responder(self):
+        self.p2p_connect_test(preauthorize=3DFalse, go=3DTrue)
+
+    def test_4_go_go_neg_initiator(self):
+        self.p2p_connect_test(preauthorize=3DTrue, go=3DTrue)
+
+    def p2p_connect_test(self, preauthorize, go):
         wd =3D IWD()
+        wpas =3D Wpas(p2p=3DTrue)
+        wpas_go_intent =3D 10 if not go else 1
 =

         # Not strictly necessary but prevents the station interface from q=
ueuing its scans
         # in the wiphy radio work queue and delaying P2P scans.
@@ -51,7 +59,7 @@ class Test(unittest.TestCase):
         self.assertEqual(wpas_peer['config_methods'], '0x1080')
 =

         if preauthorize:
-            wpas.p2p_authorize(wpas_peer)
+            wpas.p2p_authorize(wpas_peer, go_intent=3Dwpas_go_intent)
 =

         peer.connect(wait=3DFalse)
 =

@@ -64,38 +72,63 @@ class Test(unittest.TestCase):
             self.assertEqual(request['dev_passwd_id'], '4')
             self.assertEqual(request['go_intent'], '2') # Hardcoded in src=
/p2p.c
 =

-            wpas.p2p_accept_go_neg_request(request)
+            wpas.p2p_accept_go_neg_request(request, go_intent=3Dwpas_go_in=
tent)
 =

         wd.wait_for_object_condition(request, '\'success\' in obj', max_wa=
it=3D3)
         self.assertEqual(request['success'], True)
-        self.assertEqual(request['role'], 'GO')
+        self.assertEqual(request['role'], 'GO' if not go else 'client')
         self.assertEqual(request['wps_method'], 'PBC')
         self.assertEqual(request['p2p_dev_addr'], wpas_peer['p2p_dev_addr'=
])
 =

+        if go:
+            # For some reason wpa_supplicant's newly created P2P-client in=
terface doesn't inherit
+            # the settings from the main interface which were loaded from =
the config file
+            # (P2P-device and P2P-GO interfaces do), we need to set config=
_methods again.
+            peer_ifname =3D 'p2p-' + wpas.interface.name + '-0'
+            wpas.set('config_methods', wpas.config['config_methods'], ifna=
me=3Dpeer_ifname)
+            wpas.set('device_name', wpas.config['device_name'], ifname=3Dp=
eer_ifname)
+            wpas.set('device_type', wpas.config['device_type'], ifname=3Dp=
eer_ifname)
+
         wd.wait_for_object_condition(wpas, 'obj.p2p_group is not None', ma=
x_wait=3D3)
-        go_ifname =3D wpas.p2p_group['ifname']
-        ctx.start_process(['ifconfig', go_ifname, '192.168.1.20', 'netmask=
', '255.255.255.0'], wait=3DTrue)
-        os.system('> /tmp/dhcpd.leases')
-        dhcpd =3D ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/dhcpd.con=
f', '-lf', '/tmp/dhcpd.leases', go_ifname])
+        peer_ifname =3D wpas.p2p_group['ifname']
+
+        if not go:
+            ctx.start_process(['ifconfig', peer_ifname, '192.168.1.20', 'n=
etmask', '255.255.255.0'], wait=3DTrue)
+            os.system('> /tmp/dhcpd.leases')
+            dhcp =3D ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/dhcpd.=
conf', '-lf', '/tmp/dhcpd.leases', peer_ifname])
 =

-        wd.wait_for_object_condition(wpas, 'len(obj.p2p_clients) =3D=3D 1'=
, max_wait=3D3)
-        client =3D wpas.p2p_clients[request['peer_iface']]
-        self.assertEqual(client['p2p_dev_addr'], wpas_peer['p2p_dev_addr'])
+            wd.wait_for_object_condition(wpas, 'len(obj.p2p_clients) =3D=
=3D 1', max_wait=3D3)
+            client =3D wpas.p2p_clients[request['peer_iface']]
+            self.assertEqual(client['p2p_dev_addr'], wpas_peer['p2p_dev_ad=
dr'])
+        else:
+            dhcp =3D ctx.start_process(['dhclient', '-v', '-d', '--no-pid'=
, '-cf', '/dev/null', '-lf', '/tmp/dhcpd.leases',
+                '-sf', '/tmp/dhclient-script', peer_ifname])
 =

         wd.wait_for_object_condition(peer, 'obj.connected', max_wait=3D15)
+        time.sleep(1) # Give the client time to set the IP
         our_ip =3D netifaces.ifaddresses(peer.connected_interface)[netifac=
es.AF_INET][0]['addr']
-        self.assertEqual(peer.connected_ip, '192.168.1.20')
-        self.assertEqual(our_ip, '192.168.1.30')
+        peer_ip =3D netifaces.ifaddresses(peer_ifname)[netifaces.AF_INET][=
0]['addr']
+        self.assertEqual(peer.connected_ip, peer_ip)
+
+        if not go:
+            self.assertEqual(our_ip, '192.168.1.30')
+            self.assertEqual(peer_ip, '192.168.1.20')
+        else:
+            self.assertEqual(our_ip, '192.168.1.1')
+            self.assertEqual(peer_ip, '192.168.1.2')
 =

         testutil.test_iface_operstate(peer.connected_interface)
-        testutil.test_ifaces_connected(peer.connected_interface, go_ifname)
+        testutil.test_ifaces_connected(peer.connected_interface, peer_ifna=
me)
 =

         peer.disconnect()
-        wd.wait_for_object_condition(wpas, 'len(obj.p2p_clients) =3D=3D 0'=
, max_wait=3D3)
+        if not go:
+            wd.wait_for_object_condition(wpas, 'len(obj.p2p_clients) =3D=
=3D 0', max_wait=3D3)
+        else:
+            wd.wait_for_object_condition(wpas, 'obj.p2p_group is None', ma=
x_wait=3D3)
         self.assertEqual(peer.connected, False)
 =

         p2p.enabled =3D False
-        ctx.stop_process(dhcpd)
+        ctx.stop_process(dhcp)
         wpas.clean_up()
 =

     @classmethod
diff --git a/autotests/testP2P/dhclient-script b/autotests/testP2P/dhclient=
-script
new file mode 100755
index 00000000..276880b6
--- /dev/null
+++ b/autotests/testP2P/dhclient-script
@@ -0,0 +1,17 @@
+#! /bin/bash
+case $reason in
+BOUND|RENEW|REBIND|REBOOT)
+  if [ x$new_ip_address !=3D x ] && \
+     [ x$new_ip_address !=3D x$old_ip_address -o \
+       x$reason =3D xBOUND -o x$reason =3D xREBOOT ]; then
+    /sbin/ip addr add $new_ip_address/${new_subnet_mask:-32} \
+                      ${new_broadcast_arg} \
+                      dev $interface
+  fi
+;;
+EXPIRE|FAIL|RELEASE|STOP)
+  if [ x$old_ip_address !=3D x ]; then
+    /sbin/ip -4 addr flush dev $interface
+  fi
+;;
+esac
diff --git a/autotests/testP2P/main.conf b/autotests/testP2P/main.conf
index 75040f78..b0bb5794 100644
--- a/autotests/testP2P/main.conf
+++ b/autotests/testP2P/main.conf
@@ -4,3 +4,6 @@ EnableNetworkConfiguration=3Dtrue
 [P2P]
 # Something different from the default of 'pc' for validation
 DeviceType=3Ddesktop
+
+[IPv4]
+APAddressPool=3D192.168.1.0/28
diff --git a/autotests/util/wpas.py b/autotests/util/wpas.py
index c54becbc..7072272a 100644
--- a/autotests/util/wpas.py
+++ b/autotests/util/wpas.py
@@ -8,13 +8,11 @@ ctrl_count =3D 0
 =

 class Wpas:
     def _start_wpas(self, config_name=3DNone, p2p=3DFalse):
-        global ctrl_count
-
         main_interface =3D None
         for interface in ctx.wpas_interfaces:
             if config_name is None or interface.config =3D=3D config_name:
                 if main_interface is not None:
-                    raise Exception('More than was wpa_supplicant interfac=
e matches given config')
+                    raise Exception('More than one wpa_supplicant interfac=
e matches given config')
                 main_interface =3D interface
 =

         if main_interface is None:
@@ -37,15 +35,9 @@ class Wpas:
 =

         self.wpa_supplicant =3D ctx.start_process(cmd)
 =

-        self.local_ctrl =3D '/tmp/wpas_' + str(os.getpid()) + '_' + str(ct=
rl_count)
-        ctrl_count =3D ctrl_count + 1
-        self.ctrl_sock =3D socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM)
-        self.ctrl_sock.bind(self.local_ctrl)
-
-        self.remote_ctrl =3D self.socket_path + '/' + self.ifname
-        self.wpa_supplicant.wait_for_socket(self.remote_ctrl, 2)
-        self.ctrl_sock.connect(self.remote_ctrl)
-        self.io_watch =3D GLib.io_add_watch(self.ctrl_sock, GLib.IO_IN, se=
lf._handle_data_in)
+        self.sockets =3D {}
+        self.cleanup_paths =3D []
+        self.io_watch =3D GLib.io_add_watch(self._get_socket(), GLib.IO_IN=
, self._handle_data_in)
 =

         self.p2p_peers =3D {}
         self.p2p_go_neg_requests =3D {}
@@ -173,11 +165,34 @@ class Wpas:
 =

         return True
 =

-    def _ctrl_request(self, command, timeout=3D10):
+    def _ctrl_request(self, command, ifname=3DNone):
         if type(command) is str:
             command =3D str.encode(command)
 =

-        self.ctrl_sock.send(bytes(command))
+        self._get_socket(ifname).send(bytes(command))
+
+    def _get_socket(self, ifname=3DNone):
+        global ctrl_count
+
+        if ifname is None:
+            ifname =3D self.ifname
+
+        if ifname in self.sockets:
+            return self.sockets[ifname]
+
+        local_path =3D '/tmp/wpas_' + str(os.getpid()) + '_' + str(ctrl_co=
unt)
+        ctrl_count =3D ctrl_count + 1
+        remote_path =3D self.socket_path + '/' + ifname
+
+        self.wpa_supplicant.wait_for_socket(remote_path, 2)
+        sock =3D socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM)
+        sock.bind(local_path)
+        self.cleanup_paths.append(local_path)
+        sock.connect(remote_path)
+        self.cleanup_paths.append(remote_path)
+
+        self.sockets[ifname] =3D sock
+        return sock
 =

     # Normal find phase with listen and active scan states
     def p2p_find(self):
@@ -219,6 +234,12 @@ class Wpas:
                         ('' if go_intent is None else ' go_intent=3D' + st=
r(go_intent)) + ' auth')
         self.wait_for_event('OK')
 =

+    def p2p_set(self, key, value, **kwargs):
+        self._ctrl_request('P2P_SET ' + key + ' ' + value, **kwargs)
+
+    def set(self, key, value, **kwargs):
+        self._ctrl_request('SET ' + key + ' ' + value, **kwargs)
+
     # Probably needed: remove references to self so that the GC can call _=
_del__ automatically
     def clean_up(self):
         if self.io_watch is not None:
@@ -227,16 +248,16 @@ class Wpas:
         if self.wpa_supplicant is not None:
             ctx.stop_process(self.wpa_supplicant)
             self.wpa_supplicant =3D None
+        for path in self.cleanup_paths:
+            if os.path.exists(path):
+                os.remove(path)
+        self.cleanup_paths =3D []
 =

     def _stop_wpas(self):
         self.clean_up()
-        if self.ctrl_sock:
-            self.ctrl_sock.close()
-            self.ctrl_sock =3D None
-        if os.path.exists(self.remote_ctrl):
-            os.remove(self.remote_ctrl)
-        if os.path.exists(self.local_ctrl):
-            os.remove(self.local_ctrl)
+        for ifname in self.sockets:
+            self.sockets[ifname].close()
+        self.sockets =3D {}
 =

     def __del__(self):
         self._stop_wpas()
-- =

2.30.2

--===============1180450039724200117==--

