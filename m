Content-Type: multipart/mixed; boundary="===============0556443343539188191=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 04/10] test-runner: remove unused class members
Date: Wed, 06 Apr 2022 12:14:47 -0700
Message-ID: <20220406191453.978426-4-prestwoj@gmail.com>
In-Reply-To: 20220406191453.978426-1-prestwoj@gmail.com

--===============0556443343539188191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/run-tests | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/run-tests b/tools/run-tests
index 5f405e67..92ba324a 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -343,12 +343,8 @@ class TestContext(Namespace):
 		self.hw_config =3D None
 		self.hostapd =3D None
 		self.wpas_interfaces =3D None
-		self.cur_radio_id =3D 0
-		self.cur_iface_id =3D 0
 		self.radios =3D []
-		self.loopback_started =3D False
 		self.results =3D {}
-		self.mainloop =3D GLib.MainLoop()
 		self.namespaces =3D []
 		self._last_mem_available =3D 0
 		self._mem_chart =3D BarChart()
@@ -387,7 +383,6 @@ class TestContext(Namespace):
 				rad_config =3D self.hw_config[name]
 =

 			self.radios.append(VirtualRadio(name, rad_config))
-			self.cur_radio_id +=3D 1
 =

 	def discover_radios(self):
 		import pyroute2
-- =

2.34.1

--===============0556443343539188191==--

