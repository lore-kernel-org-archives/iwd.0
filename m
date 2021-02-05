Content-Type: multipart/mixed; boundary="===============4730412005586262055=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] test-runner: clean up temporary files
Date: Fri, 05 Feb 2021 15:53:06 -0800
Message-ID: <20210205235308.345635-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4730412005586262055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/test-runner | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/test-runner b/tools/test-runner
index a9b13aa8..6fd4dd1f 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -497,6 +497,8 @@ class Namespace:
 			print("Killing process %s" % p.name)
 			self.stop_process(p)
 =

+		os.remove(self.dbus_address.split('=3D')[0])
+
 	def __del__(self):
 		print("Removing namespace %s" % self.name)
 		self.reset()
@@ -1168,6 +1170,10 @@ def run_auto_tests(ctx, args):
 		finally:
 			post_test(ctx, copied)
 =

+	shutil.rmtree('/tmp/certs')
+	shutil.rmtree('/tmp/secrets')
+	os.remove('/tmp/phonesim.conf')
+
 	# Write out kernel log
 	if ctx.args.log:
 		Process(["dmesg"], ctx=3Dctx, wait=3DTrue)
-- =

2.26.2

--===============4730412005586262055==--

