Content-Type: multipart/mixed; boundary="===============3070949700242665763=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] test-runner: fix valgrind after no radio change
Date: Mon, 14 Feb 2022 13:41:39 -0800
Message-ID: <20220214214139.1017355-1-prestwoj@gmail.com>

--===============3070949700242665763==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The change adding support for starting IWD with no radios ended up
breaking the valgrind option.
---
 tools/test-runner | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index 17be0593..64407a41 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -668,7 +668,7 @@ class Namespace:
 		self._bus =3D dbus.bus.BusConnection(address_or_type=3Dself.dbus_address)
 =

 	def start_iwd(self, config_dir =3D '/tmp', storage_dir =3D '/tmp/iwd'):
-		args =3D ['iwd', '-E']
+		args =3D []
 		iwd_radios =3D ','.join([r.name for r in self.radios if r.use =3D=3D 'iw=
d'])
 =

 		if self.args.valgrind:
@@ -676,6 +676,8 @@ class Namespace:
 					'--show-leak-kinds=3Dall',
 					'--log-file=3D/tmp/valgrind.log.%p'])
 =

+		args.extend(['iwd', '-E'])
+
 		if iwd_radios !=3D '':
 			args.extend(['-p', iwd_radios])
 =

-- =

2.34.1

--===============3070949700242665763==--

