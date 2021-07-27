Content-Type: multipart/mixed; boundary="===============3788979193689840380=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] test-runner: set msize to remove runtime warning
Date: Tue, 27 Jul 2021 15:11:27 -0700
Message-ID: <20210727221128.33131-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3788979193689840380==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Newer QEMU version warn that msize is set too low and may result
in poor IO performance. The default is 8KiB which QEMU claims is
too low. Explicitly setting to 10KiB removes the warning:

qemu-system-x86_64: warning: 9p: degraded performance: a
reasonable high msize should be chosen on client/guest side
(chosen msize is <=3D 8192).
See https://wiki.qemu.org/Documentation/9psetup#msize for details.
---
 tools/test-runner | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index bc37b80c..98164f7a 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1364,7 +1364,7 @@ def run_tests():
 	config.ctx =3D TestContext(args)
 =

 	if args.log:
-		mount('logdir', args.log, '9p', 0, 'trans=3Dvirtio,version=3D9p2000.L')
+		mount('logdir', args.log, '9p', 0, 'trans=3Dvirtio,version=3D9p2000.L,ms=
ize=3D10240')
 		# Clear out any log files from other test runs
 		for f in glob('%s/*' % args.log):
 			print("removing %s" % f)
-- =

2.31.1

--===============3788979193689840380==--

