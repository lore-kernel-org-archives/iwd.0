Content-Type: multipart/mixed; boundary="===============3426456442894498843=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/8] auto-t: catch exceptions in post_test
Date: Mon, 16 Nov 2020 14:25:12 -0800
Message-ID: <20201116222514.3486808-6-prestwoj@gmail.com>
In-Reply-To: <20201116222514.3486808-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3426456442894498843==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/test-runner | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 610f1702..61555b77 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -945,15 +945,19 @@ def post_test(ctx, to_copy):
 	'''
 		Remove copied files, and stop test processes.
 	'''
-	for f in to_copy:
-		if os.path.isdir('/tmp/' + f):
-			shutil.rmtree('/tmp/' + f)
-		else:
-			os.remove('/tmp/' + f)
+	try:
+		for f in to_copy:
+			if os.path.isdir('/tmp/' + f):
+				shutil.rmtree('/tmp/' + f)
+			else:
+				os.remove('/tmp/' + f)
 =

-	Process(['ifconfig', 'lo', 'down'], wait=3DTrue)
+		Process(['ifconfig', 'lo', 'down'], wait=3DTrue)
+	except Exception as e:
+		print("Exception thrown in post_test")
+	finally:
+		ctx.stop_test_processes()
 =

-	ctx.stop_test_processes()
 	if ctx.args.valgrind:
 		with open('/tmp/valgrind.log', 'r') as f:
 				dbg(f.read())
-- =

2.26.2

--===============3426456442894498843==--

