Content-Type: multipart/mixed; boundary="===============5312523255476911446=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/5] test-runner: skip mounting duplicate folders
Date: Wed, 25 May 2022 12:23:26 -0700
Message-ID: <20220525192328.335557-3-prestwoj@gmail.com>
In-Reply-To: 20220525192328.335557-1-prestwoj@gmail.com

--===============5312523255476911446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the user specifies the same parent directory for several outfiles
skip mounting since it already exists. For example:

--monitor /outfiles/monitor.txt --result /outfiles/result.txt
---
 tools/runner.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/runner.py b/tools/runner.py
index 90818ef1..bf28d9ad 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -289,7 +289,13 @@ class RunnerAbstract:
 =

 	# For QEMU/UML runners
 	def _prepare_mounts(self, extra=3D[]):
+		mounted =3D []
+
 		for entry in mounts_common + extra:
+			if entry.target in mounted:
+				print("%s already mounted, skipping" % entry.target)
+				continue
+
 			try:
 				os.lstat(entry.target)
 			except:
@@ -298,6 +304,8 @@ class RunnerAbstract:
 			mount(entry.source, entry.target, entry.fstype, entry.flags,
 				entry.options)
 =

+			mounted.append(entry.target)
+
 		for entry in dev_table:
 			os.symlink(entry.target, entry.linkpath)
 =

-- =

2.34.1

--===============5312523255476911446==--

