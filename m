Content-Type: multipart/mixed; boundary="===============5423716755806246391=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/7] test-runner: use unique name for namespace output files
Date: Thu, 18 Feb 2021 12:19:31 -0800
Message-ID: <20210218201933.1406654-5-prestwoj@gmail.com>
In-Reply-To: <20210218201933.1406654-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5423716755806246391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Output files in namespaces were not handled differently and would
end up overwriting/duplicating files from the root namespace. These
are now named /tmp/<process>-<namespace>-out.
---
 tools/test-runner | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index 0649109b..f898ae1e 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -172,6 +172,11 @@ class Process:
 		self.write_fds =3D []
 		self.io_watch =3D None
 =

+		if not namespace:
+			self.output_name =3D '/tmp/%s-out' % self.name
+		else:
+			self.output_name =3D '/tmp/%s-%s-out' % (self.name, namespace)
+
 		if namespace:
 			self.args =3D ['ip', 'netns', 'exec', namespace]
 			self.args.extend(args)
@@ -181,7 +186,7 @@ class Process:
 		# (/tmp/<name>-out). If any verbose options are required this file
 		# will get an IO watch and write out any bytes to the needed FDs.
 		#
-		self.stdout =3D open('/tmp/%s-out' % self.name, 'a+')
+		self.stdout =3D open(self.output_name, 'a+')
 		self.io_position =3D self.stdout.tell()
 =

 		if ctx:
@@ -285,6 +290,8 @@ class Process:
 			for f in self.write_fds:
 				f.close()
 =

+		os.remove(self.output_name)
+
 	def kill(self, force=3DFalse):
 		print("Killing process %s" % self.args)
 =

-- =

2.26.2

--===============5423716755806246391==--

