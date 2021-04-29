Content-Type: multipart/mixed; boundary="===============1887192932483893695=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] test-runner: fix verbose output with --valgrind
Date: Thu, 29 Apr 2021 09:07:42 -0700
Message-ID: <20210429160742.183855-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1887192932483893695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since using --valgrind actually runs IWD using the valgrind
process the --verbose flag would only work if 'valgrind' was
also specified. This was taken into account with is_verbose
but the actual logic enabling stdout did not use that helper.
This was due, in part, to logging since is_verbose will always
return true if --log is used. To fix this a new flag was added
to is_verbose which omits the --log check to handle this
specific case.
---
 tools/test-runner | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 799953de..b890b3e7 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -194,8 +194,11 @@ class Process:
 		self.io_position =3D self.stdout.tell()
 =

 		if ctx:
-			# Verbose requested, add stdout/stderr to write FD list
-			if self.name in ctx.args.verbose:
+			# Verbose requested, add stdout/stderr to write FD list.
+			# This will end up always returning true if logging is
+			# on which isn't desired so pass log=3DFalse as to only
+			# allow stdout to processes listed in --verbose.
+			if ctx.is_verbose(self.name, log=3DFalse):
 				self.verbose =3D True
 =

 			# Add output file to FD list
@@ -693,14 +696,14 @@ class Namespace:
 		pid =3D self.start_process(args, env=3Denv)
 		return pid
 =

-	def is_verbose(self, process):
+	def is_verbose(self, process, log=3DTrue):
 		process =3D os.path.basename(process)
 =

 		if self.args is None:
 			return False
 =

 		# every process is verbose when logging is enabled
-		if self.args.log:
+		if log and self.args.log:
 			return True
 =

 		if process in self.args.verbose:
-- =

2.26.2

--===============1887192932483893695==--

