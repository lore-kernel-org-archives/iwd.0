Content-Type: multipart/mixed; boundary="===============3682268057570326397=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/6] test-runner: write out separators in log files
Date: Tue, 07 Sep 2021 09:54:38 -0700
Message-ID: <20210907165439.9913-5-prestwoj@gmail.com>
In-Reply-To: <20210907165439.9913-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3682268057570326397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The test-runner logging is very basic and just dumps everything into files
per-test. This means any subtests are just appended to existing log files
which can be difficult to parse after the fact. This is especially hard
when IWD/Hostapd runs once for the entirety of the test (as opposed to
killing between tests).

This patch writes out a separator between each subtests in the form:
=3D=3D=3D=3D=3D <file>:<function> =3D=3D=3D=3D=3D

To do this all processes are now kept as weak references inside the
Process class itself. Process.write_separators() can be called which
will iterate through all running processes and write the provided
separator.

This also paves the way to remove the ctx.processes array which is more
trouble than its worth due to reference issues.

Note: For tests which start IWD this will have no effect as the separator
is written prior to the test running. For these tests though, it is
much easier to read the log files because you can clearly see when
IWD starts and exits.
---
 tools/test-runner | 47 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 1fe5e843..bd0034c2 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -27,6 +27,7 @@ from collections import namedtuple
 from time import sleep
 import dbus.mainloop.glib
 from gi.repository import GLib
+from weakref import WeakValueDictionary
 =

 libc =3D ctypes.cdll['libc.so.6']
 libc.mount.argtypes =3D (ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p=
, \
@@ -161,8 +162,14 @@ busconfig.dtd\">
 '''
 =

 class Process(subprocess.Popen):
+	processes =3D WeakValueDictionary()
 	ctx =3D None
 =

+	def __new__(cls, *args, **kwargs):
+		obj =3D super().__new__(cls)
+		cls.processes[id(obj)] =3D obj
+		return obj
+
 	def __init__(self, args, namespace=3DNone, outfile=3DNone, env=3DNone, ch=
eck=3DFalse, cleanup=3DNone):
 		self.write_fds =3D []
 		self.io_watch =3D None
@@ -212,6 +219,30 @@ class Process(subprocess.Popen):
 				raise subprocess.CalledProcessError(returncode=3Dself.returncode,
 									cmd=3Dargs)
 =

+	@staticmethod
+	def _write_io(instance, data, stdout=3DTrue):
+		for f in instance.write_fds:
+			f.write(data)
+
+			# Write out a separator so multiple process calls per
+			# test are easer to read.
+			if instance.hup:
+				f.write("Terminated: {}\n\n".format(instance.args))
+
+			f.flush()
+
+		if instance.verbose and stdout:
+			sys.__stdout__.write(data)
+			sys.__stdout__.flush()
+
+	@classmethod
+	def write_separators(cls, sep):
+		for proc in cls.processes.values():
+			if proc.killed:
+				continue
+
+			cls._write_io(proc, sep, stdout=3DFalse)
+
 	def process_io(self, source, condition):
 		if condition & GLib.IO_HUP:
 			self.hup =3D True
@@ -226,19 +257,7 @@ class Process(subprocess.Popen):
 		# Save data away in case the caller needs it (e.g. list_sta)
 		self.out +=3D data
 =

-		for f in self.write_fds:
-			f.write(data)
-
-			# Write out a separator so multiple process calls per
-			# test are easer to read.
-			if self.hup:
-				f.write("Terminated: {}\n\n".format(self.args))
-
-			f.flush()
-
-		if self.verbose:
-			sys.__stdout__.write(data)
-			sys.__stdout__.flush()
+		self._write_io(self, data)
 =

 		return True
 =

@@ -1179,6 +1198,8 @@ def start_test(ctx, subtests, rqueue):
 =

 					sys.__stdout__.flush()
 =

+					Process.write_separators("\n=3D=3D=3D=3D=3D=3D %s:%s =3D=3D=3D=3D=3D=
=3D\n\n" % (file, func))
+
 					if not skip:
 						# Run test (setUp/tearDown run automatically)
 						result =3D t()
-- =

2.31.1

--===============3682268057570326397==--

