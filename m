Content-Type: multipart/mixed; boundary="===============1747302157981249081=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/7] test-runner: clear log dir before new log test run
Date: Thu, 18 Feb 2021 12:19:28 -0800
Message-ID: <20210218201933.1406654-2-prestwoj@gmail.com>
In-Reply-To: <20210218201933.1406654-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1747302157981249081==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The log dir was never being cleaned out prior to a new logging
test run. This could leave old stale files around. Note that this
will remove any past log files so if you need them, you want to
make a copy before running test-runner with --log again.
---
 tools/test-runner | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/test-runner b/tools/test-runner
index 70694e47..a390014b 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1249,6 +1249,14 @@ def run_tests():
 =

 	if args.log:
 		mount('logdir', args.log, '9p', 0, 'trans=3Dvirtio,version=3D9p2000.L')
+		# Clear out any log files from other test runs
+		for f in glob('%s/*' % args.log):
+			print("removing %s" % f)
+
+			if os.path.isdir(f):
+				shutil.rmtree(f)
+			else:
+				os.remove(f)
 	elif args.monitor:
 		parent =3D os.path.abspath(os.path.join(args.monitor, os.pardir))
 		mount('mondir', parent, '9p', 0, 'trans=3Dvirtio,version=3D9p2000.L')
-- =

2.26.2

--===============1747302157981249081==--

