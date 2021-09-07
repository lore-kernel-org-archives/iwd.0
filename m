Content-Type: multipart/mixed; boundary="===============3453506288566515482=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/6] test-runner: fix process cleanup
Date: Tue, 07 Sep 2021 09:54:36 -0700
Message-ID: <20210907165439.9913-3-prestwoj@gmail.com>
In-Reply-To: <20210907165439.9913-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3453506288566515482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Processes which were not explicitly killed ended up staying around
forever because they internally held references to other objects
such as GLib IO watches or write FDs.

This shuffles some code so these objects get cleaned up both when
explititly killed and after being waited for.
---
 tools/test-runner | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 34fdb74a..fb52c57c 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -287,7 +287,23 @@ class Process(subprocess.Popen):
 	# Override wait() so it can do so non-blocking
 	def wait(self, timeout=3D10):
 		Namespace.non_block_wait(self.__wait, timeout, 1)
+		self._cleanup()
 =

+	def _cleanup(self):
+		if self.cleanup:
+			self.cleanup()
+
+		self.write_fds =3D []
+
+		if self.io_watch:
+			GLib.source_remove(self.io_watch)
+			self.io_watch =3D None
+
+		self.cleanup =3D None
+		self.killed =3D True
+
+		if self in self.ctx.processes:
+			self.ctx.processes.remove(self)
 	# Override kill()
 	def kill(self, force=3DFalse):
 		if self.killed:
@@ -306,20 +322,7 @@ class Process(subprocess.Popen):
 			dbg("Process %s did not complete in 15 seconds!" % self.name)
 			super().kill()
 =

-		if self.cleanup:
-			self.cleanup()
-
-		self.write_fds =3D []
-
-		if self.io_watch:
-			GLib.source_remove(self.io_watch)
-			self.io_watch =3D None
-
-		self.cleanup =3D None
-		self.killed =3D True
-
-		if self in self.ctx.processes:
-			self.ctx.processes.remove(self)
+		self._cleanup()
 =

 	def __str__(self):
 		return str(self.args) + '\n'
-- =

2.31.1

--===============3453506288566515482==--

