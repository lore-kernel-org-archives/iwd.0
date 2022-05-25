Content-Type: multipart/mixed; boundary="===============9006843619455619603=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 2/6] test-runner: mount testhome rather than assume location
Date: Wed, 25 May 2022 12:37:25 -0700
Message-ID: <20220525193729.336896-2-prestwoj@gmail.com>
In-Reply-To: 20220525193729.336896-1-prestwoj@gmail.com

--===============9006843619455619603==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Usually the test home directory is a git repo somewhere e.g. under
/home. But if the home directory is located under /tmp this poses
a problem since UML remounts /tmp. To handle both cases mount
the home directory explicity.
---
 tools/runner.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/runner.py b/tools/runner.py
index 7c177f1f..5f837097 100644
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
@@ -513,6 +516,9 @@ class UmlRunner(RunnerAbstract):
 			mounts.append(MountInfo('hostfs', 'hostfs', self.args.result_parent,
 						self.args.result_parent, 0))
 =

+		mounts.append(MountInfo('hostfs', 'hostfs', self.args.testhome,
+					self.args.testhome, 0))
+
 		self._prepare_mounts(extra=3Dmounts)
 =

 		super().prepare_environment()
-- =

2.34.1

--===============9006843619455619603==--

