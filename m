Content-Type: multipart/mixed; boundary="===============2149827131139338208=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] test-runner: use **kwargs for start_process
Date: Tue, 15 Sep 2020 10:36:20 -0700
Message-ID: <20200915173620.513612-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2149827131139338208==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is just a more concise/pythonic way of doing function arguments.
Since Process/start_process have basically the same argument names
we can simplify and use **kwargs which will pass the named arguments
directly to Process(). This also allows us to add arguments to Process
without touching start_process if we need.
---
 tools/test-runner | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index a71b9ef6..d1e1d42c 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -465,10 +465,10 @@ class TestContext:
 		self.results =3D {}
 		self.mainloop =3D GLib.MainLoop()
 =

-	def start_process(self, args, wait=3DFalse, multi_test=3DFalse, env=3DNon=
e, check=3DFalse):
-		p =3D Process(args, wait, multi_test, env, ctx=3Dself, check=3Dcheck)
+	def start_process(self, args, **kwargs):
+		p =3D Process(args, ctx=3Dself, **kwargs)
 =

-		if not wait:
+		if not kwargs.get('wait', False):
 			self.processes.append(p)
 =

 		return p
-- =

2.26.2

--===============2149827131139338208==--

