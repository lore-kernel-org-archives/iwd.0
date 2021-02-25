Content-Type: multipart/mixed; boundary="===============3975792963771485343=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 11/17] test-runner: use cleanup() for start_dbus
Date: Thu, 25 Feb 2021 14:01:00 -0800
Message-ID: <20210225220106.1728411-11-prestwoj@gmail.com>
In-Reply-To: <20210225220106.1728411-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3975792963771485343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use a cleanup routine to remove the dbus_address/dbus_cfg files
---
 tools/test-runner | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index f6d7784d..fccb6233 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -615,7 +615,15 @@ class Namespace:
 				return True
 		return False
 =

-	def start_dbus(self, multi_test=3DTrue):
+	def _cleanup_dbus(self):
+		try:
+			os.remove(self.dbus_address.split('=3D')[1])
+		except:
+			pass
+
+		os.remove(self.dbus_cfg)
+
+	def start_dbus(self):
 		global dbus_count
 =

 		self.dbus_address =3D 'unix:path=3D/tmp/dbus%d' % dbus_count
@@ -628,7 +636,7 @@ class Namespace:
 			f.write('</busconfig>\n')
 =

 		p =3D self.start_process(['dbus-daemon', '--config-file=3D%s' % self.dbu=
s_cfg],
-					wait=3DFalse)
+					wait=3DFalse, cleanup=3Dself._cleanup_dbus)
 =

 		p.wait_for_socket(self.dbus_address.split('=3D')[1], wait=3D5)
 =

-- =

2.26.2

--===============3975792963771485343==--

