Content-Type: multipart/mixed; boundary="===============2868883829129012679=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/8] test-runner: Reserve radios for wpa_supplicant
Date: Tue, 29 Sep 2020 18:37:10 +0200
Message-ID: <20200929163717.754459-7-andrew.zaborowski@intel.com>
In-Reply-To: <20200929163717.754459-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2868883829129012679==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the "wpa_supplicant_radios=3D<radio_name_list>" option in hw.conf's
SETUP section that only reserves radios for the autotest to be able to
start wpa_supplicant on them, i.e. prevents iwd or hostapd from being
started on them.
---
 tools/test-runner | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 6443af15..f2b75bc0 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -270,10 +270,8 @@ class Radio:
 =

 		intf_id +=3D 1
 =

-		self.interface =3D Interface(ifname, hapd.config)
-		# IWD does not use interfaces in test-runner so any created
-		# interface is assumed to be used by hostapd.
-		self.use =3D 'hostapd'
+		self.interface =3D Interface(ifname, hapd.config if hapd else None)
+		self.use =3D 'hostapd' if hapd else 'other'
 =

 		Process(['iw', 'phy', self.name, 'interface', 'add', ifname,
 				'type', 'managed'], True)
@@ -466,6 +464,7 @@ class TestContext:
 		self.args =3D args
 		self.hw_config =3D None
 		self.hostapd =3D None
+		self.wpas_interfaces =3D None
 		self.cur_radio_id =3D 0
 		self.cur_iface_id =3D 0
 		self.radios =3D []
@@ -609,6 +608,15 @@ class TestContext:
 =

 		self.hostapd =3D Hostapd(self, hapd_radios, hapd_configs, radius_config)
 =

+	def start_wpas_interfaces(self):
+		if 'wpa_supplicant_radios' not in self.hw_config['SETUP']:
+			return
+
+		setting =3D self.hw_config['SETUP']['wpa_supplicant_radios']
+		wpas_radio_names =3D [name.strip() for name in setting.split(',')]
+		wpas_radios =3D [rad for rad in self.radios if rad.name in wpas_radio_na=
mes]
+		self.wpas_interfaces =3D [rad.create_interface(None) for rad in wpas_rad=
ios]
+
 	def start_ofono(self):
 		sim_keys =3D self.hw_config['SETUP'].get('sim_keys', None)
 		if not sim_keys:
@@ -676,6 +684,7 @@ class TestContext:
 	def stop_test_processes(self):
 		self.radios =3D []
 		self.hostapd =3D None
+		self.wpas_interfaces =3D None
 		self.iwd_extra_options =3D None
 =

 		for p in [p for p in self.processes if p.multi_test is False]:
@@ -870,6 +879,7 @@ def pre_test(ctx, test):
 	ctx.start_dbus_monitor()
 	ctx.start_radios()
 	ctx.start_hostapd()
+	ctx.start_wpas_interfaces()
 	ctx.start_ofono()
 =

 	if ctx.hw_config.has_option('SETUP', 'start_iwd'):
-- =

2.25.1

--===============2868883829129012679==--

