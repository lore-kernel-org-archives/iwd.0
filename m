Content-Type: multipart/mixed; boundary="===============2779885577733069002=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 03/26] auto-t: hostapd.py: update to work with test-runner
 rewrite
Date: Thu, 10 Sep 2020 16:12:24 -0700
Message-ID: <20200910231248.4995-3-prestwoj@gmail.com>
In-Reply-To: <20200910231248.4995-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2779885577733069002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Before hostapd was initialized using the wiphy_map which has now
gone away. Instead we have a global config module which contains
a single 'ctx'. This is the centeral store for all test information.

This patch converts hostapd.py to lookup instances by already
initialized Hostapd object. The interface parameter was removed
since all tests have been converted to use config=3D instead.

In addition HostapdCLI was changed to allow no parameters if there
is only a single hostapd instance.
---
 autotests/util/hostapd.py | 100 +++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 56 deletions(-)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 0ed4e004..3f0edd9e 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -1,11 +1,11 @@
 #!/usr/bin/python3
 import os, os.path
-from wiphy import wiphy_map
 import re
 import socket
 import select
 import time
 from gi.repository import GLib
+from config import ctx
 =

 chan_freq_map =3D [
     None,
@@ -28,31 +28,26 @@ chan_freq_map =3D [
 ctrl_count =3D 0
 mainloop =3D GLib.MainLoop()
 =

-hostapd_map =3D {ifname: intf for wname, wiphy in wiphy_map.items()
-        for ifname, intf in wiphy.interface_map.items()
-        if wiphy.use =3D=3D 'hostapd'}
-
 class HostapdCLI:
-    def _init_hostapd(self, interface=3DNone, config=3DNone):
+    def _init_hostapd(self, config=3DNone):
         global ctrl_count
+        interface =3D None
+
+        if not config and len(ctx.hostapd.instances) > 1:
+            raise Exception('config must be provided if more than one host=
apd instance exists')
 =

-        if not interface and not config:
-            raise Exception('interface or config must be provided')
+        hapd =3D ctx.hostapd[config]
 =

-        if not interface:
-            for intf in hostapd_map.values():
-                if intf.config =3D=3D config:
-                    interface =3D intf
-                    break
+        self.interface =3D hapd.intf
+        self.config =3D hapd.config
 =

-        if not interface:
+        if not self.interface:
             raise Exception('config %s not found' % config)
 =

-        self.ifname =3D interface.name
-        self.socket_path =3D os.path.dirname(interface.ctrl_interface)
+        self.ifname =3D self.interface.name
+        self.socket_path =3D os.path.dirname(self.interface.ctrl_interface)
 =

-        self.cmdline =3D 'hostapd_cli -p"' + self.socket_path + '" -i"' + \
-                self.ifname + '"'
+        self.cmdline =3D ['hostapd_cli', '-p', self.socket_path, '-i', sel=
f.ifname]
 =

         if not hasattr(self, '_hostapd_restarted'):
             self._hostapd_restarted =3D False
@@ -61,6 +56,7 @@ class HostapdCLI:
                             str(ctrl_count)
         self.ctrl_sock =3D socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM)
         self.ctrl_sock.bind(self.local_ctrl)
+
         self.ctrl_sock.connect(self.socket_path + '/' + self.ifname)
 =

         if 'OK' not in self._ctrl_request('ATTACH'):
@@ -68,8 +64,8 @@ class HostapdCLI:
 =

         ctrl_count =3D ctrl_count + 1
 =

-    def __init__(self, interface=3DNone, config=3DNone):
-        self._init_hostapd(interface, config)
+    def __init__(self, config=3DNone):
+        self._init_hostapd(config)
 =

     def wait_for_event(self, event, timeout=3D10):
         global mainloop
@@ -115,53 +111,49 @@ class HostapdCLI:
 =

     def _del_hostapd(self, force=3DFalse):
         self.ctrl_sock.close()
+        os.remove(self.local_ctrl)
 =

         if self._hostapd_restarted:
-            if force:
-                os.system('killall -9 hostapd')
-            else:
-                os.system('killall hostapd')
+            ctx.stop_process(ctx.hostapd.process, force)
 =

-            os.system('ifconfig %s down' % self.ifname)
-            os.system('ifconfig %s up' % self.ifname)
+            self.interface.set_interface_state('down')
+            self.interface.set_interface_state('up')
 =

     def __del__(self):
         self._del_hostapd()
 =

     def wps_push_button(self):
-        os.system(self.cmdline + ' wps_pbc')
+        ctx.start_process(self.cmdline + ['wps_pbc'], wait=3DTrue)
 =

     def wps_pin(self, pin):
-        os.system(self.cmdline + ' wps_pin any ' + pin)
+        cmd =3D self.cmdline + ['wps_pin', 'any', pin]
+        ctx.start_process(cmd, wait=3DTrue)
 =

     def deauthenticate(self, client_address):
-        os.system(self.cmdline + ' deauthenticate ' + client_address)
+        cmd =3D self.cmdline + ['deauthenticate', client_address]
+        ctx.start_process(cmd, wait=3DTrue)
 =

     def eapol_reauth(self, client_address):
         cmd =3D 'IFNAME=3D' + self.ifname + ' EAPOL_REAUTH ' + client_addr=
ess
-        s =3D socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM)
-        s.connect(self.socket_path + '/' + self.ifname)
-        s.sendall(cmd.encode('utf-8'))
-        s.close()
+        self.ctrl_sock.sendall(cmd.encode('utf-8'))
 =

     def reload(self):
         # Seemingly all three commands needed for the instance to notice
         # interface's address change
-        cmds =3D 'reload\ndisable\nenable\n'
-        proc =3D os.popen(self.cmdline, mode=3D'w')
-        lines =3D proc.write(cmds)
-        proc.close()
+        ctx.start_process(self.cmdline + ['reload'], wait=3DTrue)
+        ctx.start_process(self.cmdline + ['disable'], wait=3DTrue)
+        ctx.start_process(self.cmdline + ['enable'], wait=3DTrue)
 =

     def list_sta(self):
-        proc =3D os.popen(self.cmdline + ' list_sta')
-        lines =3D proc.read()
-        proc.close()
+        proc =3D ctx.start_process(self.cmdline + ['list_sta'])
+        proc.pid.wait()
+        lines =3D proc.pid.stdout.read().decode('utf-8')
 =

         return [line for line in lines.split('\n') if line]
 =

     def set_neighbor(self, addr, ssid, nr):
-        os.system(self.cmdline + ' set_neighbor ' + addr + ' ssid=3D\\""' =
+ ssid +
-                    '"\\" nr=3D' + nr)
+        cmd =3D self.cmdline + ['set_neighbor', addr, 'ssid=3D\\""%s"\\"' =
% ssid, 'nr=3D%s' % nr]
+        ctx.start_process(cmd, wait=3DTrue)
 =

     def send_bss_transition(self, device, nr_list):
         # Send a BSS transition to a station (device). nr_list should be an
@@ -170,7 +162,7 @@ class HostapdCLI:
         # consistent with the set_neighbor() API, i.e. the same neighbor r=
eport
         # string could be used in both API's.
         pref =3D 1
-        cmd =3D self.cmdline + ' bss_tm_req ' + device
+        cmd =3D self.cmdline + ['bss_tm_req', device]
         for i in nr_list:
             addr =3D i[0]
             nr =3D i[1]
@@ -180,19 +172,15 @@ class HostapdCLI:
             chan_num=3Dnr[10:12]
             phy_num=3Dnr[14:16]
 =

-            cmd +=3D ' pref=3D%s neighbor=3D%s,%s,%s,%s,%s' % \
-                    (str(pref), addr, bss_info, op_class, chan_num, phy_nu=
m)
+            cmd +=3D ['pref=3D%s' % str(pref), 'neighbor=3D%s,%s,%s,%s,%s'=
 % \
+                        (addr, bss_info, op_class, chan_num, phy_num)]
             pref +=3D 1
 =

-        os.system(cmd)
-
-    @staticmethod
-    def kill_all():
-        os.system('killall hostapd')
+        ctx.start_process(cmd, wait=3DTrue)
 =

     def get_config_value(self, key):
         # first find the right config file
-        with open(hostapd_map[self.ifname].config, 'r') as f:
+        with open(self.config, 'r') as f:
             # read in config file and search for key
             cfg =3D f.read()
             match =3D re.search(r'%s=3D.*' % key, cfg)
@@ -200,6 +188,7 @@ class HostapdCLI:
                 return match.group(0).split('=3D')[1]
         return None
 =

+
     def get_freq(self):
         return chan_freq_map[int(self.get_config_value('channel'))]
 =

@@ -209,21 +198,20 @@ class HostapdCLI:
         '''
         # set flag so hostapd can be killed after the test
         self._hostapd_restarted =3D True
-        intf =3D hostapd_map[self.ifname]
 =

         self._del_hostapd(force=3DTrue)
 =

-        os.system('hostapd -g %s -i %s %s &' %
-                  (intf.ctrl_interface, intf.name, intf.config))
+        ctx.start_hostapd()
 =

         # Give hostapd a second to start and initialize the control interf=
ace
         time.sleep(1)
 =

         # New hostapd process, so re-init
-        self._init_hostapd(intf)
+        self._init_hostapd(config=3Dself.config)
 =

     def req_beacon(self, addr, request):
         '''
             Send a RRM Beacon request
         '''
-        os.system(self.cmdline + ' req_beacon ' + addr + ' ' + request)
+        cmd =3D self.cmdline + ['req_beacon', addr, request]
+        ctx.start_process(cmd, wait=3DTrue)
-- =

2.26.2

--===============2779885577733069002==--

