Content-Type: multipart/mixed; boundary="===============0519649471592056870=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 06/10] test-runner: write separators for transient processes
Date: Wed, 06 Apr 2022 12:14:49 -0700
Message-ID: <20220406191453.978426-6-prestwoj@gmail.com>
In-Reply-To: 20220406191453.978426-1-prestwoj@gmail.com

--===============0519649471592056870==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Many processes are not long running (e.g. hostapd_cli, ip, iw, etc)
and the separators written to log files don't show up for these which
makes debugging difficult. This is even true for IWD/Hostapd for tests
with start_iwd=3D0.

After writing separators for long running processes write them out for
any additional log files too.
---
 tools/run-tests |  5 ++++-
 tools/utils.py  | 23 ++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/run-tests b/tools/run-tests
index c4013258..78665de1 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -724,7 +724,10 @@ def start_test(ctx, subtests, rqueue):
 =

 					sys.__stdout__.flush()
 =

-					Process.write_separators("\n=3D=3D=3D=3D=3D=3D %s:%s =3D=3D=3D=3D=3D=
=3D\n\n" % (file, func))
+					name =3D os.path.basename(os.getcwd())
+
+					Process.write_separators(name, "\n=3D=3D=3D=3D=3D=3D %s:%s:%s =3D=3D=
=3D=3D=3D=3D\n\n" %
+									(name, file, func))
 =

 					if not skip:
 						# Run test (setUp/tearDown run automatically)
diff --git a/tools/utils.py b/tools/utils.py
index c2478ff2..be4c8638 100644
--- a/tools/utils.py
+++ b/tools/utils.py
@@ -131,12 +131,33 @@ class Process(subprocess.Popen):
 			sys.__stdout__.flush()
 =

 	@classmethod
-	def write_separators(cls, sep):
+	def write_separators(cls, test, sep):
+		#
+		# There are either log running processes (cls.processes) or
+		# processes that have terminated already but a log file exists
+		# on disk. We still want the separators to show for both cases
+		# so after writing separators for running processes, also
+		# write them in any additional log files.
+		#
+		nowrite =3D []
+
 		for proc in cls.processes.values():
 			if proc.killed:
 				continue
 =

 			cls._write_io(proc, sep, stdout=3DFalse)
+			nowrite.append(proc.args[0])
+
+		if cls.testargs.log:
+			logfiles =3D os.listdir('%s/%s' % (cls.testargs.log, test))
+
+			extra =3D list(set(logfiles) - set(nowrite))
+
+			for log in extra:
+				logfile =3D '%s/%s/%s' % (cls.testargs.log, test, log)
+				with open(logfile, 'a') as f:
+					f.write(sep)
+				f.close()
 =

 	def process_io(self, source, condition):
 		if condition & GLib.IO_HUP:
-- =

2.34.1

--===============0519649471592056870==--

