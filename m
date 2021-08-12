Content-Type: multipart/mixed; boundary="===============0206867645415315065=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 03/18] test-runner: don't fatally exit on bad test
 configuration
Date: Thu, 12 Aug 2021 13:21:52 -0700
Message-ID: <20210812202207.737053-3-prestwoj@gmail.com>
In-Reply-To: <20210812202207.737053-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0206867645415315065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a test has no hw.conf file test-runner was fully exiting and not
running any additional tests. This shouldn't happen in practice
since all upstreamed tests should run, but if any locally created
tests existed like this, it would cause the entire test run to exit
early.

Instead raise an exception which bails out of only that test, and
allows the rest to continue.
---
 tools/test-runner | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 7e789dd7..939efa51 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1072,8 +1072,7 @@ def pre_test(ctx, test, copied):
 =

 	dbg("Starting test %s" % test)
 	if not os.path.exists(test + '/hw.conf'):
-		print("No hw.conf found for %s" % test)
-		exit()
+		raise Exception("No hw.conf found for %s" % test)
 =

 	ctx.hw_config =3D ConfigParser()
 	ctx.hw_config.read(test + '/hw.conf')
-- =

2.31.1

--===============0206867645415315065==--

