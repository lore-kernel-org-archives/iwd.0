Content-Type: multipart/mixed; boundary="===============2497495174697203743=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 3/6] test-runner: disallow result/monitor/log directly
 under /tmp
Date: Wed, 25 May 2022 12:37:26 -0700
Message-ID: <20220525193729.336896-3-prestwoj@gmail.com>
In-Reply-To: 20220525193729.336896-1-prestwoj@gmail.com

--===============2497495174697203743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Inside the virtual environments /tmp is mounted as its own FS and not
taken from the host. This poses issues if any output files are directly
under /tmp since test-runner tries to mount the parent directory (/tmp).
The can be fixed by ensuring these output files are either not under
/tmp or at least one folder down the tree (e.g. /tmp/outputs/outfile.txt).

Now this requirement is enforced and test-runner will not start if any
output files parent directory is /tmp.
---
 tools/runner.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/runner.py b/tools/runner.py
index 5f837097..90818ef1 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -311,6 +311,9 @@ class RunnerAbstract:
 		gid =3D int(os.environ.get('SUDO_GID', os.getgid()))
 =

 		if self.args.log:
+			if self.args.log =3D=3D '/tmp':
+				raise Exception('Log directly cannot be /tmp')
+
 			append_gid_uid =3D True
 =

 			if not os.path.exists(self.args.log):
@@ -324,12 +327,16 @@ class RunnerAbstract:
 =

 			self.args.monitor_parent =3D os.path.abspath(
 						os.path.join(self.args.monitor, os.pardir))
+			if self.args.monitor_parent =3D=3D '/tmp':
+				raise Exception('--monitor cannot be directly under /tmp')
 =

 		if self.args.result:
 			append_gid_uid =3D True
 =

 			self.args.result_parent =3D os.path.abspath(
 						os.path.join(self.args.result, os.pardir))
+			if self.args.result_parent =3D=3D '/tmp':
+				raise Exception('--result cannot be directly under /tmp')
 =

 		if append_gid_uid:
 			self.args.SUDO_UID =3D uid
-- =

2.34.1

--===============2497495174697203743==--

