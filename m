Content-Type: multipart/mixed; boundary="===============1064600032829214054=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 07/11] test-runner: start hwsim always (optionally
 --no-register)
Date: Thu, 17 Dec 2020 11:36:07 -0800
Message-ID: <20201217193611.1177006-7-prestwoj@gmail.com>
In-Reply-To: <20201217193611.1177006-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1064600032829214054==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Always start hwsim but if tests do not need radio rules start
with the --no-register option.
---
 tools/test-runner | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index d16c8885..16628399 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -675,6 +675,14 @@ class TestContext(Namespace):
 	def create_radios(self):
 		setup =3D self.hw_config['SETUP']
 		nradios =3D int(setup['num_radios'])
+		args =3D ['hwsim']
+
+		if not self.hw_config['SETUP'].get('hwsim_medium', 'yes') in ['yes', '1'=
, 'true']:
+			# register hwsim as medium
+			args.extend(['--no-register'])
+
+		self.start_process(args)
+		self.wait_for_dbus_service('net.connman.hwsim')
 =

 		for i in range(nradios):
 			name =3D 'rad%u' % i
@@ -690,10 +698,6 @@ class TestContext(Namespace):
 			self.radios.append(VirtualRadio(name, rad_config))
 			self.cur_radio_id +=3D 1
 =

-		if self.hw_config['SETUP'].get('hwsim_medium', 'yes') in ['yes', '1', 't=
rue']:
-			# register hwsim as medium
-			self.start_process(['hwsim'])
-
 	def discover_radios(self):
 		phys =3D []
 		iw =3D pyroute2.iwutil.IW()
-- =

2.26.2

--===============1064600032829214054==--

