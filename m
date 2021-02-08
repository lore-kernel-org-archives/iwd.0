Content-Type: multipart/mixed; boundary="===============5816533944758392895=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] test-runner: clean up dbus path file properly
Date: Mon, 08 Feb 2021 09:53:59 -0800
Message-ID: <20210208175359.573258-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5816533944758392895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dbus should be started as a multi-test process from the
TestContext, which leaves the dbus address file around for
the full test run. For Namespaces dbus-daemon should be
closed when the Namespace closes.
---
 tools/test-runner | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index d50d3abd..965b0a57 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -474,6 +474,7 @@ class Namespace:
 	dbus_address =3D None
 	processes =3D []
 	radios =3D []
+	dbus_pid =3D None
 =

 	def __init__(self, args, name, radios):
 		self.name =3D name
@@ -484,7 +485,7 @@ class Namespace:
 		for r in radios:
 			Process(['iw', 'phy', r.name, 'set', 'netns', 'name', name], wait=3DTru=
e)
 =

-		self.start_dbus(multi_test=3DFalse)
+		self.dbus_pid =3D self.start_dbus(multi_test=3DFalse)
 =

 	def reset(self):
 		self.radios =3D []
@@ -497,7 +498,8 @@ class Namespace:
 			print("Killing process %s" % p.name)
 			self.stop_process(p)
 =

-		os.remove(self.dbus_address.split('=3D')[1])
+		if self.dbus_pid and not self.dbus_pid.multi_test:
+			os.remove(self.dbus_address.split('=3D')[1])
 =

 	def __del__(self):
 		print("Removing namespace %s" % self.name)
@@ -1119,7 +1121,7 @@ def print_results(results):
 def run_auto_tests(ctx, args):
 	tests =3D build_test_list(args)
 =

-	ctx.start_dbus()
+	ctx.start_dbus(multi_test=3DTrue)
 	ctx.start_haveged()
 =

 	# Copy autotests/misc/{certs,secrets,phonesim} so any test can refer to t=
hem
-- =

2.26.2

--===============5816533944758392895==--

