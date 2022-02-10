Content-Type: multipart/mixed; boundary="===============3362749817170551093=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] test-runner: allow IWD to start with no radios
Date: Thu, 10 Feb 2022 13:29:28 -0800
Message-ID: <20220210212928.869036-1-prestwoj@gmail.com>

--===============3362749817170551093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is useful for testing hotplug scenarios
---
 tools/test-runner | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 7176deaf..17be0593 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -668,7 +668,7 @@ class Namespace:
 		self._bus =3D dbus.bus.BusConnection(address_or_type=3Dself.dbus_address)
 =

 	def start_iwd(self, config_dir =3D '/tmp', storage_dir =3D '/tmp/iwd'):
-		args =3D []
+		args =3D ['iwd', '-E']
 		iwd_radios =3D ','.join([r.name for r in self.radios if r.use =3D=3D 'iw=
d'])
 =

 		if self.args.valgrind:
@@ -676,7 +676,8 @@ class Namespace:
 					'--show-leak-kinds=3Dall',
 					'--log-file=3D/tmp/valgrind.log.%p'])
 =

-		args.extend(['iwd', '-p', iwd_radios, '-E'])
+		if iwd_radios !=3D '':
+			args.extend(['-p', iwd_radios])
 =

 		if self.is_verbose(args[0]):
 			args.append('-d')
-- =

2.34.1

--===============3362749817170551093==--

