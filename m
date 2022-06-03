Content-Type: multipart/mixed; boundary="===============8279227739888702111=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/2] test-runner: only remove /tmp files if they exist
Date: Fri, 03 Jun 2022 10:05:54 -0700
Message-ID: <20220603170554.183478-2-prestwoj@gmail.com>
In-Reply-To: 20220603170554.183478-1-prestwoj@gmail.com

--===============8279227739888702111==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This bit of code was throwing exceptions if a test cleaned up files that
test-runner was expecting to clean up. Specifically testHotspot swaps out
main.conf and PSK files many times. This led to the exception being thrown,
caught, and ignored but further on test-runner would print:

"File _X_ not cleaned up!"

Now the files will be checked if they exist before trying to remove it.
---
 tools/run-tests | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/run-tests b/tools/run-tests
index f65daf67..56f865e0 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -861,7 +861,7 @@ def post_test(ctx, to_copy):
 		for f in to_copy:
 			if os.path.isdir('/tmp/' + f):
 				shutil.rmtree('/tmp/' + f)
-			else:
+			elif os.path.exists('/tmp/' + f):
 				os.remove('/tmp/' + f)
 =

 		Process(['ip', 'link', 'set', 'lo', 'down']).wait()
-- =

2.34.1

--===============8279227739888702111==--

