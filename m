Content-Type: multipart/mixed; boundary="===============3076329239674625911=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 16/17] test-runner: warn on files left after test completes
Date: Thu, 25 Feb 2021 14:01:05 -0800
Message-ID: <20210225220106.1728411-16-prestwoj@gmail.com>
In-Reply-To: <20210225220106.1728411-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3076329239674625911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/test-runner | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/test-runner b/tools/test-runner
index 412998ba..7c1498d0 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1179,6 +1179,10 @@ def post_test(ctx, to_copy):
 	finally:
 		ctx.stop_test_processes()
 =

+	allowed =3D ['phonesim.conf', 'certs', 'secrets', 'iwd']
+	for f in [f for f in os.listdir('/tmp') if f not in allowed]:
+		dbg("File %s was not cleaned up!" % f)
+
 	if ctx.args.valgrind:
 		with open('/tmp/valgrind.log', 'r') as f:
 				dbg(f.read())
@@ -1274,6 +1278,7 @@ def run_auto_tests(ctx, args):
 		finally:
 			post_test(ctx, copied)
 =

+	shutil.rmtree('/tmp/iwd')
 	shutil.rmtree('/tmp/certs')
 	shutil.rmtree('/tmp/secrets')
 	os.remove('/tmp/phonesim.conf')
-- =

2.26.2

--===============3076329239674625911==--

