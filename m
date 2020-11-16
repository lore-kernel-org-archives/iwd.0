Content-Type: multipart/mixed; boundary="===============4237614122066846062=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/8] test-runner: store process stdout
Date: Mon, 16 Nov 2020 14:25:09 -0800
Message-ID: <20201116222514.3486808-3-prestwoj@gmail.com>
In-Reply-To: <20201116222514.3486808-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4237614122066846062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a blocking process is started store the output in case
the caller needs it. Output will be stored in Process.out.
---
 tools/test-runner | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 97d0e32c..77b2c9fc 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -209,17 +209,27 @@ class Process:
 					self.stdout =3D sys.__stdout__
 					self.stderr =3D sys.__stderr__
 =

-		if not wait and not check:
-			self.pid =3D subprocess.Popen(self.args, stdout=3Dself.stdout, \
+
+		self.pid =3D subprocess.Popen(self.args, stdout=3Dself.stdout, \
 							stderr=3Dself.stderr, env=3Denv, \
 							cwd=3Dos.getcwd())
-			print("Starting process {}".format(self.pid.args))
-		else:
-			self.ret =3D subprocess.call(self.args, stdout=3Dself.stdout, \
-							stderr=3Dself.stderr)
-			print("%s returned %d" % (args[0], self.ret))
-			if check and self.ret !=3D 0:
-				raise subprocess.CalledProcessError(returncode=3Dself.ret, cmd=3Dself.=
args)
+
+		print("Starting process {}".format(self.pid.args))
+
+		if not wait and not check:
+			return
+
+		self.pid.wait()
+
+		self.out, _ =3D self.pid.communicate()
+		self.ret =3D self.pid.returncode
+
+		if self.out:
+			self.out =3D self.out.decode('utf-8')
+
+		print("%s returned %d" % (args[0], self.ret))
+		if check and self.ret !=3D 0:
+			raise subprocess.CalledProcessError(returncode=3Dself.ret, cmd=3Dself.a=
rgs)
 =

 	def __del__(self):
 		print("Del process %s" % self.args)
-- =

2.26.2

--===============4237614122066846062==--

