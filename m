Content-Type: multipart/mixed; boundary="===============7656341378923946184=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] test-runner: only import Hwsim/HostapdCLI once
Date: Thu, 26 Aug 2021 13:33:33 -0700
Message-ID: <20210826203333.1067317-3-prestwoj@gmail.com>
In-Reply-To: <20210826203333.1067317-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7656341378923946184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These modules only needed to be imported a single time for the entire
run of tests. This is significantly cheaper in terms of memory and
should prevent random OOM exceptions.
---
 tools/test-runner | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index b7a283d1..513af2ab 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -377,17 +377,20 @@ class VirtualRadio(Radio):
 		TODO: Using D-Bus to create and destroy radios is more desireable
 		than the command line.
 	'''
-	def __init__(self, name, config=3DNone):
+
+	def __init__(self, name, cfg=3DNone):
+		global config
+
 		self.disable_cipher =3D None
 		self.disable_iftype =3D None
 =

-		hwsim =3D importlib.import_module('hwsim').Hwsim()
+		self.hwsim =3D config.hwsim.Hwsim()
 =

-		if config:
-			self.disable_iftype =3D config.get('iftype_disable', None)
-			self.disable_cipher =3D config.get('cipher_disable', None)
+		if cfg:
+			self.disable_iftype =3D cfg.get('iftype_disable', None)
+			self.disable_cipher =3D cfg.get('cipher_disable', None)
 =

-		self._radio =3D hwsim.radios.create(name, p2p_device=3DTrue,
+		self._radio =3D self.hwsim.radios.create(name, p2p_device=3DTrue,
 					iftype_disable=3Dself.disable_iftype,
 					cipher_disable=3Dself.disable_cipher)
 =

@@ -499,8 +502,10 @@ class Hostapd:
 			self.process.wait_for_socket(hapd.intf.ctrl_interface, 30)
 =

 	def attach_cli(self):
+		global config
+
 		for hapd in self.instances:
-			hapd.cli =3D importlib.import_module('hostapd').HostapdCLI(config=3Dhap=
d.config)
+			hapd.cli =3D config.hostapd.HostapdCLI(config=3Dhapd.config)
 =

 	def _rewrite_config(self, config):
 		'''
@@ -1502,6 +1507,10 @@ def run_tests():
 	config =3D importlib.import_module('config')
 	config.ctx =3D TestContext(args)
 =

+	# Must import these after config so ctx gets set
+	config.hwsim =3D importlib.import_module('hwsim')
+	config.hostapd =3D importlib.import_module('hostapd')
+
 	if args.log:
 		mount('logdir', args.log, '9p', 0, 'trans=3Dvirtio,version=3D9p2000.L,ms=
ize=3D10240')
 		# Clear out any log files from other test runs
-- =

2.31.1

--===============7656341378923946184==--

