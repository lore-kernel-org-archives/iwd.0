Content-Type: multipart/mixed; boundary="===============6889542440513831881=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/5] test-runner: Reserve radios for wpa_supplicant
Date: Fri, 09 Oct 2020 20:08:51 +0200
Message-ID: <20201009180855.1063394-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6889542440513831881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add support for a WPA_SUPPLICANT section in  hw.conf where
'radN=3D<config_path>' lines will only reserve radios and create
interfaces for the autotest to be able to start wpa_supplicant on them,
i.e. this prevents iwd or hostapd from being started on them but doesn't
start a wpa_supplicant instance by itself.
---
 tools/test-runner | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 3b9c1854..dfad98f6 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -248,10 +248,11 @@ class Process:
 				raise Exception("Timed out waiting for socket")
 =

 class Interface:
-	def __init__(self, name, config):
+	def __init__(self, name, config, radio):
 		self.name =3D name
 		self.ctrl_interface =3D '/var/run/hostapd/' + name
 		self.config =3D config
+		self.radio =3D radio
 =

 	def __del__(self):
 		Process(['iw', 'dev', self.name, 'del'], True)
@@ -270,17 +271,15 @@ class Radio:
 		print("Removing radio %s" % self.name)
 		self.interface =3D None
 =

-	def create_interface(self, hapd):
+	def create_interface(self, config, use):
 		global intf_id
 =

 		ifname =3D 'wln%s' % intf_id
 =

 		intf_id +=3D 1
 =

-		self.interface =3D Interface(ifname, hapd.config)
-		# IWD does not use interfaces in test-runner so any created
-		# interface is assumed to be used by hostapd.
-		self.use =3D 'hostapd'
+		self.interface =3D Interface(ifname, config, self)
+		self.use =3D use
 =

 		Process(['iw', 'phy', self.name, 'interface', 'add', ifname,
 				'type', 'managed'], True)
@@ -358,7 +357,7 @@ class HostapdInstance:
 		self.radio =3D radio
 		self.config =3D config
 =

-		self.intf =3D radio.create_interface(self)
+		self.intf =3D radio.create_interface(self.config, 'hostapd')
 		self.intf.set_interface_state('up')
 =

 	def __del__(self):
@@ -473,6 +472,7 @@ class TestContext:
 		self.args =3D args
 		self.hw_config =3D None
 		self.hostapd =3D None
+		self.wpas_interfaces =3D None
 		self.cur_radio_id =3D 0
 		self.cur_iface_id =3D 0
 		self.radios =3D []
@@ -623,6 +623,14 @@ class TestContext:
 =

 		self.hostapd =3D Hostapd(self, hapd_radios, hapd_configs, radius_config)
 =

+	def start_wpas_interfaces(self):
+		if 'WPA_SUPPLICANT' not in self.hw_config:
+			return
+
+		settings =3D self.hw_config['WPA_SUPPLICANT']
+		wpas_radios =3D [rad for rad in self.radios if rad.name in settings]
+		self.wpas_interfaces =3D [rad.create_interface(settings[rad.name], 'wpas=
') for rad in wpas_radios]
+
 	def start_ofono(self):
 		sim_keys =3D self.hw_config['SETUP'].get('sim_keys', None)
 		if not sim_keys:
@@ -690,6 +698,7 @@ class TestContext:
 	def stop_test_processes(self):
 		self.radios =3D []
 		self.hostapd =3D None
+		self.wpas_interfaces =3D None
 		self.iwd_extra_options =3D None
 =

 		for p in [p for p in self.processes if p.multi_test is False]:
@@ -884,6 +893,7 @@ def pre_test(ctx, test):
 	ctx.start_dbus_monitor()
 	ctx.start_radios()
 	ctx.start_hostapd()
+	ctx.start_wpas_interfaces()
 	ctx.start_ofono()
 =

 	if ctx.args.log:
-- =

2.25.1

--===============6889542440513831881==--

