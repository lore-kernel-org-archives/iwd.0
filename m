Content-Type: multipart/mixed; boundary="===============4648079919967345074=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/6] test-runner: start HostapdCLI from test-runner
Date: Thu, 12 Aug 2021 16:12:30 -0700
Message-ID: <20210812231233.747743-3-prestwoj@gmail.com>
In-Reply-To: <20210812231233.747743-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4648079919967345074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This gives the benefit of test-runner itself having access to
the CLI, e.g. for getting status information.
---
 autotests/util/hostapd.py | 32 +++++++++++++++++++++++++++++---
 tools/test-runner         | 14 ++++++++++++++
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index f75dbe6b..1575d832 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -42,6 +42,24 @@ class HostapdCLI:
 =

         hapd =3D ctx.hostapd[config]
 =

+        if not hasattr(self, '_hostapd_restarted'):
+            self._hostapd_restarted =3D False
+
+        #
+        # TODO: In theory some type of instance singleton could be created=
 for
+        #       HostapdCLI where test-runner initializes but any subsequent
+        #       call to HostapdCLI (with the same config) returns the same
+        #       object that test-runner has. This would avoid setting these
+        #       variables.
+        #
+        if hapd.cli:
+            self.ifname =3D hapd.cli.ifname
+            self.ctrl_sock =3D hapd.cli.ctrl_sock
+            self.cmdline =3D hapd.cli.cmdline
+            self.interface =3D hapd.intf
+            self.config =3D hapd.config
+            return
+
         self.interface =3D hapd.intf
         self.config =3D hapd.config
 =

@@ -53,9 +71,6 @@ class HostapdCLI:
 =

         self.cmdline =3D ['hostapd_cli', '-p', self.socket_path, '-i', sel=
f.ifname]
 =

-        if not hasattr(self, '_hostapd_restarted'):
-            self._hostapd_restarted =3D False
-
         self.local_ctrl =3D '/tmp/hostapd_' + str(os.getpid()) + '_' + \
                             str(ctrl_count)
         self.ctrl_sock =3D socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM)
@@ -244,3 +259,14 @@ class HostapdCLI:
         bssid =3D [x for x in status if x.startswith('bssid')]
         bssid =3D bssid[0].split('=3D')
         return bssid[1]
+
+    @property
+    def frequency(self):
+        cmd =3D self.cmdline + ['status']
+        status =3D ctx.start_process(cmd, wait=3DTrue, need_out=3DTrue).out
+        status =3D status.split('\n')
+
+        frequency =3D [x for x in status if x.startswith('freq')][0]
+        frequency =3D frequency.split('=3D')[1]
+
+        return int(frequency)
diff --git a/tools/test-runner b/tools/test-runner
index bfa5d803..87f6ec6d 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -428,6 +428,7 @@ class HostapdInstance:
 	def __init__(self, config, radio):
 		self.radio =3D radio
 		self.config =3D config
+		self.cli =3D None
 =

 		self.intf =3D radio.create_interface(self.config, 'hostapd')
 		self.intf.set_interface_state('up')
@@ -494,6 +495,10 @@ class Hostapd:
 =

 		self.process.wait_for_socket(self.global_ctrl_iface, 30)
 =

+	def attach_cli(self):
+		for hapd in self.instances:
+			hapd.cli =3D importlib.import_module('hostapd').HostapdCLI(config=3Dhap=
d.config)
+
 	def _rewrite_config(self, config):
 		'''
 			Replaces any $ifaceN values with the correct interface
@@ -841,6 +846,15 @@ class TestContext(Namespace):
 		radius_config =3D settings.get('radius_server', None)
 =

 		self.hostapd =3D Hostapd(self, hapd_radios, hapd_configs, radius_config)
+		self.hostapd.attach_cli()
+
+	def get_frequencies(self):
+		frequencies =3D []
+
+		for hapd in self.hostapd.instances:
+			frequencies.append(hapd.cli.frequency)
+
+		return frequencies
 =

 	def start_wpas_interfaces(self):
 		if 'WPA_SUPPLICANT' not in self.hw_config:
-- =

2.31.1

--===============4648079919967345074==--

