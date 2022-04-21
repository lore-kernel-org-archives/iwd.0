Content-Type: multipart/mixed; boundary="===============4993958832782751608=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] test-runner: mount testhome rather than assume location
Date: Thu, 21 Apr 2022 16:30:52 -0700
Message-ID: <20220421233052.3710361-1-prestwoj@gmail.com>

--===============4993958832782751608==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Usually the test home directory is a git repo somewhere e.g. under
/home. But if the home directory is located under /tmp this poses
a problem since UML remounts /tmp. To handle both cases mount
the home directory explicity.
---
 tools/runner.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/runner.py b/tools/runner.py
index 7c177f1f..ac063c32 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -451,6 +451,9 @@ class QemuRunner(RunnerAbstract):
 	def prepare_environment(self):
 		mounts =3D [ MountInfo('debugfs', 'debugfs', '/sys/kernel/debug', '', 0)=
 ]
 =

+		mounts.append(MountInfo('hostfs', 'hostfs', self.args.testhome,
+					self.args.testhome, 0))
+
 		if self.args.log:
 			mounts.append(MountInfo('9p', 'logdir', self.args.log,
 					'trans=3Dvirtio,version=3D9p2000.L,msize=3D10240', 0))
-- =

2.34.1

--===============4993958832782751608==--

