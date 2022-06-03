Content-Type: multipart/mixed; boundary="===============7679034420027780456=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] test-runner: allow regex for verbose option
Date: Fri, 03 Jun 2022 16:12:01 -0700
Message-ID: <20220603231201.242500-1-prestwoj@gmail.com>

--===============7679034420027780456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The glob match was completely broken for --verbose because globs
are actually path matches, not generally for strings. Instead
match based on regular expressions.

First the verbose option was fixed to store it as an array as well
as write any list arguments into the kernel command line properly
(str() would include []). This has worked up until now because the
'in' keyword in python will work on strings just as well
as lists, for example:

>>> 'test' in 'this,is,a,test'
True

Then, the glob match was replaced with a regex match. Any exceptions
are caught and somewhat ignored (printed, but only seen with --debug).
This only guards against fatal exceptions from a user passing an
invalid expression.
---
 tools/runner.py |  7 +++++--
 tools/utils.py  | 11 +++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/runner.py b/tools/runner.py
index ccc931ff..2ce26de0 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -72,7 +72,10 @@ class RunnerNamespace(Namespace):
 			if v in [None, False, [], '']:
 				continue
 =

-			ret +=3D '%s=3D%s ' % (k, str(v))
+			if type(v) is list:
+				ret +=3D '%s=3D%s ' % (k, ','.join(v))
+			else:
+				ret +=3D '%s=3D%s ' % (k, str(v))
 =

 		return ret.strip()
 =

@@ -89,7 +92,7 @@ class RunnerCoreArgParse(ArgumentParser):
 				default=3DNone,
 				type=3Dos.path.abspath)
 		self.add_argument('--verbose', '-v', metavar=3D'<list>',
-				type=3Dstr,
+				type=3Dlambda x: x.split(','),
 				help=3D'Comma separated list of applications',
 				dest=3D'verbose',
 				default=3D[])
diff --git a/tools/utils.py b/tools/utils.py
index 55db4227..d16f221f 100644
--- a/tools/utils.py
+++ b/tools/utils.py
@@ -8,7 +8,7 @@ import dbus
 =

 from gi.repository import GLib
 from weakref import WeakValueDictionary
-from glob import glob
+from re import match
 =

 from runner import RunnerCoreArgParse
 =

@@ -95,10 +95,13 @@ class Process(subprocess.Popen):
 		if process =3D=3D 'valgrind' and 'iwd' in Process.testargs.verbose:
 			return True
 =

-		# Handle any glob matches
+		# Handle any regex matches
 		for item in Process.testargs.verbose:
-			if process in glob(item):
-				return True
+			try:
+				if match(item, process):
+					return True
+			except Exception as e:
+				print("%s is not a valid regex" % item)
 =

 		return False
 =

-- =

2.34.1

--===============7679034420027780456==--

