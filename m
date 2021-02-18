Content-Type: multipart/mixed; boundary="===============3341909793661560746=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/7] test-runner: fix start_dbus and clean up config
Date: Thu, 18 Feb 2021 12:19:33 -0800
Message-ID: <20210218201933.1406654-7-prestwoj@gmail.com>
In-Reply-To: <20210218201933.1406654-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3341909793661560746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

start_dbus was not returning the Process class which was
expected by the caller. This resulted in the config not
being cleaned up.
---
 tools/test-runner | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index c9f624d4..662931b1 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -553,7 +553,7 @@ class Namespace:
 			self.stop_process(p)
 =

 		if self.dbus_pid and not self.dbus_pid.multi_test:
-			os.remove(self.dbus_address.split('=3D')[1])
+			os.remove(self.dbus_cfg)
 =

 	def __del__(self):
 		print("Removing namespace %s" % self.name)
@@ -598,21 +598,23 @@ class Namespace:
 		global dbus_count
 =

 		self.dbus_address =3D 'unix:path=3D/tmp/dbus%d' % dbus_count
-		dbus_cfg =3D '/tmp/dbus%d.conf' % dbus_count
+		self.dbus_cfg =3D '/tmp/dbus%d.conf' % dbus_count
 		dbus_count +=3D 1
 =

-		with open(dbus_cfg, 'w+') as f:
+		with open(self.dbus_cfg, 'w+') as f:
 			f.write(dbus_config)
 			f.write('<listen>%s</listen>\n' % self.dbus_address)
 			f.write('</busconfig>\n')
 =

-		p =3D self.start_process(['dbus-daemon', '--config-file=3D%s' % dbus_cfg=
],
+		p =3D self.start_process(['dbus-daemon', '--config-file=3D%s' % self.dbu=
s_cfg],
 					wait=3DFalse, multi_test=3Dmulti_test)
 =

 		p.wait_for_socket(self.dbus_address.split('=3D')[1], wait=3D5)
 =

 		self._bus =3D dbus.bus.BusConnection(address_or_type=3Dself.dbus_address)
 =

+		return p
+
 	def start_iwd(self, config_dir =3D '/tmp', storage_dir =3D '/tmp/iwd'):
 		args =3D []
 		iwd_radios =3D ','.join([r.name for r in self.radios if r.use =3D=3D 'iw=
d'])
-- =

2.26.2

--===============3341909793661560746==--

